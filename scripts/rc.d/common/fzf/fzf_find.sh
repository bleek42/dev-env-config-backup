#!/usr/bin/env sh

# speed up script and avoid language problems by using standard c
LC_ALL=C
LANG=C

# config
w3mimgdisplay="/usr/lib/w3m/w3mimgdisplay"
preview_height=75   # in percent
font_width=10       # in pixel
font_height=19      # in pixel
padding_width=2     # in cursor
padding_height=2    # in cursor
# multiplexer padding in pixel
case "$TERM" in
    tmux* | screen*)
        multiplexer_height=$((font_height * 50 / 100))
        multiplexer_width=$((font_width * 50 / 100))
        ;;
esac

# help
script=$(basename "$0")
help="$script [-h/--help] -- script to find files with w3m image/picture preview
  Usage:
    $script <path/dir>

  Settings:
    <path/dir> = if empty, the current working directory is used

  Examples:
    $script
    $script $HOME/Pictures
    find $HOME/Pictures/ -type f | $script"

preview_pane() {
    indicator_file="$cache_folder/.text"

    # if the current or last preview is an image, clear the preview pane
    { [ -n "$1" ] || [ ! -e "$indicator_file" ]; } \
        && printf "6;%d;%d;%d;%d\n4;\n3;" \
                    "$((font_width * padding_width))" \
                    "$((font_height * padding_height))" \
                    "$((preview_width + 2))" \
                    "$((preview_height + 2))" \
                | "$w3mimgdisplay" >/dev/null 2>&1 \
        || return

    # go back if the current preview is not an image
    case "$1" in
        '')
            # create indicator file, if not exists
            [ ! -e "$indicator_file" ] \
                && touch "$indicator_file"

            return
            ;;
        *)
            # remove indicator file, if exists
            [ -e "$indicator_file" ] \
                && rm -f "$indicator_file"

            # determine image sizes
            image_size=$(printf "5;%s" "$1" | "$w3mimgdisplay" 2>/dev/null)
            image_width=${image_size%% *}
            image_height=${image_size##* }
            [ "${image_width:-0}" -gt 0 ] && [ "${image_height:-0}" -gt 0 ] \
                || return

            # generate image title for the preview
            printf "%b%sx%s · %s · %s%b\n" \
                "\033[37m" \
                "$image_width" \
                "$image_height" \
                "$(du -Hh "$source_file" | cut -f1)" \
                "$(date '+%d.%m.%Y %H:%M' -r "$source_file")" \
                "\033[0m"

            # calculate image dimensions for the preview
            width=$preview_width
            height=$preview_height

            [ "$image_height" -gt "$height" ] \
                && width=$((image_width * height / image_height)) \
                || width=$image_width

            [ "$width" -gt "$preview_width" ] \
                && width=$preview_width

            [ "$image_width" -gt "$width" ] \
                && height=$((image_height * width / image_width)) \
                || height=$image_height

            # preview image (mitigate partial previews with sleep)
            sleep .2
            printf "0;1;%d;%d;%d;%d;;;;;%s\n4;\n3;" \
                    "$((font_width * padding_width))" \
                    "$((font_height * padding_height))" \
                    "$width" \
                    "$height" \
                    "$1" \
                | $w3mimgdisplay >/dev/null 2>&1
            ;;
    esac
}

extension_preview() {
    case "$file_extension" in
        7z | a | alz | apk | arj | bz | bz2 | bzip2 | cab | cb7 | cbt | chm \
            | chw | cpio | deb | dmg | gz | gzip | hxs | iso | jar | lha | lz \
            | lzh | lzma | lzo | msi | pkg | rar | rpm | swm | tar | taz | tbz \
            | tbz2 | tgz | tlz | txz | tz2 | tzo | tzst | udf | war | wim | xar \
            | xpi | xz | z | zip | zst)
                preview_pane
                # requires compressor.sh (https://github.com/mrdotx/shell)
                compressor.sh --list "$source_file"
            ;;
        issue)
            preview_pane
            printf "%b\nhost login: _" "$(sed \
                -e 's/\\4{/INTERFACE{/g' \
                -e 's/\\4/11.11.11.11/g' \
                -e 's/\\6{/INTERFACE{/g' \
                -e 's/\\6/::ffff:0b0b:0b0b/g' \
                -e 's/\\b/38400/g' \
                -e 's/\\d/Fri Nov 11  2011/g' \
                -e 's/\\l/tty1/g' \
                -e 's/\\m/x86_64/g' \
                -e 's/\\n/host/g' \
                -e 's/\\o/(none)/g' \
                -e 's/\\O/unknown_domain/g' \
                -e 's/\\r/2.4.37-arch1-1/g' \
                -e 's/\\s/Linux/g' \
                -e 's/\\S{/VARIABLE{/g' \
                -e 's/\\S/Arch Linux/g' \
                -e 's/\\t/11:11:11/g' \
                -e 's/\\u/1/g' \
                -e 's/\\U/1 user/g' \
                -e 's/\\v/#1 SMP PREEMPT_DYNAMIC Fri, 11 Nov 2011 11:11:11 +0000/g' \
                -e 's/\\e/\\033/g' \
                "$source_file" \
            )"
            ;;
        gpg | asc)
            pass_preview() {
                printf "%s\n" "$decrypted_file" | head -n 4 \
                        | sed '1 s/^.*$/***/' \
                    && [ "$(printf "%s\n" "$decrypted_file" | wc -l)" -gt 4 ] \
                    && printf "\n***"

                exit 0
            }

            decrypted_file=$(gpg --decrypt "$source_file" 2>/dev/null) \
                || return

            preview_pane
            printf "%s\n" "$(cd "$(dirname "$source_file")" \
                    && pwd -P)/$(basename "$source_file")" \
                | grep -q "^${PASSWORD_STORE_DIR-$HOME/.password-store}" \
                    && pass_preview

            printf "%s\n" "$decrypted_file"
            ;;
        *)
            return 1
            ;;
    esac \
        && exit
}

mime_preview() {
    case "$mime_type" in
        image/x-xcf | image/x-tga)
            return 1
            ;;
        image/*)
            preview_pane "$source_file"
            ;;
        audio/* | video/*)
            cache_file="$cache_folder/$(printf "%s\n" "$source_file" \
                | sed 's/\//_/g').png"

            [ -s "$cache_file" ] \
                || ffmpegthumbnailer -i "$source_file" \
                    -o "$cache_file" -s0 >/dev/null 2>&1

            preview_pane "$cache_file"
            ;;
        font/* | *opentype)
            cache_file="$cache_folder/$(printf "%s\n" "$source_file" \
                | sed 's/\//_/g').png"

            [ -s "$cache_file" ] \
                || magick -size '960x960' xc:'#000000' \
                    -font "$source_file" \
                    -fill '#cccccc' \
                    -gravity Center \
                    -pointsize 72 \
                    -annotate +0+0 "$( \
                        printf "%s" \
                            "AÄBCDEFGHIJKLMN\n" \
                            "OÖPQRSẞTUÜVWXYZ\n" \
                            "aäbcdefghijklmn\n" \
                            "oöpqrsßtuüvwxyz\n" \
                            "1234567890,.*/+-=\%\n" \
                            "~!?@#§$&(){}[]<>;:" \
                    )" \
                    -font '' \
                    -fill '#4185d7' \
                    -gravity SouthWest \
                    -pointsize 24 \
                    -annotate +0+0 "$( \
                        fc-list \
                            | grep "$source_file" \
                            | cut -d ':' -f2 \
                            | sed 's/^ //g' \
                            | uniq \
                    )" \
                    -flatten "$cache_file" >/dev/null 2>&1

            preview_pane "$cache_file"
            ;;
        */pdf)
            cache_file="$cache_folder/$(printf "%s\n" "$source_file" \
                | sed 's/\//_/g').png"

            [ -s "$cache_file" ] \
                || pdftoppm -f 1 -l 1 \
                    -scale-to-x 960 \
                    -scale-to-y -1 \
                    -singlefile \
                    -png \
                    "$source_file" "${cache_file%.*}" >/dev/null 2>&1

            preview_pane "$cache_file"
            ;;
        */vnd.oasis.opendocument* \
            | */vnd.openxmlformats-officedocument* \
            | *ms-excel | *msword | *mspowerpoint | */rtf)
                cache_file="$cache_folder/$(printf "%s\n" "$source_file" \
                    | sed 's/\//_/g').png"

                [ -s "$cache_file" ] \
                    || (libreoffice \
                            --convert-to 'png:writer_png_Export:
                                            {
                                                "PageRange":
                                                    {
                                                        "type":"string",
                                                        "value":"1"
                                                    }
                                            }' "$source_file" \
                            --outdir "$cache_folder/" >/dev/null 2>&1 \
                        && mv "$cache_folder/$(basename "${source_file%.*}").png" \
                            "$cache_file")

                preview_pane "$cache_file"
            ;;
        */csv)
            preview_pane
            column --separator '	;,' --table "$source_file"
            ;;
        *sqlite3)
            preview_pane
            sqlite3 -readonly -header -column "$source_file" \
                "SELECT name, type
                 FROM sqlite_master
                 WHERE type IN ('table','view')
                 AND name NOT LIKE 'sqlite_%'
                 ORDER BY 1;"
            ;;
        */*html*)
            preview_pane
            w3m -dump "$source_file"
            ;;
        */x-bittorrent)
            preview_pane
            aria2c --show-files "$source_file"
            ;;
        */x-executable | */x-pie-executable | */x-sharedlib | */x-object)
            preview_pane
            readelf --wide --demangle --all "$source_file"
            ;;
        text/troff)
            preview_pane
            man "$source_file"
            ;;
        text/* | */javascript | */json | */xml | */x-wine-extension-ini)
            preview_pane
            highlight "$source_file"
            ;;
        *)
            return 1
            ;;
    esac \
        && exit
}

fallback_preview() {
    preview_pane
    printf "##### File Type Classification #####\n"
    printf "MIME-Type: %s\n" "$mime_type"
    file --dereference --brief "$source_file"
    printf "\n##### Exif information #####\n"
    exiftool "$source_file"
    exit 0
}

case $1 in
    -h | --help)
        printf "%s\n" "$help"
        exit
        ;;
    --preview)
        shift
        source_file="$1"
        cache_folder="$2"

        # file classification
        mime_type="$(file --dereference --brief --mime-type "$source_file")"
        file_extension="$(printf "%s" "${source_file##*.}" \
            | tr '[:upper:]' '[:lower:]')"

        # preview pane calculation
        # max width - padding width - multiplexer width
        preview_width=$((font_width * COLUMNS \
            - font_width * padding_width * 2
            - multiplexer_width))
        # max height * preview_height - padding height - multiplexer width
        preview_height=$((font_height * LINES \
            * preview_height / 100 \
            - font_height * padding_height * 2
            - multiplexer_height))

        # preview file
        extension_preview
        mime_preview
        fallback_preview
        ;;
    *)
        cache_folder=$(mktemp -t -d "fzf_find_cache.XXXXXX")

        # stdin for custom input
        if [ -p /dev/stdin ]; then
            cat
        else
            find "${1:-.}" -type f 2>/dev/null \
                | sed 's/^.\///' \
                | sort -fV
        fi \
            | fzf -m +s \
                --preview-label="[ $(pwd) ]" \
                --preview-window "up:$preview_height%" \
                --preview "$0 --preview {} $cache_folder"

        # move exit status after cache deletion
        error=$?
        [ -d "$cache_folder" ] \
            && rm -rf "$cache_folder"
        exit $error
        ;;
esac
