# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ~/bin/git-prompt.sh
export PS1='\[\e[1;31m\][\u@\h \W]\[\e[1;32m\] $(__git_ps1 "(%s)")\[\e[m\] \$ '
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
set -o vi
source "$HOME/.cargo/env"
