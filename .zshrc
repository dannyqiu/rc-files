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

# Source aliases from another file
if [[ -e $HOME/.zsh-aliases.zsh ]]; then
    source $HOME/.zsh-aliases.zsh
fi

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/Danny/Library/sox-14.4.0:/Users/Danny/Library/bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export JAVA_HOME=/Library/Java/Home
export JUNIT_HOME=/usr/local/share/junit
export CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:.
