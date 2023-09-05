## My Local Development Environment settings, configuration, customizations, etc.
### By: bleek42 + several others listed below (non-exhaustive list..!)

#### Description

A collection of various system settings, package/plugin manager lists, initial startup files, & personal preferences when working out of particular operating system / development environments with a focus on Windows & Linux, using bare-metal or using Windows Sub-System For Linux (WSL2) with consideration for the specifics or limitations that come with a given use case. I've had to setup & configure mine or others workspace several times, so this is a useful reference point for me - if nothing else - to relatively quickly & easily pluck from, or simply bootstrap everything according to my current needs (do I need to give a student of mine a good starter `~/.bash` or `~/.zshrc` file, or am I setting up a remote linux server with nothing but the terminal/shell unless I setup Xorg window with a client + much more..?) My thought process behind this is heavily informed by my experiences having to troubleshoot or configure things *just right* for myself & many others... from the trivial, *to the absolute tasks* that were time-sensitive on occasion.
My toughest challenge with this came to be after a series of defective hardware issues that occurred several times in my first 6 months learning JavaScript, as a student at a coding bootcamp. I could at one point install PostgreSQL on Windows based on memory alone, and had been forced into the nervous prospect of using Ubuntu/Xfce without a dual-boot of Windows to fallback on towards the end of the course. It only got worse towards the end, when I had no choice but to resort to an older machine that I got my hands on, but I definitely learned a lot about Linux, Bash, & the importance of incrementally improving my efficiency through it.
So this is something to show for all the time I have spent painstakingly learning, keystroking, debugging, querying GitHub or blogs, and otherwise tinkering with all kinds of different applications, terminal emulators & shell scripting languages, initial startup scripts (or ".dotfiles"), software configuration & tooling files (JSON, XML, YAML), window managers & desktop environments in Linux, as well as customizing Windows 10/11 to a lesser extent. In a broader context, I like to finely tune the things I am using, and iterate on how one can improve workflows through commandline tools like Fuzzy Finder (FZF), Shell Scripts & Plugins, utilizing good package management tools, observing security basics, etc. 
_###### If nothing else, I hope someone comes across it & takes snippets of it for their own purposes, just like I did with some of it._

#### Screen Shots

![Git-Bash-MSYS2-MINGW64](/images/msys-git-bash-neofetch.png "Git-Bash, Windows w/ OhMyPosh & NeoFetch")

![Git-Bash-MSYS2-MINGW64)](/images/git-bash-netsat-alias.png "Git-Bash, Windows w/ NETSTAT alias, tcp ports")

![WSL2-Deb-Linux](/images/kali-zsh-fzf.png "WSL2/Kali-Linux ZSH Prompt w/ FZF, completions, kill + ps output")

KDE Plasma desktop environment based from Garuda/Arch-based KDE dr4onized Linux desktop customization config.
![KDE-Arch-Garuda-Linux](/images/ "Fish in Alacritty term, KDE Plasma desktop, Garuda/Arch linux")

#### Instructions

- Clone repository
- Move Linux OR Win32 directory contents, according to the operating system you are working on
- Pick & choose from the respective OS directory what you would like
- Move the corresponding contents to where they are needed into your local system (ex:  move .bash_* scripts into your users home directory, copy & paste windows terminal JSON file onto your own, import package list file with corresponding package manager command, etc.)
- *WIP: bootstrapper / installation script that detects the type of operating system from Windows 10-11, WSL2/bare-metal, base-distro (Debian/Ubuntu, Arch, etc.)* 

#### Sources

Much of it is my own work - particularly with Bash/ZSH, Fish, lots of the configurations for VS Code, Alacritty, etc. - but there are certainly several blocks of difficult shell hackery & one-liner snippets that I have snagged, modified, or at least took some inspiration from for coming up with the different ideal setups I have split up within `lib/`, with credit due to the list below _(NOTE: non-exhaustive)_.
- [shayne/wsl2-hacks](https://github.com/shayne/wsl2-hacks)
- [Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [Freed-Wu/fzf-tab-source](https://github.com/Freed-Wu/fzf-tab-source)
- [rajasegar/alacritty-themes](https://github.com/rajasegar/alacritty-themes)
- [rochacbruno/dotfiles](https://github.com/rochacbruno/dotfiles)

###### _That's all for now..._
