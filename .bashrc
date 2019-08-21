# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

function prompt_command {
    exitstatus="$?"

    BOLD="\[\033[1m\]"
    RED="\[\033[38;5;9m\]"
    GREEN="\[\033[38;5;10m\]"
    BLUE="\[\033[38;5;27m\]"
    PURPLE="\[\033[38;5;21m\]"
    CYAN="\[\033[38;5;39m\]"
    YELLOW="\[\033[38;5;226m\]"
    INVERTED="\[\033[38;5;0m\]\033[48;5;255m\]"
    OFF="\[\033[0m\]"

    changes=`git status -s 2> /dev/null | wc -l | sed -e 's/ *//'`
    if [ ${changes} -eq 0 ]; then
        dirty=" ${GREEN}v${OFF}"
    else
        dirty=" ${RED}x${OFF}"
    fi
    branch=`git symbolic-ref HEAD 2> /dev/null | cut -f3 -d/`
    if [ ! -z ${branch} ]; then
        if [ ${branch} == "master" ]; then
            branch=`echo " (${BLUE}${branch}${dirty}${OFF})"`
        else
            branch=`echo " (${PURPLE}${branch}${dirty}${OFF})"`
        fi
    fi

    window_title="\[\e]0;\W\a\]"
    current_time="[\t] "
    prompt="${window_title}${OFF}${CYAN}${current_time}${OFF}\u@\h: ${CYAN}\w${OFF}${branch}"

    if [ ${exitstatus} -eq 0 ]; then
        PS1="${prompt} ${GREEN}> ${OFF}${YELLOW}${BOLD}"
    else
        PS1="${prompt} ${RED}> ${OFF}${YELLOW}${BOLD}"
    fi
    trap 'echo -ne "\033[0m"' DEBUG

    PS2="${BOLD}>${OFF} "

    # Add inverted percent if previous output does not end in newline (zsh)
    if [ "$(__get_terminal_column)" != 1 ]; then
        PS1="${INVERTED}%${OFF}\n"$PS1
        PS2="${INVERTED}%${OFF}\n"$PS2
    fi
}
PROMPT_COMMAND=prompt_command

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
