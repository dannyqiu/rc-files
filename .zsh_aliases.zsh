# Reload the shell (i.e. invoke as a login shell)
alias reload='exec $SHELL -l'
alias ohmyzsh='cd $HOME/.oh-my-zsh'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd..='cd ..'
alias l='ls -lF'
alias la='ls -A'
alias ll='ls -alF'

alias quit='exit'
alias wget='wget -c'

alias v='vim'
alias vi='vim'
alias vima='vim'

alias bat='bat -p'

alias 411='man'
alias 911='sudo'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias uuid='python -c "import uuid; print(uuid.uuid4())"'
alias sha256='shasum -a 256'

alias objdump='otool -tV'
alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes --leak-check=full --show-leak-kinds=all'

alias app='xattr -d com.apple.quarantine'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Aliases for git
alias gl='git pull'
alias gp='git push'
alias gt='git log --oneline --decorate --graph --color --all'
alias gitchangecommitter='GIT_COMMITTER_NAME="$(git log -1 --pretty=format:%an)" GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:%ae)" git commit --amend --no-edit'
function gitchangedate() {
    if [[ "$#" -ne 1 ]]; then
        date=$(date "+%a %b %-d %T %Y %z")
        echo 'Usage:\n\tgitchangedate "'$date'"'
    else
        GIT_COMMITTER_DATE="$1" GIT_AUTHOR_DATE="$1" git commit --amend --no-edit --date "$1"
    fi
}

function swap() {
    TMP_FILE="$1-$RANDOM.$RANDOM"
    mv "$2" "$TMP_FILE"
    mv "$1" "$2"
    mv "$TMP_FILE" "$2"
}

function safe_rm() {
    ORIGINAL_ARGS=("$@")
    TO_TRASH=true
    VERBOSITY=false
    while getopts ":if" opt; do
        case "$opt" in
            f)
                TO_TRASH=false
                ;;
            i)
                VERBOSITY=true
                ;;
        esac
    done
    shift $((OPTIND-1))
    if [ "$TO_TRASH" = true ]; then
        if [ "$VERBOSITY" = true ]; then
            mv -v "$@" ~/.Trash
        else
            mv "$@" ~/.Trash
        fi
    else
        \rm $ORIGINAL_ARGS
    fi
}
alias rm=safe_rm
