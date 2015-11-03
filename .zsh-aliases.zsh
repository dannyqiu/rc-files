alias reload='source ~/.zshrc'
alias config='vim ~/.zsh-aliases.zsh'
alias ohmyzsh='cd ~/.oh-my-zsh'

alias quit='bye'
alias rm='rm -i'
alias wget='wget -c'
alias curl='curl --ipv4'

alias gt='git log --oneline --decorate --graph --color --all'

alias objdump='otool -tV'
alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes--leak-check=full --show-leak-kinds=all'

alias server='jekyll server --watch'

alias doe='http_proxy=filtr.nycboe.org:8002'

alias app='xattr -d com.apple.quarantine'

alias vima='vim'

alias 411='man'
alias 911='sudo'
alias ip='curl canihazip.com/s'

function gitchangedate() {
    if [[ "$#" -ne 1 ]]; then
        date=$(date "+%a %b %-d %T %Y %z")
        echo 'Usage:\n\tgitchangedate "'$date'"'
    else
        GIT_COMMITTER_DATE="$1" GIT_AUTHOR_DATE="$1" git commit --amend --date "$1" 
    fi
}

function swap() {
    TMP_FILE=$1'-$RANDOM.$RANDOM'
    mv $2 $TMP_FILE
    mv $1 $2
    mv $TMP_FILE $2
}

alias javal='java -cp $JAVA_LIBRARY_CLASSPATH'

function jrun() {
    if [ ! -f $1 ]; then
        echo "File '$1' doesn't exist!"
    else
        CURRENT_DIR=`pwd`
        JAVA_FILE=$1
        JAVA_CLASS=${1%%.*}
        JAVA_PACKAGE=$(cat $JAVA_FILE | grep package | cut -f 2 -d ' ' | cut -f 1 -d \;)
        for i in $(grep -o "." <<< "$package" | wc -l)
        do
            cd ..
        done
        JAVA_FILE_PATH_FROM_PACKAGE=${JAVA_PACKAGE/\./\/}
        javac $JAVA_FILE_PATH_FROM_PACKAGE/$JAVA_FILE || (cd $CURRENT_DIR)
        echo "\033[92mRunning $JAVA_PACKAGE.$JAVA_CLASS ...\033[0m"
        javal $JAVA_PACKAGE.$JAVA_CLASS ${@:2}
        cd $CURRENT_DIR
        rm -f *.class
    fi
}
