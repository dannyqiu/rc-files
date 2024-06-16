#!/bin/sh

echo "Installing Homebrew"
brew -v || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

PACKAGES=(
    bat
    binwalk
    ffmpeg
    htop
    jq
    openjdk
    pyenv
    reattach-to-user-namespace
    the_silver_searcher
    tmux
    vim
    vlc
    wakeonlan
    wget
    wifi-password
)
CASK_PACKAGES=(
    appcleaner
    bit-slicer
    db-browser-for-sqlite
    handbrake
    imageoptim
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlstephen
    rectangle
    virtual-studio-code
    wireshark
    xquartz
)

echo "Installing packages: ${PACKAGES[@]}"
brew install ${PACKAGES[@]}

# Link OpenJDK into system Java wrappers
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
