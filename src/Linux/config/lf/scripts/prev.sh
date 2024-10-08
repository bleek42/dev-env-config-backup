#!/usr/bin/env bash

set -euf

exec 2>/dev/null

draw() {
    jq -nc --argjson x "$x" --argjson y "$y" \
        --argjson width "$width" --argjson height "$height" \
        --arg path "$(readlink -f -- "$1")" '
    {
      "action": "add",
      "identifier": "preview",
      "x": $x,
      "y": $y,
      "width": $width,
      "height": $height,
      "scaler": "contain",
      "scaling_position_x": 0.5,
      "scaling_position_y": 0.5,
      "path": $path
    }' >"$FIFO_UEBERZUG"
    exit 1
}

hash() {
    hash="$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f -- "$1")" | sha256sum | cut -d' ' -f1)"
    dir="$(printf '%s' "$hash" | cut -c1-2)"
    name="$(printf '%s' "$hash" | cut -c3-)"
    cache="$HOME/.cache/lf/$dir/$name"
}

cache() {
    cache="$cache.$1"
    if ! [ -f "$cache" ]; then
        dir="$(dirname -- "$cache")"
        [ -d "$dir" ] || mkdir -p -- "$dir"
        shift
        "$@"
    fi
    draw "$cache"
}

file="$1"
width="$2"
height="$3"
x="$4"
y="$5"

[ -f "$file" ] || [ -h "$file" ]

default_x="1920"
default_y="1080"

# if command -v lsd /dev/null; then
# fi
mime="$(file -Lb --mime-type -- "$file")"
case "$mime" in
*/directory)
    hash "$file"
    exec lsd -a -F --tree "$file" | bat -f -p
    ;;
application/gzip | \
    application/x-bzip2 | \
    application/x-xz | \
    application/x-lzma | \
    application/x-lz4 | \
    application/zstd | \
    application/x-snappy-framed | \
    application/x-tar | \
    application/x-gtar | \
    application/x-ustar | \
    application/zip | \
    application/x-7z-compressed | \
    application/x-rar)
    exec ouch list -t "$file"
    ;;
application/pdf)
    if [ -n "${FIFO_UEBERZUG-}" ]; then
        hash "$file"
        cache jpg \
            pdftoppm -f 1 -l 1 \
            -scale-to-x "$default_x" \
            -scale-to-y -1 \
            -singlefile \
            -jpeg \
            -- "$file" "$cache"
    else
        exec pdftotext -nopgbrk -q -- "$file" -
    fi
    ;;
image/vnd.djvu)
    if [ -n "${FIFO_UEBERZUG-}" ]; then
        hash "$file"
        cache tiff \
            ddjvu -format=tiff -quality=90 -page=1 \
            -size="${default_x}x${default_y}" "$file" "$cache.tiff"
    else
        exec djvutxt - <"$file"
    fi
    ;;
application/vnd.openxmlformats-officedocument.wordprocessingml.document | \
    application/vnd.oasis.opendocument.text | \
    application/epub+zip | \
    text/rtf)
    exec pandoc -s -t plain -- "$file"
    ;;
text/troff)
    COLUMNS="$width" man -- "$file" | col -b
    exit
    ;;
text/html)
    exec lynx -width="$width" -dump -- "$file"
    ;;
application/json)
    exec jq -C <"$file"
    ;;
text/* | application/javascript)
    exec bat -f -- "$file"
    ;;
image/svg+xml)
    if [ -n "${FIFO_UEBERZUG-}" ]; then
        hash "$file"
        cache jpg magick -- "$file" "$cache.jpg"
    fi
    ;;
image/*)
    if [ -n "${FIFO_UEBERZUG-}" ]; then
        # ueberzug doesn't handle image orientation correctly
        orientation="$(magick identify -format '%[orientation]\n' -- "${file[0]}")"
        if [ -n "$orientation" ] &&
            [ "$orientation" != Undefined ] &&
            [ "$orientation" != TopLeft ]; then
            hash "$file"
            cache jpg magick -- "${file[0]}" -auto-orient "$cache.jpg"
        else
            draw "$file"
        fi
    fi
    ;;
video/*)
    if [ -n "${FIFO_UEBERZUG-}" ]; then
        hash "$file"
        cache jpg ffmpegthumbnailer -i "$file" -o "$cache.jpg" -s 0
    fi
    ;;
esac

header="File Type Classification"
# lf incorrectly reports the width + 2
: "$((width -= 2))"
padding="$((width - ${#header}))"
len="$((padding / 2 - 2))"
if [ "$len" -gt 0 ]; then
    header=" $header "

    for ((i = 0; i < len; i++)); do
        header="─$header─"
    done

    if [ "$((padding % 2))" -eq 1 ]; then
        header="$header─"

    fi
fi
printf '\033[7m %s \033[0m\n' "$header"
file -Lb -- "$file" | fold -s -w "$width"
