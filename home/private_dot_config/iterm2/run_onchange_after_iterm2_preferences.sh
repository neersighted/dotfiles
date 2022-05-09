#!/bin/sh -e

echo "Writing iTerm2 preferences..."

# set path to config files
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${XDG_CONFIG_HOME:-$HOME/.config}/iterm2"
# load settings from config directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# save settings automatically
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile -bool true
defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
