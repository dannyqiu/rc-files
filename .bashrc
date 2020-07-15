# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# use vim-like command editing
#set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=64000
HISTFILESIZE=64000

if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\eOA": history-search-backward'
    bind '"\eOB": history-search-forward'
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# autocomplete only directories with cd
complete -d cd

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function __get_terminal_column {
    exec < /dev/tty
    local oldstty=$(stty -g)
    stty raw -echo min 0
    echo -en "\033[6n" > /dev/tty
    local pos
    IFS=';' read -r -d R -a pos
    stty $oldstty
    echo "${pos[1]}"
}

function __dir_chomp {
    local IFS=/ c=1 n d
    local p=${1/#$HOME/\~} r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}

function __handle_path {
    case "$1" in
        *) __dir_chomp "$1" 48 ;;
    esac
}

function __tmux_window_name() {
    if [ -z "$TMUX" ]; then
        return
    fi
    case "$PWD" in
        *) tmux rename-window -t "${TMUX_PANE}" "$(basename "${PWD}")" ;;
    esac
}

function __refresh_tmux_env {
    # fix tmux environment variables when attaching from different computers (needed for xclip)
    if [ -z "$TMUX" ]; then
        return
    fi
    export DISPLAY="$(tmux show-environment -g DISPLAY 2> /dev/null | sed -n 's/^DISPLAY=//p')"
    if [ -z "$DISPLAY" ]; then
      # if DISPLAY does not exist in the global environment, take it from the local
      export DISPLAY="$(tmux show-environment DISPLAY 2> /dev/null | sed -n 's/^DISPLAY=//p')"
    else
      # match the local environment to that of the global
      tmux set-environment DISPLAY $DISPLAY
    fi
}

function __pre_command {
    printf '\033[0m'

    # make sure that this only runs once per command
    if [ -z "$RUN_PRE_COMMAND" ]; then
      return
    fi
    unset RUN_PRE_COMMAND

    # reset before each command:
    #   - output colors
    #   - tmux environment variables like DISPLAY
    __refresh_tmux_env
    return 0
}

function prompt_command {
    exitstatus="$?"

    BOLD="\[\033[1m\]"
    RED="\[\033[38;5;9m\]"
    GREEN="\[\033[38;5;10m\]"
    BLUE="\[\033[38;5;27m\]"
    PURPLE="\[\033[38;5;99m\]"
    CYAN="\[\033[38;5;39m\]"
    YELLOW="\[\033[38;5;226m\]"
    INVERTED="\[\033[38;5;0m\]\033[48;5;255m\]"
    OFF="\[\033[0m\]"

    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ ! -z ${branch} ]; then
        if [ ${branch} == "HEAD" ]; then
            branch=$(git rev-parse --short HEAD 2> /dev/null)
        fi
        changes=$(git status -s 2> /dev/null | wc -l | sed -e 's/ *//')
        if [ ${changes} -eq 0 ]; then
            dirty=" ${GREEN}v${OFF}"
        else
            dirty=" ${RED}x${OFF}"
        fi
        branch=" (${PURPLE}${branch}${dirty}${OFF})"
    fi

    window_title="\[\e]0;\W\a\]"
    current_time="[\t]"
    host="\u@\h"
    path="$(__handle_path "$PWD")"
    if [[ $EUID -eq 0 ]]; then
      # Running as root
      symbol="#"
    else
      symbol=">"
    fi
    if [ ${exitstatus} -eq 0 ]; then
      start_symbol="${GREEN}${symbol}${OFF}"
    else
      start_symbol="${RED}${symbol}${OFF}"
    fi
    prompt="${window_title}${OFF}${CYAN}${current_time} ${PURPLE}${host}: ${CYAN}${path}${OFF}${branch} ${start_symbol}"

    PS1="${prompt} ${YELLOW}${BOLD}"

    # Show inverted percent symbol if previous output does not end in newline (zsh behavior)
    if [ "$(__get_terminal_column)" != 1 ]; then
        PS1="${INVERTED}%${OFF}\n${PS1}"
    fi

    PS2="${YELLOW}${BOLD}...)> "

    # set the window name in tmux
    __tmux_window_name

    RUN_PRE_COMMAND=1
    trap '__pre_command' DEBUG
}
PROMPT_COMMAND='prompt_command'

# disables the scroll lock feature with ctrl+s on some terminal emulators
stty -ixon

# allow pasting from other applications without inserting bracketed paste symbols
bind 'set enable-bracketed-paste on'

#export LC_CTYPE=C
#export LANG=C
export EDITOR=vim

# Customize to your needs...
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$HOME/Library/bin:$PATH"

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# OPAM Configuration
[[ -r "$HOME/.opam/opam-init/init.sh" ]] && source "$HOME/.opam/opam-init/init.sh" > /dev/null 2> /dev/null || true

# RVM Configuration
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

true
