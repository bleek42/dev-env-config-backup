#!/usr/bin/env zsh

autoload -Uz zmv


typeset dest_dir_path="src/Linux/Debian/Kali/zsh"
typeset -a zsh_dotfiles=("${HOME}/.zshrc" "${HOME}/.zprofile" "${HOME}/.zshenv" "${HOME}/.zlogin" "${HOME}/.zlogout" "${HOME}/.config/rc.d/zsh") # Add other dotfiles as needed

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
