# hknochi's Dotfiles (macOS / Apple Silicon M4 Pro)

Modern, declarative macOS dotfiles managed with **[Chezmoi](https://www.chezmoi.io/)** and **[Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle)**, tailored for Apple Silicon (`M4 Pro` / `/opt/homebrew`).

---

## ✨ What's Inside

- **Framework:** [Chezmoi](https://www.chezmoi.io/) (`home/` source state, templates, automatic setup scripts)
- **Package Management:** [Homebrew Bundle](Brewfile) (`brew`, `cask`, fonts, and developer apps)
- **Shell:** `zsh` + [Oh-My-Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) + `zsh-autosuggestions` & `zsh-syntax-highlighting`
- **Modern CLI Tooling (Rust/Go replacements):**
  - [`eza`](https://github.com/eza-community/eza) → replaces `ls` / `tree` (with Git status & Nerd Font icons)
  - [`bat`](https://github.com/sharkdp/bat) → replaces `cat` (syntax highlighting)
  - [`ripgrep`](https://github.com/BurntSushi/ripgrep) (`rg`) → replaces `grep` / `ack`
  - [`fd`](https://github.com/sharkdp/fd) → replaces `find`
  - [`zoxide`](https://github.com/ajeetdsouza/zoxide) (`z` / `j`) → replaces `fasd`
  - [`fzf`](https://github.com/junegunn/fzf) → fuzzy finder (`Ctrl+R`, `Ctrl+T`, `Alt+C`)
  - [`delta`](https://github.com/dandavison/delta) & [`lazygit`](https://github.com/jesseduffield/lazygit) → modern Git diff pager & terminal UI
  - [`fnm`](https://github.com/Schniz/fnm) & [`uv`](https://github.com/astral-sh/uv) → blazingly fast Node.js & Python managers
  - [`btop`](https://github.com/aristocratos/btop) & [`ncdu`](https://dev.yorhel.nl/ncdu) → system & disk monitors
- **Containers:** [OrbStack](https://orbstack.dev/) (lightweight, native Apple Silicon Docker & Linux runtime)
- **Security & Passwords:** [Enpass](https://www.enpass.io/) + `enpasscli` (`enp` alias) + `gnupg` (`pinentry-mac`)
- **Editors:** Cursor, VS Code, Zed, and Sublime Text 4

---

## 🚀 Quick Start (New MacBook M4 Pro Setup)

### Option 1: One-Line Bootstrap via Chezmoi
On a fresh Mac, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply hknochi
```

### Option 2: Clone & Run `bootstrap.sh`
```bash
git clone https://github.com/hknochi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

During the first run, Chezmoi will prompt you for your Git identity (`name`, `email`, `signingkey`), install all packages and apps from the [`Brewfile`](Brewfile), set up Oh-My-Zsh & Powerlevel10k, and apply sensible macOS developer defaults.

---

## 📂 Repository Structure

```text
.
├── .chezmoiroot                        # Points Chezmoi to the home/ directory
├── Brewfile                            # Declarative Homebrew packages, casks & fonts
├── bootstrap.sh                        # Standalone bootstrap script for fresh Macs
├── iterm2/                             # iTerm2 profile & preferences
└── home/                               # Chezmoi target state (~/)
    ├── .chezmoi.toml.tmpl              # Interactive config template (Git name/email/key)
    ├── .chezmoiignore                  # Files ignored in target ~ directory
    ├── dot_gitconfig.tmpl              # ~/.gitconfig (Delta pager, GPG, aliases)
    ├── dot_gitignore_global            # ~/.gitignore_global
    ├── dot_p10k.zsh                    # ~/.p10k.zsh (Powerlevel10k prompt config)
    ├── dot_zprofile                    # ~/.zprofile (Apple Silicon Homebrew & PATH)
    ├── dot_zshrc                       # ~/.zshrc (Oh-My-Zsh, P10k, fzf, zoxide, fnm)
    ├── dot_config/zsh/                 # ~/.config/zsh/ modular shell configuration
    │   ├── aliases.zsh                 # Modern CLI aliases (eza, bat, rg, zoxide, git)
    │   ├── exports.zsh.tmpl            # Environment variables & editor config
    │   ├── functions.zsh               # Shell helper functions
    │   └── options.zsh                 # Zsh history, completion & navigation options
    ├── dot_local/bin/                  # ~/.local/bin/ helper scripts
    │   ├── executable_git-mail         # Interactive repo email selector on git init/clone
    │   └── executable_git-status       # Git status with branch stash indicator
    ├── private_dot_ssh/
    │   └── private_config.tmpl         # ~/.ssh/config (macOS Keychain & OrbStack)
    ├── private_Library/.../Sublime Text/ # Sublime Text 4 User settings & keymaps
    ├── run_onchange_before_10-install-packages.sh.tmpl # Auto-runs Brewfile & OMZ setup
    └── run_once_after_20-macos-defaults.sh.tmpl        # Sets macOS developer defaults
```

---

## 🛠️ Daily Usage

| Task | Command |
| :--- | :--- |
| Edit a dotfile | `chezmoi edit --apply ~/.zshrc` (or `zshconfig`) |
| Go to dotfiles directory | `chezmoi cd` (or `dotfiles`) |
| Preview pending changes | `chezmoi diff` |
| Apply changes | `chezmoi apply` |
| Pull latest changes & apply | `chezmoi update` |
| Update Brew, OMZ & system | `update` |
| Reconfigure Powerlevel10k | `p10k configure` |
