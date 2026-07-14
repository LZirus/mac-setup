# Manual Steps (can't be done headlessly)

These need your Mac password, App Store login, hardware, or an external account. Run them in
**Terminal.app** (so sudo can prompt you).

## 0. Rosetta 2 (recommended)
Lets you run x86 binaries (some casks/CLIs, RE/malware analysis, x86 Python wheels). Native arm64 apps
are unaffected; zero cost when unused. Recommended unless your hardening baseline forbids it.
```bash
softwareupdate --install-rosetta --agree-to-license
```

## 1. Casks that need an interactive `sudo` password
The automated installer got everything downloaded but couldn't run their privileged `.pkg` step
in a non-interactive shell. Install these yourself (each will prompt for your password):

```bash
brew install --cask thonny                        # MicroPython IDE
brew install --cask kicad                          # PCB/EDA
brew install --cask wireshark-app                   # + grants packet-capture perms
brew install --cask session-manager-plugin          # AWS SSM
brew install --cask netbirdio/tap/netbird-ui        # NetBird GUI
brew install --cask wch-ch34x-usb-serial-driver     # CH340 serial driver
```
Or all at once:
```bash
brew install --cask thonny kicad wireshark-app session-manager-plugin netbirdio/tap/netbird-ui wch-ch34x-usb-serial-driver blackhole-2ch
```
(`blackhole-2ch` = virtual audio driver for capturing system audio in meeting-recording tools.)

## 2. CH340 USB-serial driver — APPROVE the extension
The driver installs as a DriverKit extension in state "activated waiting for user". Enable it:
- **System Settings → General → Login Items & Extensions → Driver Extensions** → toggle **WCH / CH34xVCPDriver ON**
  (or **Privacy & Security** → **Allow** the blocked "Nanjing Qinheng" item)
- Replug the board, then verify: `ls /dev/cu.*` (expect `cu.wchusbserial…`)
- Only needed for CH340/CH341 clone boards; native-USB / FTDI / CP210x don't need it.

## 3. Mac App Store (mas)
`mas` can no longer sign in from the CLI (Apple removed it), so mas apps must be installed from the
App Store GUI while signed in. If your Mac uses a **managed/company Apple ID that can't download apps**,
avoid App Store-only apps entirely. Example: RunCat (mas) → use **Stats** or `brew install --cask iglance`
for a menu-bar monitor instead. If you need an MAS app, sign a *personal* Apple ID into App Store.app
only — and check your org's policy first.

## 4. NetBird VPN (optional)
If you use NetBird, the CLI/daemon (`netbird`) is installed. Connect with the setup key / SSO from your org:
```bash
netbird up            # follow the SSO/login flow
netbird status
```

## 5. Kali Linux (offensive VM)
- Open **UTM**, download the **ARM64** Kali image + follow kali.org's UTM guide.
- Keep responder/metasploit/impacket/netexec inside the VM. WiFi injection needs an external USB adapter.

## 6. VMware Fusion (optional backup hypervisor)
Free, but not on Homebrew (Broadcom login required). Download from the Broadcom portal if you want it
alongside UTM for snapshots / the occasional x86 guest.

## 7. Dotfiles with chezmoi
```bash
chezmoi init            # fresh (or `chezmoi init <your-repo>` if you have one)
# then add configs: chezmoi add ~/.zshrc ~/.config/ghostty/config ~/.config/starship.toml ...
```

## 8. Review + apply system tweaks
```bash
bash scripts/defaults.sh    # read it first
```

## 9. Finder sidebar favorites (optional)
Easiest: in Finder, **drag** the folders you use most (e.g. `Developer`, `Work`, `Personal`, `Inbox`,
`Screenshots`) into the sidebar Favorites. Or via CLI (needs password — it's a `.pkg`):
```bash
brew install --cask mysides
for p in "Developer" "Documents/Work" "Documents/Personal" "Documents/Inbox" "Screenshots"; do
  mysides add "$(basename "$p")" "file://$HOME/$p/"; done
killall Finder
```

## 10. Sign in to the GUI apps
Raycast, Bitwarden (migrate from LastPass), Obsidian, LM Studio, Cursor, browsers, Granola, etc.
