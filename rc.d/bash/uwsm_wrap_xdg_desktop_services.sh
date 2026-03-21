#!/usr/bin/env bash

## ? Function to copy a folder and wrap Exec/TryExec commands in .desktop files
uwsm_wrap_xdg_desktop_services() {
    local src_folder="${1%/}"

    if [[ -z "$src_folder" || ! -d "$src_folder" ]]; then
        print "Usage: wrap_desktop_services <folder_path>"
        return 1
    fi

    local folder_name="${src_folder##*/}"
    local dest_folder="new_${folder_name}"

    ## ? Try to autoload zmv
    if [ "$SHELL" == "zsh" ]; then
        if autoload -Uz zmv 2>/dev/null; then
            ## * zmv loaded successfully.
            ## * Note: While zmv is available, cp -r is used here as it is the standard
            ## * and most robust tool for recursively copying entire directory trees.
            zmv -C -r "$src_folder" "$dest_folder"
        else
            ## * Fallback to standard cp if zmv fails to load
            cp -r -u "$src_folder" "$dest_folder"
        fi

        ## * Check if copy was successful
        if [[ ! -d "$dest_folder" ]]; then
            print "Error: Failed to create destination folder '$dest_folder'."
            return 1
        fi

        ## ? Enable extended globbing for recursive search (**) and null_glob to handle no matches
        setopt local_options extended_glob null_glob
    fi

    ## * Iterate over all .desktop files in the new folder
    ## * The (.) qualifier ensures we only match plain files
    for file in "$dest_folder"/**/*.desktop(.); do
        ## * Check if the file contains lines starting with Exec= or TryExec=
        if grep -qE '^(Exec|TryExec)=' "$file"; then
            ## * Create a temporary file for the modifications
            local temp_file=$(mktemp)

            ## * Use sed to insert the uwsm-app prefix
            ## * Matches start of line, Exec or TryExec, followed by =
            ## * Replaces it with the matched part + the uwsm-app string
            sed -E 's/^(Exec|TryExec)=/\1=uwsm-app -t=service -s=session.slice -- /' "$file" > "$temp_file"

            ## * Move the temp file back to the original file
            if [[ -s "$temp_file" ]]; then
                mv "$temp_file" "$file"
                print "Modified: $file"
            else
                rm "$temp_file"
                print "Error processing: $file"
            fi
        fi
    done
}

uwsm_wrap_xdg_desktop_services "$@"
