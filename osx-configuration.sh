# Show Full Path in Finder Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable Creation of Metadata Files on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Creation of Metadata Files on USB Volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable Spotlight indexing of external volumes by default
defaults write /Library/Preferences/com.apple.SpotlightServer.plist ExternalVolumesDefaultOff -bool true

# Get SF Mono Fonts (OS X Sierra +)
cp -v /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SFMono-* ~/Library/Fonts
