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
HISTSIZE=2000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function prompt_command {
    exitstatus="$?"

    BOLD="\[\033[1m\]"
    RED="\[\033[0;38;5;9m\]"
    GREEN="\[\033[0;38;5;10m\]"
    BLUE="\[\033[0;38;5;27m\]"
    PURPLE="\[\033[0;38;5;21m\]"
    CYAN="\[\033[0;38;5;39m\]"
    OFF="\[\033[0m\]"

    changes=`git status -s 2> /dev/null | wc -l | sed -e 's/ *//'`
    if [ ${changes} -eq 0 ]; then
        dirty=" ${GREEN}✔${OFF}"
    else
        dirty=" ${RED}✘${OFF}"
    fi
    branch=`git symbolic-ref HEAD 2> /dev/null | cut -f3 -d/`
    if [ ! -z ${branch} ]; then
        if [ ${branch} == "master" ]; then
            branch=`echo " (${BLUE}${branch}${dirty}${OFF})"`
        else
            branch=`echo " (${PURPLE}${branch}${dirty}${OFF})"`
        fi
    fi

    prompt="${OFF}\u@\h: ${CYAN}\w${OFF}${branch}"

    if [ ${exitstatus} -eq 0 ]; then
        PS1="${prompt} ${GREEN}ᐅ ${OFF}"
    else
        PS1="${prompt} ${RED}ᐅ ${OFF}"
    fi

    PS2="${BOLD}>${OFF} "
}
PROMPT_COMMAND=prompt_command

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
