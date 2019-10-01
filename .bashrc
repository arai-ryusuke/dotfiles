# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ~/bin/git-prompt.sh
export PS1='\[\e[1;34m\][\u@\h \W]\\$ \[\e[m\] \[\e[1;32m $(__git_ps1 "(%s)")  \[\e[0m\] \$ '
alias ls='ls --color=auto'
