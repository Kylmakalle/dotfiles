#!/usr/bin/env bash

# Mac OS X configuration
#
# This configuration applies to the latest version of macOS (currently 11.3),
# and sets up preferences and configurations for all the built-in services and
# apps. Third-party app config should be done elsewhere.
#
# Options:
#   --no-restart: Don't restart any apps or services after running the script.
#
# If you want to figure out what default needs changing, do the following:
#
#   1. `cd /tmp`
#   2. Store current defaults in file: `defaults read > before`
#   3. Make a change to your system.
#   4. Store new defaults in file: `defaults read > after`
#   5. Diff the files: `diff before after`
#
# @see: http://secrets.blacktree.com/?showapp=com.apple.finder
# @see: https://github.com/herrbischoff/awesome-macos-command-line
# @see: https://macos-defaults.com
#
# @author Inspired by https://github.com/geerlingguy/dotfiles/blob/master/.osx from Jeff Geerling

# Warn that some commands will not be run if the script is not run as root.
if [[ $EUID -ne 0 ]]; then
  RUN_AS_ROOT=false
  printf "Certain commands will not be run without sudo privileges. To run as root, run the same command prepended with 'sudo', for example: $ sudo $0\n\n" | fold -s -w 80
else
  RUN_AS_ROOT=true
  # Update existing `sudo` timestamp until `setup-macos.sh` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# # Restart automatically if the computer freezes
# if [[ "$RUN_AS_ROOT" = true ]]; then
#   systemsetup -setrestartfreeze on
# fi

# Disable startup sound
if [[ "$RUN_AS_ROOT" = true ]]; then
  sudo nvram StartupMute=%01
fi


# Turn Off “Application Downloaded from Internet” Warning
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reduce motion to speedup some animations
defaults write com.apple.Accessibility ReduceMotionEnabled -bool true
defaults write com.apple.universalaccess reduceMotion -bool true

# Appearance: Auto
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto-capitalization 
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable dot on two spaces as they’re annoying
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Double and single quotes style
# 0: Opening double-quote, 1: Closing double-quote, 2: Opening single-quote, 3: Closing single-quote
defaults write NSGlobalDomain NSUserQuotesArray -array '"\""' '"\""' "'" "'"
defaults write NSGlobalDomain KB_DoubleQuoteOption -string \"abc\"
defaults write NSGlobalDomain KB_SingleQuoteOption -string "'abc'"


# Keyboard shortcuts
# See list of shortcut values https://web.archive.org/web/20141112224103/http://hintsforums.macworld.com/showthread.php?t=114785
# See top answer about modifiers https://stackoverflow.com/questions/21878482/what-do-the-parameter-values-in-applesymbolichotkeys-plist-dict-represent
HOTKEYS_PLIST="${HOME}/Library/Preferences/com.apple.symbolichotkeys.plist"

# Spotlight (disabled) - Control, Space
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:64" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Finder search - disabled
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:65" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 65 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>1572864</integer>
      </array>
    </dict>
  </dict>
"

# Select the previous input source - Command, Space
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:60" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 60 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>1048576</integer>
      </array>
    </dict>
  </dict>
"

# Select the next input source - disabled
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:61" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 61 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>786432</integer>
      </array>
    </dict>
  </dict>
"

# Save picture of screen as file - Command, Control, Shift, 3
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:28" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 28 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>51</integer>
        <integer>20</integer>
        <integer>1441792</integer>
      </array>
    </dict>
  </dict>
"

# Copy picture of screen to clipboard - Command, Shift, 3
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:29" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 29 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>51</integer>
        <integer>20</integer>
        <integer>1179648</integer>
      </array>
    </dict>
  </dict>
"

# Save picture of selected area as file - Command, Control, Shift, 4
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:30" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 30 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>52</integer>
        <integer>21</integer>
        <integer>1441792</integer>
      </array>
    </dict>
  </dict>
"

# Copy picture of selected area to clipboard - Command, Shift, 4
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:31" "${HOTKEYS_PLIST}" 2>/dev/null || true
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 31 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>52</integer>
        <integer>21</integer>
        <integer>1179648</integer>
      </array>
    </dict>
  </dict>
"

# Lock screen with Command, L
GLOBALDOMAIN_PLIST="${HOME}/Library/Preferences/.GlobalPreferences.plist"

/usr/libexec/PlistBuddy -c "Delete :NSUserKeyEquivalents:'Lock Screen'" "${GLOBALDOMAIN_PLIST}" 2>/dev/null || true
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Lock Screen" "@l"

###############################################################################
# Screen                                                                      #
###############################################################################


###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.1

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use List view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 42

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.15

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0


###############################################################################
# App Store                                                                   #
###############################################################################

# Disable in-app rating requests from apps downloaded from the App Store.
defaults write com.apple.appstore InAppReviewEnabled -int 0

###############################################################################
# Menu bar                                                                    #
###############################################################################

# Show/remove menubar items
# https://apple.stackexchange.com/questions/371873/what-terminal-defaults-command-will-show-menu-bar-icons-in-macos
defaults write "${HOME}/Library/Preferences/ByHost/com.apple.controlcenter.plist" "Sound" -int "18"
defaults write "${HOME}/Library/Preferences/ByHost/com.apple.controlcenter.plist" "Bluetooth" -int "18"
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool true
defaults -currentHost write com.apple.Spotlight "NSStatusItem Visible Item-0" -bool false
# defaults write "${HOME}/Library/Preferences/ByHost/com.apple.controlcenter.plist" "Spotlight" -int "24"

###############################################################################
# Terminal                                                                    #
###############################################################################

# Show Tabs
defaults write com.apple.terminal "NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS" -bool true

# Set columnCount to 100 for the "Basic" profile
/usr/libexec/PlistBuddy -c "Set :'Window Settings':Basic:columnCount 100" "${HOME}/Library/Preferences/com.apple.Terminal.plist" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add :'Window Settings':Basic:columnCount integer 100" "${HOME}/Library/Preferences/com.apple.Terminal.plist"

# Set rowCount to 30 for the "Basic" profile
/usr/libexec/PlistBuddy -c "Set :'Window Settings':Basic:rowCount 30" "${HOME}/Library/Preferences/com.apple.Terminal.plist" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add :'Window Settings':Basic:rowCount integer 30" "${HOME}/Library/Preferences/com.apple.Terminal.plist"

###############################################################################
# Other                                                                       #
###############################################################################

# Disable "Ask Siri"
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri SiriPrefStashedStatusMenuVisible -bool false

# Remove siri icon from status menu
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool false

# Xcode
# Show the build duration in the Xcode's toolbar
defaults write com.apple.dt.Xcode "ShowBuildOperationDuration" -bool "true"

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "cfprefsd" "Dock" "Finder" "Mail" "SystemUIServer" "System Settings"; do
    killall "${app}" > /dev/null 2>&1
  done
  # Ask the system to read the hotkey plist file and ignore the output. Likely updates an in-memory cache with the new plist values.
  defaults read com.apple.symbolichotkeys.plist > /dev/null

  # Run reactivateSettings to apply the updated settings.
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  printf "Please run \'killall "Terminal" > /dev/null 2>&1\' for Terminal changes to take effect\n\n"
fi

printf "Please log out and log back in to make all settings take effect.\n"

