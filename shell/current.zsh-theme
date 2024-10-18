# Vim: set ft=zsh
# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
local conda_prompt='$(conda_prompt_info)'

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%-0<..<%~ %{$reset_color%}'

# local git_branch='$(git_prompt_info)' # TODO: an omzsh update broke this
local git_branch='$(git rev-parse --abbrev-ref HEAD 2>/dev/null | xargs -r -I {} echo "${ZSH_THEME_GIT_PROMPT_PREFIX}{}$([ -n "$(git status -suno 2>/dev/null)" ] && echo "*")${ZSH_THEME_GIT_PROMPT_SUFFIX}")'

local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='${ZSH_THEME_VIRTUALENV_PREFIX}venv${ZSH_THEME_VIRTUALENV_SUFFIX}'
local nohistory='${ZSH_THEME_NOHISTORY_PREFIX}private${ZSH_THEME_NOHISTORY_SUFFIX}'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

# PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
# ╰─%B${user_symbol}%b "
PROMPT="╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUALENV_SUFFIX="› %{$reset_color%}"

ZSH_THEME_NOHISTORY_PREFIX="%{$fg[magenta]%}‹"
ZSH_THEME_NOHISTORY_SUFFIX="› %{$reset_color%}"

zmodload zsh/datetime

get_prompt_string() {
  PRE_PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${git_branch}${kube_prompt}"
  which deactivate >/dev/null && PRE_PROMPT="${PRE_PROMPT}${venv_prompt}"
  [ -z $HISTFILE ] && PRE_PROMPT="${PRE_PROMPT}${nohistory}"

  local zero='%([BSUbfksu]|([FK]|){*})'
  REAL_LENGTH=${#${(S%%)PRE_PROMPT//$~zero/}} 
}

# TRAPWINCH() {
#     # if current prompt wraps after resize, clear extra prompt line and redraw
#     # TODO: REAL_LENGTH isn't calculating git_branch properly
#     # TODO: breaks with RPROMPT

#     # TODO: sometimes TRAPWINCH activates before REAL_LENGTH is set
#     if [ $REAL_LENGTH -gt $COLUMNS ]; then 
#         print -n "[2K[1F[2K"
#         print -Pn "$PROMPT"
#     fi

#     get_prompt_string
#     print -n "7[1F[2K"
#     print -Pn "$PRE_PROMPT"
#     print -n "8"
# }

prompt_preexec() {
  prompt_prexec_realtime=${EPOCHREALTIME}
}

prompt_precmd() {
  if (( prompt_prexec_realtime )); then
    local -rF elapsed_realtime=$(( EPOCHREALTIME - prompt_prexec_realtime ))
    local -rF s=$(( elapsed_realtime%60 ))
    local -ri elapsed_s=${elapsed_realtime}
    local -ri m=$(( (elapsed_s/60)%60 ))
    local -ri h=$(( elapsed_s/3600 ))
    if (( h > 0 )); then
      printf -v prompt_elapsed_time '%ih%im' ${h} ${m}
    elif (( m > 0 )); then
      printf -v prompt_elapsed_time '%im%is' ${m} ${s}
    elif (( s >= 10 )); then
      printf -v prompt_elapsed_time '%.2fs' ${s} # 12.34s
    elif (( s >= 1 )); then
      printf -v prompt_elapsed_time '%.3fs' ${s} # 1.234s
    else
      # printf -v prompt_elapsed_time '%ims' $(( s*1000 ))
      unset prompt_elapsed_time
    fi
    unset prompt_prexec_realtime
  else
    # Clear previous result when hitting ENTER with no command to execute
    unset prompt_elapsed_time
  fi

  get_prompt_string
  print -P "$PRE_PROMPT"
}

setopt nopromptbang prompt{cr,percent,sp,subst}

autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

RPS1='%F{cyan}${prompt_elapsed_time}%F{none} '$RPROMPT
