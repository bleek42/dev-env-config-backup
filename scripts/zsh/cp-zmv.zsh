#!/usr/bin/env zsh

# autoload -Uz zmv

typeset dest_dir_path="${HOME}/Documents/dev-env-config-backup/src/Linux/Debian/Ubuntu/zsh"
typeset -a zsh_dotfiles=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.zshenv" "${HOME}/.zlogin" "${HOME}/.zlogout") # Add other dotfiles as needed

for file in "${zsh_dotfiles[@]}"; do
    # make a variable that takes the path and dot out of the dotfile and appends '.zsh' to the end (ex: $HOME/.zshrc -> zshrc.zsh)
    new_file_name="$(basename ${file})"

    new_file_name="${new_file_name#.}"

    echo "${new_file_name}"
    # "${variable#.}"

    zmv -C -f "${file}" "${dest_dir_path}/${new_file_name}.zsh"
done

# unset file
# unset zsh_dotfiles
# unset dest_dir_path
