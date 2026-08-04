# vim: ft=zsh tabstop=4 shiftwidth=4 expandtab list

# NOTE: uncomment to profile shell startup. `zprof` to view results
zmodload zsh/zprof

if [ -x /usr/libexec/path_helper ]; then
	eval "$(/usr/libexec/path_helper -s)"
fi

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="jira"

setopt HIST_IGNORE_SPACE

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="true"
# DISABLE_UPDATE_PROMPT="true"
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

export FZF_BASE=/usr/bin/fzf
plugins=(git jj autoenv zsh-autosuggestions colored-man-pages copybuffer)

source "$ZSH"/oh-my-zsh.sh

# User configuration

# export VIRTUAL_ENV_DISABLE_PROMPT=1

# Even though these are in ~/.zshenv to be sourced by non-interactive shells,
# source them again here so that unalias can override aliases introduced earlier in this file.
source "$HOME/.aliases"
source "$HOME/.workaliases"

unsetopt share_history

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR=nvim
export VISUAL="$EDITOR"

PATH="$PATH:/opt/homebrew/bin"
PATH="$HOME/.cargo/bin:$HOME/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# . `which env_parallel.zsh`
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files'
fi

export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
export XDG_CONFIG_HOME=~/.config

source <(fzf --zsh)

eval "$(zoxide init zsh)"

export HOMEBREW_NO_AUTO_UPDATE=1
unset _OLD_VIRTUAL_PS1 # starting a new shell from a venv sets this, causing PS1 to break once you deactivate

# Chromium tools
export PATH="$PATH:/Users/jharcombe/atlassian/google/depot_tools"

# # bun completions
# [ -s "/Users/jharcombe/.bun/_bun" ] && source "/Users/jharcombe/.bun/_bun"

# # bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
