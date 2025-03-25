# vim: ft=zsh tabstop=4 shiftwidth=4 expandtab list
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.

# NOTE: uncomment to profile shell startup. `zprof` to view results
# zmodload zsh/zprof

export PATH=/opt/homebrew/bin/:$PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin/

export PATH=$HOME/bin:/usr/local/bin:$PATH:/root/.gem/ruby/2.7.0/bin:$HOME/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:/opt/gradle/gradle-5.4.1/bin
export PYTHONPATH="/usr/lib/python3.9/site-packages":$PYTHONPATH
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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
plugins=(git autoenv zsh-autosuggestions colored-man-pages copybuffer)

source "$ZSH"/oh-my-zsh.sh

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
clear-screen() {
    echoti clear
    print -P $PRE_PROMPT
    zle redisplay
}
zle -N clear-screen

# Even though these are in ~/.zshenv to be sourced by non-interactive shells,
# source them again here so that unalias can override aliases introduced earlier in this file.
source "$HOME/.aliases"
source "$HOME/.workaliases"

unsetopt share_history
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export EDITOR="nvim"
export VISUAL="nvim"
PATH="$HOME/.cargo/bin:$HOME/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export PERL_MM_OPT
# . `which env_parallel.zsh`
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
fi

export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
export XDG_CONFIG_HOME=~/.config

export MCFLY_FUZZY=10
export MCFLY_RESULTS=40
export MCFLY_RESULTS_SORT=RANK # options: [LAST_RUN, RANK]
eval "$(mcfly init zsh)"

# idk why this is still set
# unset ESBUILD_BINARY_PATH
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
# This is lazy loaded in ~/.aliases via `npm` and `nvm`
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

eval "$(pdm --pep582)"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/Users/jharcombe/.orbit/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1
