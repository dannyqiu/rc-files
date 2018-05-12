alias reload='exec $SHELL -l'
alias ohmyzsh='cd ~/.oh-my-zsh'

alias quit='bye'
alias rm='rm -i'
alias wget='wget -c'
alias curl='curl --ipv4'

alias gt='git log --oneline --decorate --graph --color --all'

alias objdump='otool -tV'
alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes --leak-check=full --show-leak-kinds=all'

alias server='jekyll server --watch'

alias app='xattr -d com.apple.quarantine'

alias v='vim'
alias vi='vim'
alias vima='vim'
alias cd..='cd ..'

alias 411='man'
alias 911='sudo'
alias uuid='python -c "import uuid; print(uuid.uuid4())"'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'

function gitchangedate() {
    if [[ "$#" -ne 1 ]]; then
        date=$(date "+%a %b %-d %T %Y %z")
        echo 'Usage:\n\tgitchangedate "'$date'"'
    else
        GIT_COMMITTER_DATE="$1" GIT_AUTHOR_DATE="$1" git commit --amend --date "$1"
    fi
}

function swap() {
    TMP_FILE="$1-$RANDOM.$RANDOM"
    mv "$2" "$TMP_FILE"
    mv "$1" "$2"
    mv "$TMP_FILE" "$2"
}

_SYSTEM_RM=`whereis rm`
function rm() {
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
        $_SYSTEM_RM $ORIGINAL_ARGS
    fi
}

alias javal='java -cp $JAVA_LIBRARY_CLASSPATH'

function jrun() {
    if [ ! -f $1 ]; then
        echo "File '$1' doesn't exist!"
    elif [ "$#" = "0" ]; then
        echo "Usage: \tjrun <java file>"
    else
        CURRENT_DIR=`pwd`
        JAVA_FILE=$1
        JAVA_CLASS=${1%%.*}
        JAVA_PACKAGE=$(cat $JAVA_FILE | grep package | cut -f 2 -d ' ' | cut -f 1 -d \;)
        PACKAGE_SPECIFIED=${#JAVA_PACKAGE}
        if [ "$PACKAGE_SPECIFIED" != "0" ]; then
            for i in $(grep -o "." <<< "$JAVA_PACKAGE" | wc -l)
            do
                cd ..
            done
        fi
        JAVA_FILE_PATH_FROM_PACKAGE=${JAVA_PACKAGE/\./\/}
        if [ "$JAVA_FILE_PATH_FROM_PACKAGE" != "" ]; then
            JAVA_FILE_PATH_FROM_PACKAGE="$JAVA_FILE_PATH_FROM_PACKAGE/"
        fi
        javac -cp $JAVA_LIBRARY_CLASSPATH $JAVA_FILE_PATH_FROM_PACKAGE$JAVA_FILE || (cd $CURRENT_DIR && return)
        if [ "$JAVA_PACKAGE" != "" ]; then
            JAVA_PACKAGE="$JAVA_PACKAGE."
        fi
        echo "\033[92mRunning $JAVA_PACKAGE$JAVA_CLASS ...\033[0m"
        java -cp $JAVA_LIBRARY_CLASSPATH $JAVA_PACKAGE$JAVA_CLASS ${@:2}
        cd $CURRENT_DIR
        rm -f *.class
    fi
}

export OCAMLRUNPARAM=b
