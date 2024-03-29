# Alias definitions.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd.='cd .'
alias cd..='cd ..'
alias l='ls -lF'
alias la='ls -A'
alias ll='ls -alF'

alias quit='exit'
alias wget='wget -c'

alias v='vim'
alias vi='vim'
alias vima='vim'

alias 411='man'
alias 911='sudo'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias uuid='python -c "import uuid; print(uuid.uuid4())"'
alias sha256='shasum -a 256'

alias valgrind='valgrind --trace-children=yes --read-var-info=yes --sigill-diagnostics=yes --leak-check=full --show-leak-kinds=all'

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

# Some random helpful functions
function uriencode() {
  if [ "$#" -eq "0" ]; then
    python3 -c "import urllib.parse; import sys; sys.stdout.write(urllib.parse.quote(sys.stdin.read()))"
  else
    python3 -c "import urllib.parse; import sys; sys.stdout.write(urllib.parse.quote(\"$1\"))"
  fi
}

function linecount() {
  find . -name "$1" -exec wc -l {} \; | cut -d ' ' -f1 | paste -sd+ | bc
}

# Make rm safer by moving files into a ~/.trash directory instead
# Use \rm if you want the native rm for one-off situations.
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

function __macos_configure() {
  alias ls='ls -G' # enable color support in ls
}

function __linux_configure() {
  alias xcopy='xclip -in -selection clipboard'
  alias xpaste='xclip -out -selection clipboard'

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
}

if [ "$(uname)" == "Darwin" ]; then
  __macos_configure
else
  __linux_configure
fi
