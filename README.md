# Local Development Environment settings, configuration, customizations, etc.
### bleek42 + several others listed below (non-exhaustive!)
A collection of (as well as a useful point of reference to pick up from..!) my preferred workspace/development environment to show for all the time I have spent learning & tweaking all of the different kinds of shells, startup scripts, software configuration & tooling files, window managers & desktop environments in Linux, or otherwise exploring & fine-tuning my local development environment, as well as just the operating system I am using in a broader context. Some bits & pieces also from digging around repositories & snagging bits & pieces for my ideal local development setup, with credit to some of the user/repos listed below.

##### Sources
- [shayne/wsl2-hacks](https://github.com/shayne/wsl2-hacks)
- [Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [Freed-Wu/fzf-tab-source](https://github.com/Freed-Wu/fzf-tab-source)
- [rajasegar/alacritty-themes](https://github.com/rajasegar/alacritty-themes)
- [rochacbruno/dotfiles](https://github.com/rochacbruno/dotfiles)

![Git-Bash-MSYS2-MINGW64](/images/msys-git-bash-neofetch.png "Git-Bash, Windows w/ OhMyPosh & NeoFetch")

![Git-Bash-MSYS2-MINGW64)](/images/git-bash-netsat-alias.png "Git-Bash, Windows w/ NETSTAT alias, tcp ports")

![WSL2-Deb-Linux](/images/kali-zsh-fzf.png "WSL2/Kali-Linux ZSH Prompt w/ FZF, completions, kill + ps output")

![KDE-Arch-Garuda-Linux](/images/ "Fish in Alacritty term, KDE Plasma desktop, Garuda/Arch linux")

##### Description
Customized terminal prompts, startup scripts using various shells across operating systems/environments (Git/Bash for Windows, ZShell WSL2 Debian/Ubuntu, Fish Garuda/Arch), plugins for ZSH with ZPlug, Fish with OhMyFish, assorted system configurations, application preferences, exports of all my installed applications using various package managers: paru, winget, pacman, scoop, apt.
*WIP: bootstrapper / installation script that detects the type of operating system from Windows 10-11, WSL2/bare-metal, base-distro (Debian/Ubuntu, Arch, etc.)* 
KDE Plasma desktop environment based from Garuda/Arch-based KDE dr4onized Linux desktop customization config.

##### If nothing else, I hope someone comes across it & takes snippets of it for their own purposes, just like I did with some of it.

#### Instructions

- Clone repository
- Move Linux OR Win32 directory contents, according to the operating system you are working on
- Pick & choose from the respective OS directory what you would like
- Move the corresponding contents to where they are needed into your local system (ex:  move .bash_* scripts into your users home directory, copy & paste windows terminal JSON file onto your own, import package list file with corresponding package manager command, etc.)
- EVENTUALLY: One will be able to simply run some sort of init shell script file in a POSIX/UNIX-like shell (such as BASH or ZSH, but probably not FISH, Powershell, NuShelll, etc.) IS A WIP....

_That's all for now..._
