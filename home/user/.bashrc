#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Start or attach Tmux on every login
#[[ -z "$TMUX" && "$UID" -ne 0 ]] && exec tmux
if which tmux >/dev/null 2>&1; then
	    #if not inside a tmux session, and if no session is started, start a new session
	        test -z "$TMUX" && if [[ "$UID" -ne 0 ]];then (tmux attach || tmux new-session); fi
fi

## Source aliases
if [[ -e ~/.bash_aliases ]]; then
	source .bash_aliases
fi

## Bash completion
if [[ -e /usr/share/bash-completion/bash_completion ]]; then
	source /usr/share/bash-completion/bash_completion
fi

## Command not found
if [[ -e /usr/share/doc/pkgfile/command-not-found.bash ]]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

## Prompt

if [[ -e ~/.bash_prompt ]]; then
	source ~/.bash_prompt
fi

