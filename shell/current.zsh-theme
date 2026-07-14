# Vim: set ft=zsh
# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local conda_prompt='$(conda_prompt_info)'

if [[ $UID -eq 0 ]]; then
	# local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
	local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
	local user_symbol='#'
else
	# local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
	local user_host='%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}'
	local user_symbol='$'
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

RPROMPT="%B${return_code}%b"

BLUE_PREFIX="%{$fg[blue]%}‹"
GREEN_PREFIX="%{$fg[green]%}‹"
YELLOW_PREFIX="%{$fg[yellow]%}‹"
MAGENTA_PREFIX="%{$fg[magenta]%}‹"
PROMPT_SUFFIX="›%{$reset_color%}"

zmodload zsh/datetime

prompt_vcs_branch() {
	info=$(
    {
      jj_prompt_template_raw "if(!empty, '*') ++ '%B' ++ self.change_id().shortest(3).prefix() ++ '%b%{$fg[yellow]%}' ++ self.change_id().shortest(3).rest()"
      jj log --no-pager --no-graph -r "heads(::@ & (bookmarks() | remote_bookmarks()))" -T "' %b%{$fg[magenta]%}' ++ bookmarks.first().name() ++ '%b%{$fg[yellow]%}'" 2>/dev/null
    } || prompt_git_branch
	) || return

	echo " ${YELLOW_PREFIX}${info}${PROMPT_SUFFIX}"
}

prompt_git_branch() {
	local branch dirty

	branch=$(command git rev-parse --abbrev-ref HEAD 2> /dev/null) || return
	[[ -z ${branch} ]] && return

	if [[ -z $(command git config prompt.git-status 2> /dev/null) ]]; then
		[[ -n $(command git status -suno 2> /dev/null) ]] && dirty='*'
	else
		dirty='?'
	fi

	branch=${branch//\%/%%}
	echo "${dirty}${branch}"
}

prompt_set_prompt() {
  local suffix="$(prompt_vcs_branch)"

	[ -r .unibuild.sh ] && suffix+=" ${BLUE_PREFIX}build${PROMPT_SUFFIX}"
	which deactivate > /dev/null && suffix+=" ${GREEN_PREFIX}venv${PROMPT_SUFFIX}"
	[[ -z ${HISTFILE-} ]] && suffix+=" ${MAGENTA_PREFIX}private${PROMPT_SUFFIX}"
	[ -n "${ZSH_NOTIFY}" ] && suffix+=" ${MAGENTA_PREFIX}notify${PROMPT_SUFFIX}"

	local current_dir=" %{$terminfo[bold]$fg[blue]%}%-0<...<%~%{$reset_color%}"
	local pre_prompt="╭─${user_host}${current_dir}${suffix}%<<"

	PROMPT="${pre_prompt}"$'\n'"╰─%B${user_symbol}%b "
}

prompt_top_width() {
	emulate -L zsh
	setopt extended_glob

	if (( ${COLUMNS:-0} <= 0 )); then
		print -r -- 0
		return
	fi

	local rendered="$(print -P -r -- "$PROMPT")"
	local -a lines=("${(@f)rendered}")
	local top="${lines[1]}"
	top=${top//$'\e'\[[0-9\;]##[[:alpha:]]/}

	print -r -- ${#top}
}

TRAPWINCH() {
	zle 2> /dev/null || return 0
	local extra_rows=0

	if ((${prompt_last_top_width:-0} > ${COLUMNS:-0} && ${COLUMNS:-0} > 0)); then
		extra_rows=$(((prompt_last_top_width - 1) / COLUMNS))
	fi

	zle -I
	if ((extra_rows > 0)); then
		print -n -- $'\e['${extra_rows}$'F\e[J'
	fi
	zle reset-prompt
	prompt_last_top_width=$(prompt_top_width)
}

prompt_preexec() {
	prompt_prexec_realtime=${EPOCHREALTIME}
}

prompt_precmd() {
	if ((prompt_prexec_realtime)); then
		local -rF elapsed_realtime=$((EPOCHREALTIME - prompt_prexec_realtime))
		local -rF s=$((elapsed_realtime % 60))
		local -ri elapsed_s=${elapsed_realtime}
		local -ri m=$(((elapsed_s / 60) % 60))
		local -ri h=$((elapsed_s / 3600))

		if ((h > 0)); then
			printf -v prompt_elapsed_time '%ih%im' ${h} ${m}
		elif ((m > 0)); then
			printf -v prompt_elapsed_time '%im%is' ${m} ${s}
		elif ((s >= 10)); then
			printf -v prompt_elapsed_time '%.2fs' ${s} # 12.34s
		elif ((s >= 1)); then
			printf -v prompt_elapsed_time '%.3fs' ${s} # 1.234s
		else
			# printf -v prompt_elapsed_time '%ims' $(( s*1000 ))
			unset prompt_elapsed_time
		fi
		unset prompt_prexec_realtime

		if [ -n "${prompt_elapsed_time}" ] && [ -n "${ZSH_NOTIFY}" ]; then
			osascript -e "display notification \"Took ${prompt_elapsed_time}\" with title \"Completed\" sound name \"\""
		fi
	else
		# Clear previous result when hitting ENTER with no command to execute
		unset prompt_elapsed_time
	fi

	prompt_set_prompt
	prompt_last_top_width=$(prompt_top_width)
}

setopt nopromptbang prompt{cr,percent,sp,subst}

autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

RPS1='%1(j. %{$fg[black]%}[%j] .)%F{cyan}${prompt_elapsed_time}%F{none}'$RPROMPT

### OSC 133 (prompt start/end)

_prompt_executing=""
function __prompt_precmd() {
	local ret="$?"
	if test "$_prompt_executing" != "0"; then
		_PROMPT_SAVE_PS1="$PS1"
		_PROMPT_SAVE_PS2="$PS2"
		PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
		PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
	fi
	if test "$_prompt_executing" != ""; then
		printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
	fi
	printf "\033]133;A;cl=m;aid=%s\007" "$$"
	_prompt_executing=0
}

function __prompt_preexec() {
	PS1="$_PROMPT_SAVE_PS1"
	PS2="$_PROMPT_SAVE_PS2"
	printf "\033]133;C;\007"
	_prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)

###
