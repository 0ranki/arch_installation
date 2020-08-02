#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=/usr/bin/vim

if [[ "$PATH" != "*~/.bin:*" ]]; then
	export PATH=~/.bin:$PATH
fi
