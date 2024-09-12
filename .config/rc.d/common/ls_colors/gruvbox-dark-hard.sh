#!/usr/bin/env bash

LS_COLORS='rs=0:no=0;38;2;235;219;178;48;2;29;32;33:sg=0;38;2;29;32;33;48;2;214;93;14:ln=3;38;2;131;165;152:mi=0;38;2;235;219;178;48;2;251;73;52:cd=3;38;2;250;189;47:bd=1;38;2;215;153;33:do=1;38;2;211;134;155:fi=0;38;2;235;219;178;48;2;29;32;33:so=1;38;2;177;98;134:or=3;38;2;251;73;52:ow=1;38;2;184;187;38:ex=1;38;2;184;187;38:su=0;38;2;235;219;178;48;2;204;36;29:di=0;38;2;69;133;136:mh=1:st=0;38;2;235;219;178;48;2;69;133;136:ca=0;38;2;29;32;33;48;2;204;36;29:tw=3;38;2;235;219;178;48;2;69;133;136:*~=3;38;2;102;92;84:pi=0;38;2;177;98;134:*.a=1;38;2;184;187;38:*.o=3;38;2;102;92;84:*.r=0;38;2;152;151;26:*.t=0;38;2;152;151;26:*.d=0;38;2;152;151;26:*.z=0;38;2;214;93;14:*.c=0;38;2;152;151;26:*.m=0;38;2;152;151;26:*.h=0;38;2;152;151;26:*.p=0;38;2;152;151;26:*.md=0;38;2;215;153;33:*.ll=0;38;2;152;151;26:*.as=0;38;2;152;151;26:*.ps=1;38;2;131;165;152:*.hi=3;38;2;102;92;84:*.bc=3;38;2;102;92;84:*.gv=0;38;2;152;151;26:*.cp=0;38;2;152;151;26:*.so=1;38;2;184;187;38:*.cr=0;38;2;152;151;26:*.di=0;38;2;152;151;26:*.pp=0;38;2;152;151;26:*.7z=0;38;2;214;93;14:*.py=0;38;2;152;151;26:*.sh=0;38;2;152;151;26:*.el=0;38;2;152;151;26:*.jl=0;38;2;152;151;26:*.ko=1;38;2;184;187;38:*.la=3;38;2;102;92;84:*.pm=0;38;2;152;151;26:*.rb=0;38;2;152;151;26:*.kt=0;38;2;152;151;26:*.lo=3;38;2;102;92;84:*.xz=0;38;2;214;93;14:*.vb=0;38;2;152;151;26:*.mn=0;38;2;152;151;26:*.rm=1;38;2;142;192;124:*.wv=0;38;2;104;157;106:*.hs=0;38;2;152;151;26:*.cc=0;38;2;152;151;26:*.ui=0;38;2;250;189;47:*.pl=0;38;2;152;151;26:*.js=0;38;2;152;151;26:*.ml=0;38;2;152;151;26:*.nb=0;38;2;152;151;26:*.td=0;38;2;152;151;26:*.gz=0;38;2;214;93;14:*.fs=0;38;2;152;151;26:*.rs=0;38;2;152;151;26:*.go=0;38;2;152;151;26:*.ex=0;38;2;152;151;26:*css=0;38;2;152;151;26:*.cs=0;38;2;152;151;26:*.hh=0;38;2;152;151;26:*.bz=0;38;2;214;93;14:*.ts=0;38;2;152;151;26:*.odt=1;38;2;131;165;152:*.deb=0;38;2;214;93;14:*.log=3;38;2;102;92;84:*.zsh=0;38;2;152;151;26:*.pbm=0;38;2;104;157;106:*.bin=1;38;2;254;128;25:*.aif=0;38;2;104;157;106:*.tml=0;38;2;250;189;47:*.bag=0;38;2;214;93;14:*.fls=3;38;2;102;92;84:*.sbt=0;38;2;152;151;26:*.csx=0;38;2;152;151;26:*.gif=0;38;2;104;157;106:*.txt=0;38;2;235;219;178:*.pro=3;38;2;184;187;38:*.ico=0;38;2;104;157;106:*.flv=1;38;2;142;192;124:*.mli=0;38;2;152;151;26:*.out=3;38;2;102;92;84:*.blg=3;38;2;102;92;84:*.tif=0;38;2;104;157;106:*.kex=1;38;2;131;165;152:*.epp=0;38;2;152;151;26:*TODO=0;38;2;184;187;38:*.dmg=1;38;2;254;128;25:*.apk=0;38;2;214;93;14:*.ilg=3;38;2;102;92;84:*.xmp=0;38;2;250;189;47:*hgrc=3;38;2;184;187;38:*.htc=0;38;2;152;151;26:*.clj=0;38;2;152;151;26:*.avi=1;38;2;142;192;124:*.mid=0;38;2;104;157;106:*.xlr=1;38;2;131;165;152:*.bat=1;38;2;184;187;38:*.asa=0;38;2;152;151;26:*.svg=0;38;2;104;157;106:*.ipp=0;38;2;152;151;26:*.htm=0;38;2;215;153;33:*.jar=0;38;2;214;93;14:*.tgz=0;38;2;214;93;14:*.ps1=0;38;2;152;151;26:*.tex=0;38;2;152;151;26:*.swf=1;38;2;142;192;124:*.cfg=0;38;2;250;189;47:*.m4a=0;38;2;104;157;106:*.pkg=0;38;2;214;93;14:*.otf=0;38;2;104;157;106:*.exs=0;38;2;152;151;26:*.ppt=1;38;2;131;165;152:*.git=3;38;2;102;92;84:*.ogg=0;38;2;104;157;106:*.tsx=0;38;2;152;151;26:*.zst=0;38;2;214;93;14:*.bsh=0;38;2;152;151;26:*.aux=3;38;2;102;92;84:*.mov=1;38;2;142;192;124:*.pdf=1;38;2;131;165;152:*.bak=3;38;2;102;92;84:*.pgm=0;38;2;104;157;106:*.pyo=3;38;2;102;92;84:*.wmv=1;38;2;142;192;124:*.pas=0;38;2;152;151;26:*.sxw=1;38;2;131;165;152:*.tbz=0;38;2;214;93;14:*.ods=1;38;2;131;165;152:*.cpp=0;38;2;152;151;26:*.wma=0;38;2;104;157;106:*.idx=3;38;2;102;92;84:*.bmp=0;38;2;104;157;106:*.elm=0;38;2;152;151;26:*.ppm=0;38;2;104;157;106:*.bz2=0;38;2;214;93;14:*.ics=1;38;2;131;165;152:*.nix=0;38;2;250;189;47:*.rpm=0;38;2;214;93;14:*.dox=3;38;2;184;187;38:*.gvy=0;38;2;152;151;26:*.xml=0;38;2;215;153;33:*.inc=0;38;2;152;151;26:*.zip=0;38;2;214;93;14:*.c++=0;38;2;152;151;26:*.img=1;38;2;254;128;25:*.eps=0;38;2;104;157;106:*.exe=1;38;2;184;187;38:*.psd=0;38;2;104;157;106:*.mpg=1;38;2;142;192;124:*.fsx=0;38;2;152;151;26:*.png=0;38;2;104;157;106:*.php=0;38;2;152;151;26:*.sty=3;38;2;102;92;84:*.com=1;38;2;184;187;38:*.cxx=0;38;2;152;151;26:*.dpr=0;38;2;152;151;26:*.mp4=1;38;2;142;192;124:*.wav=0;38;2;104;157;106:*.swp=3;38;2;102;92;84:*.vob=1;38;2;142;192;124:*.mp3=0;38;2;104;157;106:*.bbl=3;38;2;102;92;84:*.vcd=1;38;2;254;128;25:*.dot=0;38;2;152;151;26:*.cgi=0;38;2;152;151;26:*.erl=0;38;2;152;151;26:*.m4v=1;38;2;142;192;124:*.lua=0;38;2;152;151;26:*.mkv=1;38;2;142;192;124:*.iso=1;38;2;254;128;25:*.pyc=3;38;2;102;92;84:*.sql=0;38;2;152;151;26:*.arj=0;38;2;214;93;14:*.ltx=0;38;2;152;151;26:*.tmp=3;38;2;102;92;84:*.pps=1;38;2;131;165;152:*.inl=0;38;2;152;151;26:*.pid=3;38;2;102;92;84:*.hxx=0;38;2;152;151;26:*.kts=0;38;2;152;151;26:*.yml=0;38;2;250;189;47:*.ttf=0;38;2;104;157;106:*.vim=0;38;2;152;151;26:*.ini=0;38;2;250;189;47:*.fsi=0;38;2;152;151;26:*.fon=0;38;2;104;157;106:*.ind=3;38;2;102;92;84:*.doc=1;38;2;131;165;152:*.h++=0;38;2;152;151;26:*.toc=3;38;2;102;92;84:*.xls=1;38;2;131;165;152:*.tar=0;38;2;214;93;14:*.xcf=0;38;2;104;157;106:*.rar=0;38;2;214;93;14:*.jpg=0;38;2;104;157;106:*.sxi=1;38;2;131;165;152:*.dll=1;38;2;184;187;38:*.hpp=0;38;2;152;151;26:*.def=0;38;2;152;151;26:*.fnt=0;38;2;104;157;106:*.rtf=1;38;2;131;165;152:*.bcf=3;38;2;102;92;84:*.csv=0;38;2;215;153;33:*.mir=0;38;2;152;151;26:*.pod=0;38;2;152;151;26:*.bst=0;38;2;250;189;47:*.awk=0;38;2;152;151;26:*.tcl=0;38;2;152;151;26:*.odp=1;38;2;131;165;152:*.bib=0;38;2;250;189;47:*.rst=0;38;2;215;153;33:*.pyd=3;38;2;102;92;84:*.purs=0;38;2;152;151;26:*.html=0;38;2;215;153;33:*.hgrc=3;38;2;184;187;38:*.java=0;38;2;152;151;26:*.toml=0;38;2;250;189;47:*.psd1=0;38;2;152;151;26:*.yaml=0;38;2;250;189;47:*.psm1=0;38;2;152;151;26:*.xlsx=1;38;2;131;165;152:*.jpeg=0;38;2;104;157;106:*.flac=0;38;2;104;157;106:*.diff=0;38;2;152;151;26:*.h264=1;38;2;142;192;124:*.tbz2=0;38;2;214;93;14:*.lisp=0;38;2;152;151;26:*.mpeg=1;38;2;142;192;124:*.bash=0;38;2;152;151;26:*.json=0;38;2;250;189;47:*.opus=0;38;2;104;157;106:*.make=3;38;2;184;187;38:*.fish=0;38;2;152;151;26:*.docx=1;38;2;131;165;152:*.pptx=1;38;2;131;165;152:*.epub=1;38;2;131;165;152:*.lock=3;38;2;102;92;84:*.rlib=3;38;2;102;92;84:*.webm=1;38;2;142;192;124:*.tiff=0;38;2;104;157;106:*.conf=0;38;2;250;189;47:*.less=0;38;2;152;151;26:*.dart=0;38;2;152;151;26:*.orig=3;38;2;102;92;84:*.class=3;38;2;102;92;84:*.swift=0;38;2;152;151;26:*.cabal=0;38;2;152;151;26:*.xhtml=0;38;2;215;153;33:*shadow=0;38;2;250;189;47:*.scala=0;38;2;152;151;26:*.ipynb=0;38;2;152;151;26:*README=1;38;2;250;189;47:*.patch=0;38;2;152;151;26:*.cmake=3;38;2;184;187;38:*passwd=0;38;2;250;189;47:*.cache=3;38;2;102;92;84:*.toast=1;38;2;254;128;25:*.mdown=0;38;2;215;153;33:*.shtml=0;38;2;215;153;33:*.dyn_o=3;38;2;102;92;84:*.ignore=3;38;2;184;187;38:*INSTALL=1;38;2;250;189;47:*.gradle=0;38;2;152;151;26:*.dyn_hi=3;38;2;102;92;84:*TODO.md=0;38;2;184;187;38:*.matlab=0;38;2;152;151;26:*LICENSE=3;38;2;235;219;178:*.config=0;38;2;250;189;47:*.flake8=3;38;2;184;187;38:*COPYING=3;38;2;235;219;178:*.groovy=0;38;2;152;151;26:*Makefile=3;38;2;184;187;38:*setup.py=3;38;2;184;187;38:*.gemspec=3;38;2;184;187;38:*.desktop=0;38;2;250;189;47:*TODO.txt=0;38;2;184;187;38:*Doxyfile=3;38;2;184;187;38:*README.md=1;38;2;250;189;47:*.fdignore=3;38;2;184;187;38:*configure=3;38;2;184;187;38:*.DS_Store=3;38;2;102;92;84:*.cmake.in=3;38;2;184;187;38:*COPYRIGHT=3;38;2;235;219;178:*.markdown=0;38;2;215;153;33:*.rgignore=3;38;2;184;187;38:*.kdevelop=3;38;2;184;187;38:*INSTALL.md=1;38;2;250;189;47:*CODEOWNERS=3;38;2;184;187;38:*.scons_opt=3;38;2;102;92;84:*SConscript=3;38;2;184;187;38:*.localized=3;38;2;102;92;84:*.gitignore=3;38;2;184;187;38:*README.txt=1;38;2;250;189;47:*.gitconfig=3;38;2;184;187;38:*Dockerfile=0;38;2;250;189;47:*SConstruct=3;38;2;184;187;38:*.synctex.gz=3;38;2;102;92;84:*INSTALL.txt=1;38;2;250;189;47:*Makefile.am=3;38;2;184;187;38:*MANIFEST.in=3;38;2;184;187;38:*.gitmodules=3;38;2;184;187;38:*LICENSE-MIT=3;38;2;235;219;178:*.travis.yml=0;38;2;131;165;152:*Makefile.in=3;38;2;102;92;84:*CONTRIBUTORS=1;38;2;250;189;47:*.applescript=0;38;2;152;151;26:*appveyor.yml=0;38;2;131;165;152:*.fdb_latexmk=3;38;2;102;92;84:*configure.ac=3;38;2;184;187;38:*.clang-format=3;38;2;184;187;38:*CMakeCache.txt=3;38;2;102;92;84:*CMakeLists.txt=3;38;2;184;187;38:*LICENSE-APACHE=3;38;2;235;219;178:*.gitattributes=3;38;2;184;187;38:*CONTRIBUTORS.md=1;38;2;250;189;47:*.sconsign.dblite=3;38;2;102;92;84:*requirements.txt=3;38;2;184;187;38:*CONTRIBUTORS.txt=1;38;2;250;189;47:*package-lock.json=3;38;2;102;92;84:*.CFUserTextEncoding=3;38;2;102;92;84'

export LS_COLORS
