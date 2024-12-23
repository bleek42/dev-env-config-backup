#!/usr/bin/env bash

LS_COLORS='cd=1;38;2;255;184;108;48;2;40;42;54:ex=0;38;2;80;250;123:di=0;38;2;189;147;249:sg=0;38;2;241;250;140;48;2;255;121;198:*~=0;38;2;58;60;78:fi=0;38;2;248;248;242:st=0;38;2;241;250;140;48;2;139;233;253:tw=0;38;2;241;250;140;48;2;80;250;123:bd=1;38;2;255;184;108;48;2;40;42;54:so=1;38;2;241;250;140;48;2;40;42;54:ln=0;38;2;139;233;253:su=0;38;2;241;250;140;48;2;255;121;198:mh=0:or=0;38;2;255;85;85;48;2;40;42;54:rs=0;38;2;255;184;108:mi=0;38;2;255;85;85;48;2;40;42;54:pi=1;38;2;241;250;140;48;2;40;42;54:ow=0;38;2;139;233;253;48;2;40;42;54:ca=0:no=0;38;2;248;248;242:do=1;38;2;241;250;140;48;2;40;42;54:*.m=0;38;2;255;184;108:*.t=0;38;2;255;184;108:*.z=1;38;2;189;147;249:*.o=0;38;2;58;60;78:*.c=0;38;2;255;184;108:*.a=0;38;2;80;250;123:*.h=0;38;2;255;184;108:*.r=0;38;2;255;184;108:*.d=0;38;2;255;184;108:*.p=0;38;2;255;184;108:*.xz=1;38;2;189;147;249:*.py=0;38;2;255;184;108:*.cp=0;38;2;255;184;108:*.7z=1;38;2;189;147;249:*.el=0;38;2;255;184;108:*.ts=0;38;2;255;184;108:*.lo=0;38;2;58;60;78:*.cr=0;38;2;255;184;108:*.vb=0;38;2;255;184;108:*.ex=0;38;2;255;184;108:*.sh=0;38;2;255;184;108:*.ko=0;38;2;80;250;123:*.so=0;38;2;80;250;123:*.nb=0;38;2;255;184;108:*.gz=1;38;2;189;147;249:*.rm=1;38;2;255;184;108:*.ps=0;38;2;255;184;108:*.td=0;38;2;255;184;108:*.bc=0;38;2;58;60;78:*.wv=0;38;2;255;184;108:*.ml=0;38;2;255;184;108:*.mn=0;38;2;255;184;108:*.go=0;38;2;255;184;108:*.ll=0;38;2;255;184;108:*.cc=0;38;2;255;184;108:*.as=0;38;2;255;184;108:*.hi=0;38;2;58;60;78:*.rs=0;38;2;255;184;108:*.md=0;38;2;255;184;108:*.rb=0;38;2;255;184;108:*.di=0;38;2;255;184;108:*.pl=0;38;2;255;184;108:*.pp=0;38;2;255;184;108:*.cs=0;38;2;255;184;108:*.pm=0;38;2;255;184;108:*.la=0;38;2;58;60;78:*.jl=0;38;2;255;184;108:*css=0;38;2;255;184;108:*.js=0;38;2;255;184;108:*.fs=0;38;2;255;184;108:*.hs=0;38;2;255;184;108:*.kt=0;38;2;255;184;108:*.hh=0;38;2;255;184;108:*.ui=0;38;2;255;184;108:*.bz=1;38;2;189;147;249:*.gv=0;38;2;255;184;108:*.vim=0;38;2;255;184;108:*.wma=0;38;2;255;184;108:*.exs=0;38;2;255;184;108:*.csv=0;38;2;255;184;108:*.exe=0;38;2;80;250;123:*.ogg=0;38;2;255;184;108:*.mpg=1;38;2;255;184;108:*.sxi=0;38;2;255;184;108:*.otf=0;38;2;255;184;108:*.inc=0;38;2;255;184;108:*.nix=0;38;2;255;184;108:*.tcl=0;38;2;255;184;108:*.cpp=0;38;2;255;184;108:*.hxx=0;38;2;255;184;108:*.pid=0;38;2;58;60;78:*.wmv=1;38;2;255;184;108:*.svg=0;38;2;241;250;140:*.asa=0;38;2;255;184;108:*.cgi=0;38;2;255;184;108:*.rst=0;38;2;255;184;108:*.dot=0;38;2;255;184;108:*.vcd=1;38;2;189;147;249:*.blg=0;38;2;58;60;78:*.ilg=0;38;2;58;60;78:*.aif=0;38;2;255;184;108:*.vob=1;38;2;255;184;108:*.sql=0;38;2;255;184;108:*.mli=0;38;2;255;184;108:*.gif=0;38;2;241;250;140:*.rar=1;38;2;189;147;249:*.ipp=0;38;2;255;184;108:*.com=0;38;2;80;250;123:*.fsi=0;38;2;255;184;108:*.gvy=0;38;2;255;184;108:*.mp3=0;38;2;255;184;108:*.rpm=1;38;2;189;147;249:*.htc=0;38;2;255;184;108:*.bz2=1;38;2;189;147;249:*.pro=0;38;2;255;184;108:*.erl=0;38;2;255;184;108:*.dmg=1;38;2;189;147;249:*.tsx=0;38;2;255;184;108:*.epp=0;38;2;255;184;108:*.bak=0;38;2;58;60;78:*.zip=1;38;2;189;147;249:*.xml=0;38;2;255;184;108:*.fon=0;38;2;255;184;108:*.h++=0;38;2;255;184;108:*.kex=0;38;2;255;184;108:*.tmp=0;38;2;58;60;78:*.pyc=0;38;2;58;60;78:*.toc=0;38;2;58;60;78:*.xls=0;38;2;255;184;108:*.fnt=0;38;2;255;184;108:*.swp=0;38;2;58;60;78:*.tml=0;38;2;255;184;108:*.ind=0;38;2;58;60;78:*.ini=0;38;2;255;184;108:*.iso=1;38;2;189;147;249:*.ics=0;38;2;255;184;108:*.psd=0;38;2;241;250;140:*.ico=0;38;2;241;250;140:*.pyo=0;38;2;58;60;78:*.tgz=1;38;2;189;147;249:*.pps=0;38;2;255;184;108:*.pdf=0;38;2;255;184;108:*.eps=0;38;2;241;250;140:*.bib=0;38;2;255;184;108:*.bin=1;38;2;189;147;249:*.idx=0;38;2;58;60;78:*.dll=0;38;2;80;250;123:*.ps1=0;38;2;255;184;108:*.cfg=0;38;2;255;184;108:*.xmp=0;38;2;255;184;108:*.out=0;38;2;58;60;78:*.yml=0;38;2;255;184;108:*.zst=1;38;2;189;147;249:*.m4a=0;38;2;255;184;108:*.xcf=0;38;2;241;250;140:*.mp4=1;38;2;255;184;108:*.bst=0;38;2;255;184;108:*.bat=0;38;2;80;250;123:*.fsx=0;38;2;255;184;108:*.flv=1;38;2;255;184;108:*.bcf=0;38;2;58;60;78:*hgrc=0;38;2;255;184;108:*.ods=0;38;2;255;184;108:*.mir=0;38;2;255;184;108:*.apk=1;38;2;189;147;249:*.jar=1;38;2;189;147;249:*.ttf=0;38;2;255;184;108:*.htm=0;38;2;255;184;108:*.fls=0;38;2;58;60;78:*.sty=0;38;2;58;60;78:*.git=0;38;2;58;60;78:*.clj=0;38;2;255;184;108:*.deb=1;38;2;189;147;249:*.elm=0;38;2;255;184;108:*.doc=0;38;2;255;184;108:*.arj=1;38;2;189;147;249:*.sxw=0;38;2;255;184;108:*.odp=0;38;2;255;184;108:*.xlr=0;38;2;255;184;108:*.odt=0;38;2;255;184;108:*.zsh=0;38;2;255;184;108:*.bag=1;38;2;189;147;249:*.mid=0;38;2;255;184;108:*.mov=1;38;2;255;184;108:*.kts=0;38;2;255;184;108:*.bmp=0;38;2;241;250;140:*.m4v=1;38;2;255;184;108:*.sbt=0;38;2;255;184;108:*.def=0;38;2;255;184;108:*.txt=0;38;2;255;184;108:*.pod=0;38;2;255;184;108:*.pgm=0;38;2;241;250;140:*.hpp=0;38;2;255;184;108:*.c++=0;38;2;255;184;108:*.ppm=0;38;2;241;250;140:*.pkg=1;38;2;189;147;249:*.inl=0;38;2;255;184;108:*.lua=0;38;2;255;184;108:*.tbz=1;38;2;189;147;249:*.bsh=0;38;2;255;184;108:*.tex=0;38;2;255;184;108:*.tif=0;38;2;241;250;140:*TODO=1;38;2;255;184;108:*.csx=0;38;2;255;184;108:*.awk=0;38;2;255;184;108:*.cxx=0;38;2;255;184;108:*.pas=0;38;2;255;184;108:*.png=0;38;2;241;250;140:*.pbm=0;38;2;241;250;140:*.tar=1;38;2;189;147;249:*.pyd=0;38;2;58;60;78:*.rtf=0;38;2;255;184;108:*.ppt=0;38;2;255;184;108:*.mkv=1;38;2;255;184;108:*.dox=0;38;2;255;184;108:*.swf=1;38;2;255;184;108:*.aux=0;38;2;58;60;78:*.img=1;38;2;189;147;249:*.php=0;38;2;255;184;108:*.dpr=0;38;2;255;184;108:*.wav=0;38;2;255;184;108:*.bbl=0;38;2;58;60;78:*.avi=1;38;2;255;184;108:*.ltx=0;38;2;255;184;108:*.jpg=0;38;2;241;250;140:*.log=0;38;2;58;60;78:*.tbz2=1;38;2;189;147;249:*.java=0;38;2;255;184;108:*.diff=0;38;2;255;184;108:*.opus=0;38;2;255;184;108:*.make=0;38;2;255;184;108:*.lock=0;38;2;58;60;78:*.mpeg=1;38;2;255;184;108:*.jpeg=0;38;2;241;250;140:*.tiff=0;38;2;241;250;140:*.less=0;38;2;255;184;108:*.webm=1;38;2;255;184;108:*.psm1=0;38;2;255;184;108:*.flac=0;38;2;255;184;108:*.fish=0;38;2;255;184;108:*.conf=0;38;2;255;184;108:*.orig=0;38;2;58;60;78:*.h264=1;38;2;255;184;108:*.yaml=0;38;2;255;184;108:*.psd1=0;38;2;255;184;108:*.lisp=0;38;2;255;184;108:*.pptx=0;38;2;255;184;108:*.epub=0;38;2;255;184;108:*.html=0;38;2;255;184;108:*.dart=0;38;2;255;184;108:*.toml=0;38;2;255;184;108:*.docx=0;38;2;255;184;108:*.hgrc=0;38;2;255;184;108:*.rlib=0;38;2;58;60;78:*.purs=0;38;2;255;184;108:*.xlsx=0;38;2;255;184;108:*.json=0;38;2;255;184;108:*.bash=0;38;2;255;184;108:*.mdown=0;38;2;255;184;108:*.scala=0;38;2;255;184;108:*.dyn_o=0;38;2;58;60;78:*README=0;38;2;255;184;108:*.shtml=0;38;2;255;184;108:*.xhtml=0;38;2;255;184;108:*.toast=1;38;2;189;147;249:*.cache=0;38;2;58;60;78:*.patch=0;38;2;255;184;108:*.cabal=0;38;2;255;184;108:*.class=0;38;2;58;60;78:*.cmake=0;38;2;255;184;108:*.ipynb=0;38;2;255;184;108:*passwd=0;38;2;255;184;108:*.swift=0;38;2;255;184;108:*shadow=0;38;2;255;184;108:*LICENSE=0;38;2;255;184;108:*COPYING=0;38;2;255;184;108:*.dyn_hi=0;38;2;58;60;78:*.matlab=0;38;2;255;184;108:*INSTALL=0;38;2;255;184;108:*.ignore=0;38;2;255;184;108:*.gradle=0;38;2;255;184;108:*.config=0;38;2;255;184;108:*.flake8=0;38;2;255;184;108:*.groovy=0;38;2;255;184;108:*TODO.md=1;38;2;255;184;108:*setup.py=0;38;2;255;184;108:*Makefile=0;38;2;255;184;108:*Doxyfile=0;38;2;255;184;108:*TODO.txt=1;38;2;255;184;108:*.desktop=0;38;2;255;184;108:*.gemspec=0;38;2;255;184;108:*README.md=0;38;2;255;184;108:*.cmake.in=0;38;2;255;184;108:*.fdignore=0;38;2;255;184;108:*.DS_Store=0;38;2;58;60;78:*COPYRIGHT=0;38;2;255;184;108:*.markdown=0;38;2;255;184;108:*configure=0;38;2;255;184;108:*.rgignore=0;38;2;255;184;108:*.kdevelop=0;38;2;255;184;108:*README.txt=0;38;2;255;184;108:*Dockerfile=0;38;2;255;184;108:*.gitconfig=0;38;2;255;184;108:*.gitignore=0;38;2;255;184;108:*SConscript=0;38;2;255;184;108:*.scons_opt=0;38;2;58;60;78:*INSTALL.md=0;38;2;255;184;108:*CODEOWNERS=0;38;2;255;184;108:*SConstruct=0;38;2;255;184;108:*.localized=0;38;2;58;60;78:*.synctex.gz=0;38;2;58;60;78:*INSTALL.txt=0;38;2;255;184;108:*LICENSE-MIT=0;38;2;255;184;108:*.gitmodules=0;38;2;255;184;108:*.travis.yml=0;38;2;255;184;108:*Makefile.am=0;38;2;255;184;108:*Makefile.in=0;38;2;58;60;78:*MANIFEST.in=0;38;2;255;184;108:*appveyor.yml=0;38;2;255;184;108:*CONTRIBUTORS=0;38;2;255;184;108:*.fdb_latexmk=0;38;2;58;60;78:*.applescript=0;38;2;255;184;108:*configure.ac=0;38;2;255;184;108:*.clang-format=0;38;2;255;184;108:*LICENSE-APACHE=0;38;2;255;184;108:*CMakeLists.txt=0;38;2;255;184;108:*.gitattributes=0;38;2;255;184;108:*CMakeCache.txt=0;38;2;58;60;78:*CONTRIBUTORS.md=0;38;2;255;184;108:*CONTRIBUTORS.txt=0;38;2;255;184;108:*requirements.txt=0;38;2;255;184;108:*.sconsign.dblite=0;38;2;58;60;78:*package-lock.json=0;38;2;58;60;78:*.CFUserTextEncoding=0;38;2;58;60;78'

export LS_COLORS