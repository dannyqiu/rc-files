# Alias definitions.
alias ..='cd ..'
alias cd..='cd ..'
alias l='ls -lF'
alias la='ls -A'
alias ll='ls -alF'
alias rm='rm -i'

alias gl='git pull'
alias gp='git push'
alias gt='git log --oneline --decorate --graph --color --all'

if [ "$(uname)" == "Darwin" ]; then
# Do something under Mac OS X platform

alias ls='ls -G' # enable color support in ls

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
# Do something under GNU/Linux platform

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

fi
