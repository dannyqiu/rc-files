# Alias definitions.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd..='cd ..'
alias l='ls -lF'
alias la='ls -A'
alias ll='ls -alF'

alias gl='git pull'
alias gp='git push'
alias gt='git log --oneline --decorate --graph --color --all'

alias v='vim'
alias vi='vim'

alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes --leak-check=full --show-leak-kinds=all'

alias 411='man'
alias 911='sudo'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias uuid='python -c "import uuid; print(uuid.uuid4())"'
alias sha256='shasum -a 256'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

function safe_rm() {
    if [ "$#" -eq "0" ]; then
        return
    fi
    DIR=~/.trash/"$(date +'%c')"
    DIR=${DIR// /_}
    mkdir -p $DIR
    mv "$@" $DIR

    \rm -f ~/.trash/latest
    ln -s $DIR ~/.trash/latest
}
alias rm=safe_rm

if [ "$(uname)" == "Darwin" ]; then
# Do something under Mac OS X platform
    alias ls='ls -G' # enable color support in ls

else
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
