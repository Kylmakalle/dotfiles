# dotfiles

Setup scripts for my MacOS system

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kylmakalle/dotfiles/master/download.sh)"; cd dotfiles
```

```shell
source ./setup-brew.sh
./setup-ansible.sh
./run-ansible.sh main.yml --ask-become-pass
```

Scripts will set up a mandatory execution environment and install some basic programs from `default.config.yml`, as well as altering macOS preferences.

`Ensure crontab` step may require manual approval for "Administrating computer".

(Optionally) Run setup with sudo to alter some NVRAM settings:

```shell

sudo ./setup-macos.sh
```

Unfortunately, not everything can be automated, here's what I usually like to see in my environment:

1. Sign in iCloud after the setup screen. For comfortable development, turn **ON** these settings:
   1. Notes
   2. Calendar
   3. Reminders
   4. Home
   5. Shortcuts
   6. Passwords & Keychain
2. Finder:
   1. Add ~/ to Favorites
3. Setup Biometry
4. Dock
   1. Sort By > Date Added
   2. Display As > Folder
   3. View Content As > Grid
5. Terminal > Settings > Font > Change... > **14**
6. Menu bar, position with CMD + Click, right to left:
   1. Date and Time
   2. Control Center
   3. Battery
   4. WIFI
   5. > **TODO: figure out other**
7. Sign-in to Chrome `open '/Applications/Google Chrome.app'`, set default.
8. Install Xcode with `open /Applications/Xcodes.app`
   1. Place Xcodes to the right of VSCode
9.  Setup Git and Github Desktop `open '/Applications/Github Desktop.app'`
   1. Settings > Advanced > Usage > **OFF**
10. Setup VSCode `open '/Applications/Visual Studio Code.app'`
   1. Log In
   2. Bottom panel: Hide Ports
   3. Left Panel:
      1. Explorer
      2. Search
      3. Source Control
      4. Run and Debug
      5. Testing (optional)
      6. Task Explorer
   4. Move Outline and Timeline from Search to Explorer
11. Setup Raycast `open /Applications/Raycast.app`
   1. Keybind Control + Space
   2. Settings > General > Menu bar icon > **OFF**
   3. Settings > General > Window Mode > Compact
12. Setup Rectangle, Windows management `open /Applications/Rectangle.app`
    1. Settings > Launch on Login
    2. Settings > Hide menu bar icon
    3. Settings > Check for updates automatically
13. Setup Dark mode switcher `open '/Applications/Dynamic Dark Mode.app'`
    1. Menu Bar Item > Toggle Dark Mode
    2. Opens At login > **ON**
    3. Check for Updates > **ON**
14. Setup Shottr `open /Applications/Shottr.app`
    1. Preferences > General > After Area Crop, show > Editor
    2. Preferences > General > Launch at Startup
15. Setup Google Drive `open '/Applications/Google Drive.app'`
   >
   > 1. Should Mirror files in Preferences?

---

Inspired by <https://github.com/geerlingguy/mac-dev-playbook>
