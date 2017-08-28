# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

#export LC_CTYPE=C
#export LANG=C

export EDITOR=vim

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JUNIT_HOME=/usr/local/share/junit
export JAVA_LIBRARY_CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar:$JAVA_HOME/jre/lib/ext/jfxrt.jar:.

# Customize to your needs...
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/Danny/Library/sox-14.4.0:/Users/Danny/Library/bin

# Source aliases from another file
if [[ -e $HOME/.zsh_aliases.zsh ]]; then
    source $HOME/.zsh_aliases.zsh
fi

# OPAM configuration
. /Users/Danny/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# rvm configuration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
