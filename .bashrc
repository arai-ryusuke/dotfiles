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
alias grep='grep --color=auto'
set -o vi
alias clip='/mnt/c/WINDOWS/system32/clip.exe'

# remove this lines if remote
# --- ssh-agent: 単一エージェントを使い回す（OS再起動まで再入力不要） ---
# 鍵は config の "AddKeysToAgent yes" により初回利用時に自動登録される。
SSH_ENV="$HOME/.ssh/agent-env"
[ -f "$SSH_ENV" ] && . "$SSH_ENV" >/dev/null
ssh-add -l >/dev/null 2>&1
if [ $? -eq 2 ]; then            # 2 = 到達可能なエージェントが無い
    (umask 077; ssh-agent -s > "$SSH_ENV")
    . "$SSH_ENV" >/dev/null
fi
