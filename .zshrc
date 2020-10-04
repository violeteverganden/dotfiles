PROMPT='%F{46}%~%f
$ '

tmux_count=$(ps -ax | grep '[t]mux' | wc -l | tr -d ' ')
if [ $SHLVL = 1 ]; then
	if [ $tmux_count = 0 ]; then
		tmux new-session -s 1
	elif [ $tmux_count = 1 ]; then
		tmux attach
	fi
fi

autoload -Uz compinit && compinit -u

alias re='source ~/.zshrc'
alias v='vim'
alias vv='vim .vimrc'
alias vz='vim .zshrc'
alias vt='vim .tmux.conf'

#export USER=diwata
export MAIL=$USER@student.42tokyo.jp
alias norm='~/.norminette/norminette.rb'
alias gcc='gcc -Wall -Wextra -Werror'
alias a='./a.out'
alias ce='cat -e'
alias valgrind='valgrind --leak-check=full -s ./a.out'

alias md='mkdir'
alias cpd='cp -r'
alias rmf='rm -fr'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias kses='tmux kill-session'
alias kser='tmux kill-server'

alias hrk='heroku'
alias bd='bundle'
alias rs='rails'

alias la='ls -a'
alias ll='ls -l'
alias lr='ls -R'

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt share_history

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
#zstyle ':completion:*:descriptions' format '%B%d%b'

HISTFILE=~/.zsh_history
HISTSIZE=10
SAVEHIST=10

alias g='git'
alias gi='git init'
alias gc='git clone'
alias gr='git remote'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --oneline -5'
alias gls='git ls-files'
alias ga='git add'
alias gaa='git add -A'
alias gm='git commit -am'
alias gps='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gbr='git branch -vv'
alias gmg='git merge'
