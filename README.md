# Local Development Environment settings, configuration, customizations, etc.

My growing collection & point of reference to show for all the time I have spent working on shell scripts, configurations, or otherwise exploring & fine-tuning my local development environment, as well as just the operating system I am using in a broader context. Some bits & pieces also from digging around repositories & snagging bits & pieces for my ideal local development setup.

|![Git-Bash, Windows w/ OhMyPosh & NeoFetch](/images/msys-git-bash-neofetch.png " Git-Bash For Windows (MSYS:MINGW6)") |

===============================================================

|  ![WSL-Kali-FZF-kill](/images/kali-zsh-fzf.png "WSL2/Kali-Linux ZSH Prompt w/ FZF integration, completions") |

|				   |

terminal settings __(Windows Terminal, KDE Konsole, Alacritty, Kitty)__, shell scripts __(Bash, ZSH, Fish)__, customized prompts, system configuration, application preferences, JSON of all my installed applications using various package managers,
icons, & fonts complete with a (WIP: see './bootstrap.sh' in root dir) bootstrapper / installation script that detects the type of operating system from Windows 10-11, MacOS (WIP) various popular Linux distributions (Debian/Ubuntu, Arch, Fedora, etc.) + has KDE Plasma desktop environment for desktop customization config.

### A collection of all the different dotfiles, shell scripts, configurations, & personal preferences, because I don't want to lose it...

##### ... I saved it in 2 places already, so I figured I would just put it all on GitHub to make it three places, as well as work on an install script & see what happens.

##### If nothing else, I hope someone comes across it & takes snippets of it for their own purposes, just like I did with some of it.

================================================================================

#### by Brandon Leek (bleek42), with some help from forked repositories & code snippets from others (proper credits are a WIP)

#### Instructions

- Clone repository
- Move Linux OR Win32 directory contents, according to the operating system you are working on
- Pick & choose from the respective OS directory what you would like
- Move the corresponding contents to where they are needed into your local system (ex:  move .bash_* scripts into your users home directory, copy & paste windows terminal JSON file onto your own, import package list file with corresponding package manager command, etc.)
- EVENTUALLY: One will be able to simply run some sort of init shell script file in a POSIX/UNIX-like shell (such as BASH or ZSH, but probably not FISH, Powershell, NuShelll, etc.) IS A WIP....

 ======================================================================================

_That's all for now..._
