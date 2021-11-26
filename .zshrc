# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
(cat ~/.cache/wal/sequences &)
export PATH=$HOME/bin:/usr/local/bin:$PATH:.:/root/.gem/ruby/2.7.0/bin:/home/joshh/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:/opt/gradle/gradle-5.4.1/bin
export PYTHONPATH="/usr/lib/python3.9/site-packages":$PYTHONPATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
# ZSH_THEME="refined"
# ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Don't exit if <C-D> is pressed. Prevents exiting the shell by accident (e.g.
# pressing <C-D> twice).
setopt ignoreeof
setopt HIST_IGNORE_SPACE

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export FZF_BASE=/usr/bin/fzf
plugins=(git zsh-autosuggestions autoupdate colored-man-pages autoenv fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='mnvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# make C-l actually clear to reset the prompt
# also cause i need the pre-prompt exec stuff now
bindkey -s "" " clear"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias ls='ls --group-directories-first --color=auto'
alias la='ls -A'
alias sl=ls
alias ks=ls
alias rm='rm -I'
alias cb='xclip -selection clipboard'
alias pls='sudo $(fc -ln -1)'
alias cpd='echo $(fc -ln -1) | perl -pe "chomp if eof" | cb'
alias timer=termdown
alias screenkey='screenkey --scr 1 --opacity 0.1 -s small'
alias yeah=yes
alias q=" exit"
alias v=vr
alias c=lr
alias cr=lr
alias n=nvim
alias fzn='fzf | xargs nvim'
alias fns='fd Session.vim | fzf | xargs nvim -S'
alias binja=binaryninja-demo
alias lsz='du -sh * | sort -h'
alias laz='{du -sh .*; du -sh *} 2>/dev/null | sort -h'
alias updot=' ~/Documents/scripts/updatedotfiles.sh'
alias ranger='TERM=rxvt-unicode-256color ranger'

fzc() {
    file=`fzf`
    cd `echo $file | sed 's/\/[^\/]*$//'` 2>/dev/null
    nvim `echo $file | sed 's/.*\///'`
}

ns() {
    if [ -z $1 ]; then
        nvim -S Session.vim
    else
        ls "$1"*"/Session.vim" && nvim -S "./""$1""*/Session.vim"
    fi
}

sec() {
    checksec --file=$1
}

lr() {
    file=`la | rofi -dmenu -i -matching fuzzy -p "cd"`
    chpath=`pwd`
    while [ $file ]; do
        if [ -f $chpath"/$file" ]; then
            cd $chpath
            nvim $file
            return
        fi

        chpath=$chpath"/$file"
        file=`la $chpath | rofi -dmenu -i -matching fuzzy -p "cd"`
    done
    cd $chpath
}

vr() {
    if [ $1 ]; then
        nvim $1
        return
    fi
    file=`la | rofi -dmenu -i -matching fuzzy -p "nvim"`
    nvim $file
}

mkcd() {
    mkdir -p $1
    cd $1
}

manos() {
    links "https://cgi.cse.unsw.edu.au/~cs3231/18s1/os161/man/$1.html"
}

bible() {
    book="genesis"
    chapter=1
    last=1
    if [ $# -ge 2 ]; then
        book=$1
        chapter=$2
        last=$chapter
    fi

    if [ $# -ge 3 ]; then
        last=$3
    fi

    if [[ $book =~ "/" ]]; then
        IFS=\/ read -r version _ <<< "$book";
        mkdir -p "$HOME/tmp/bible/$version"
    fi

    # TODO: get rid of double spaces
    for i in {$chapter..$last}; do
        cache="$HOME/tmp/bible/$book$i"

        if [ ! -f $cache ]; then
            curl -s https://www.biblestudytools.com/$book/$i.html |
                grep "verse-number" -A2 |
                sed -E '/class=\"verse-[0-9]/d; s/.*strong>([0-9][0-9]*).*/\1/; /^--/d; s/^\s*//; s/^([[:digit:]]+)$/[1m\1[0m/; s///g' |
                perl -pe 's/ *?<sup.*?\/sup> *?/ /g; s/ *?<.*?>(.<.*?>)? *?/ /g' |
                tr '\n' ' ' |
                fold -sw 60 |
                sed -E 's/  +/ /; $s/ $/\n/' >$cache
        fi

        less $cache
    done
}

uni() {
    if [ $# -eq 1 ]; then
        cd "$HOME/Documents/UNSW/$1"
    else
        cd "$HOME/Documents/UNSW"
    fi
}

unsetopt share_history
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export EDITOR="nvim"
PATH="/home/joshh/.cargo/bin:/home/joshh/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/joshh/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/joshh/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/joshh/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/joshh/perl5"; export PERL_MM_OPT;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export MCFLY_FUZZY=true
export MCFLY_RESULTS=40
eval "$(mcfly init zsh)"
eval "$(zoxide init zsh)"
