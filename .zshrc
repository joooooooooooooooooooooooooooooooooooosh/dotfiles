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
# ENABLE_CORRECTION="true"

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
plugins=(git zsh-autosuggestions autoupdate colored-man-pages autoenv copybuffer)

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
alias cpd='echo $(fc -ln -1) | perl -pe "chomp if eof" | cb' # C-o now does this for current line
alias timer=termdown
alias screenkey='screenkey --scr 1 --opacity 0.1 -s small'
alias yeah=yes
alias q=" exit"
alias v=vr
alias n=nvim
alias np="nvim -p"
alias fzn='fzf | xargs nvim'
alias fzd='cd ~/Documents; fzc'
alias fns='fd Session.vim | fzf | xargs nvim -S'
alias binja=binaryninja-demo
alias lsz='du -sh * | sort -h'
alias laz='{du -sh .*; du -sh *} 2>/dev/null | sort -h'
alias updot=' ~/Documents/scripts/updatedotfiles.sh'
alias ranger='TERM=rxvt-unicode-256color ranger'
alias ra=ranger
alias m=tldr
alias c=cargo
alias top=bpytop
alias gsl='git stash && git pull && git stash pop'
alias gcom='git checkout $(git branch | {grep " main$" || echo "master"} | sed "s/* //")'
alias toggle-power-mode='~/Documents/scripts/toggle-power-mode.sh'
alias add='awk "{s+=\$1} END{print s}"'

unalias gcl
gcl() {
    [ $# -lt 1 ] && echo "err: need repo to clone" && return
    git clone "$(sed 's|.*//github.com/|git@github.com:|' <<< "$1")" &&
        cd "$(sed -E 's|(.*)\.git/?|\1|; s|.*/(.*)|\1|' <<< "$1")"
}

gw() {
    git diff $1^ $1
}

cses() {
    [ ! -f Cargo.toml ] && echo "run this from the root directory" && return
    local mytmp=$(mktemp -d)
    local task=$(basename $PWD)
    cd ..
    local week=$(basename $PWD)

    mv $task/target $mytmp
    cse $task 6991/$week/
    mv $mytmp/target $task

    cd $task
    TERM=linux ssh -t z5218547@login3.cse.unsw.edu.au "cd 6991/$week/$task; zsh -l"
}

cn() {
    cargo new $1 && cd $1
}

faketty() {
    script -qefc "$(printf "%q " "$@")" /dev/null
}

cr() {
    local output=$(perl -pe "s/\..*?$//" <<< "$1")
    gcc "$1" -o "$output"
    ./$output
}

cman() {
    apropos "$1" |
        grep '(3)' |
        less
}

clean-none-images() {
    docker image ls |
        grep "^<none>" |
        awk '{print $3}' |
        xargs docker image rm
}

tldr() {
    [ $# -lt 1 ] && { /usr/bin/tldr; return; }
    /usr/bin/tldr "$@" | less
}

swap() {
    [ $# -ne 2 ] && echo "Usage: swap [file1] [file2]" && return
    local TMPFILE=$(mktemp)
    mv "$1" "$TMPFILE" && mv "$2" "$1" && mv "$TMPFILE" "$2"
}

fzc() {
    local file=$(fzf)
    cd $(echo $file | sed 's/\/[^\/]*$//') 2>/dev/null
    nvim "$(echo "$file" | sed 's/.*\///')"
}

ns() {
    # very hacky workaround
    # to stop sessions with terminals starting in insert mode
    # TODO: modify vim-obsession to do this instead
    if [ -z "$1" ]; then
        sed -i '/unlet SessionLoad/istopinsert' Session.vim &&
            nvim -S Session.vim
    else
        if [ $(compgen -G "$1*" | wc -l) -ne 1 ]; then
            echo "Too many matches for $1:"
            compgen -G "$1*"
            return 1
        fi

        sed -i '/unlet SessionLoad/istopinsert' "./""$1"*"/Session.vim" &&
            nvim -S "./""$1""*/Session.vim"
    fi
}

sec() {
    pwn checksec --file="$1"
}

lr() {
    local file=$(la | rofi -dmenu -i -matching fuzzy -p "cd")
    local chpath=$(pwd)
    while [ "$file" ]; do
        if [ -f "$(chpath)/$file" ]; then
            cd "$chpath"
            nvim "$file"
            return
        fi

        chpath=$chpath"/$file"
        file=$(la "$chpath" | rofi -dmenu -i -matching fuzzy -p "cd")
    done
    cd "$chpath"
}

vr() {
    if [ "$1" ]; then
        nvim "$1"
        return
    fi
    nvim "$(la | rofi -dmenu -i -matching fuzzy -p 'nvim')"
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

populate_chapter() {
    local book=$1
    local chapter=$2
    local cache="$HOME/.cache/bible/$book$chapter";

    if [ ! -f "$cache" ]; then
        echo -e "[1m$chapter[0m\n" >"$cache"

        curl -s "https://www.biblestudytools.com/$book/$chapter.html" |
            grep "x-show=\"verseNumbers\"" -A3 |
            sed -E 's/>([[:digit:]]+)<\/a>/\n\1\n/' |
            sed -E '/x-show=\"verseNumbers\"/d; /^--/d; s/^\s*//; s/^([[:digit:]]+)$/[1m\1[0m/' |
            perl -pe 's/ *?<sup.*?\/sup> *?/ /g; s/ *?<.*?>(.<.*?>)? *?/ /g' |
            tr '\n' ' ' |
            sed -E 's/  +/ /g; $s/ $/\n/' |
            fold -sw 60 >>"$cache"

        echo >>"$cache"
    fi
}

bible() {
    local book="genesis"
    local chapter=1
    local last=1
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
        mkdir -p "$HOME/.cache/bible/$version"
    fi

    env_parallel --env populate_chapter --max-args=1 \
        populate_chapter $book ::: $(echo {$chapter..$last})

    echo "$HOME/.cache/bible/$book"{$chapter..$last} | xargs cat | less
}

uni() {
    cd "$HOME/Documents/UNSW/$1"
}

unsetopt share_history
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export EDITOR="nvim"
PATH="/home/joshh/.cargo/bin:/home/joshh/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/joshh/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/joshh/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/joshh/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/joshh/perl5"; export PERL_MM_OPT;
. `which env_parallel.zsh`
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export MCFLY_FUZZY=2
export MCFLY_RESULTS=40
eval "$(mcfly init zsh)"
eval "$(zoxide init zsh)"
