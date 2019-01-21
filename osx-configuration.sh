#!/bin/bash

if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions to run."
   sudo "$0" "$@"
   exit
fi

###############################################################################
# General UX/UI
###############################################################################

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Require password 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

###############################################################################
# Trackpad, Keyboard, Mouse
###############################################################################

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

################################################################################
# Finder
################################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show full path in window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Disable Creation of Metadata Files on Network/USB Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show icon for recent documents in the dock
defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

# Disable Spotlight indexing of external volumes by default
defaults write /Library/Preferences/com.apple.SpotlightServer.plist ExternalVolumesDefaultOff -bool true

################################################################################
# Dock
################################################################################

# Lock the size of the dock
defaults write com.apple.dock size-immutable -bool yes

# Lock the position of the dock
defaults write com.apple.dock position-immutable -bool yes

# Set the size of the dock icons
defaults write com.apple.dock tilesize -int 40

# Auto-hide the dock
defaults write com.apple.dock autohide -bool yes

# Show item info below desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

################################################################################
# Quicklook
################################################################################

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

################################################################################
# Safari
################################################################################

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

################################################################################
# Mail
################################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

###############################################################################
# Activity Monitor
###############################################################################

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Misc
###############################################################################

# Get SF Mono Fonts (OS X Sierra +)
cp -v /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/SFMono-* ~/Library/Fonts

# Allow key-repeat in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false


###############################################################################
# Affected applications
###############################################################################

for app in Finder Dock Mail Safari SystemUIServer; do killall "$app" > /dev/null 2>&1; done
