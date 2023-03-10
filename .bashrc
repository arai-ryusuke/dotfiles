# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ~/bin/git-prompt.sh
source ~/bin/git-completion.bash
SSH_CONNECTION=`env | grep SSH_CONNECTION`
if [ -z "$SSH_CONNECTION" ]; then
  export PS1='\[\e[1;31m\][\u@\h \W]\[\e[1;32m\] $(__git_ps1 "(%s)")\[\e[m\] \$ '
else
  export PS1='\[\e[1;31m\][\u\[\e[1;32m\]@remote \[\e[1;31m\]\W]\[\e[1;32m\] $(__git_ps1 "(%s)")\[\e[m\] \$ '
fi
alias tmuxe="tmux new -A -s editor"
alias tmuxc="tmux new -A -s command"
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias g='git'
__git_complete g __git_main
alias grep='grep --color'
set -o vi
