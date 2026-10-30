# =============================================================================
# Aliases (~/.config/zsh/aliases.zsh)
# Modernized for Apple Silicon (M4 Pro) & Rust-based CLI Replacements
# =============================================================================

# Enable alias expansion after sudo
alias sudo='sudo '

# -----------------------------------------------------------------------------
# Directory Listing (eza -> fallback to gls/ls)
# -----------------------------------------------------------------------------
if command -v eza &>/dev/null; then
  alias ls='eza --group-directories-first --icons=auto'
  alias l='eza -lh --group-directories-first --icons=auto --git'
  alias ll='eza -lh --group-directories-first --icons=auto --git'
  alias la='eza -lha --group-directories-first --icons=auto --git'
  alias lsa='eza -a --group-directories-first --icons=auto'
  alias lr='eza --tree --only-dirs --icons=auto'
  alias tree='eza --tree --group-directories-first --icons=auto'
elif command -v gls &>/dev/null; then
  alias ls='gls -Fh --color=auto --group-directories-first'
  alias lsa='ls -a'
  alias l='ls -l'
  alias ll='ls -l'
  alias la='ls -la'
  alias lr='tree -d'
  alias tree='tree -N --dirsfirst'
else
  alias ls='ls -GFh'
  alias l='ls -l'
  alias ll='ls -l'
  alias la='ls -la'
fi

# -----------------------------------------------------------------------------
# Modern CLI Replacements
# -----------------------------------------------------------------------------
# bat instead of cat
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias bcat='bat'
fi

# zoxide (replaces fasd 'j' / 'z')
if command -v zoxide &>/dev/null; then
  alias j='z'
  alias ji='zi'
fi

# ripgrep (replaces ack/grep)
if command -v rg &>/dev/null; then
  alias ack='rg'
fi
alias grep='grep --color=auto'

# btop (system monitor) & ncdu (disk usage)
command -v btop &>/dev/null && alias top='btop'
command -v ncdu &>/dev/null && alias diskusage='ncdu'
command -v lazygit &>/dev/null && alias lg='lazygit'

# -----------------------------------------------------------------------------
# Navigation & File Operations
# -----------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mmv='noglob zmv -W'
alias rsync='rsync -a -v --partial --progress'
alias rf='rm -rf'

# Global pipe aliases
alias -g G='| grep -'
alias -g P='2>&1 | $PAGER'
alias -g L='| less'
alias -g LA='2>&1 | less'
alias -g C='| wc -l'
alias -g CP='| pbcopy'

# -----------------------------------------------------------------------------
# Editors, Git, Docker & Enpass
# -----------------------------------------------------------------------------
alias g='git'
alias d='docker'
alias dc='docker compose'
alias o='open'
alias v='vim'

# Editors
alias c='cursor'
alias code='code'
alias zed='zed'
alias s='subl'
alias idea="open -a 'IntelliJ IDEA'"
alias intellij='idea'

# Dotfiles & Zsh quick edit via Chezmoi
alias dotfiles='chezmoi cd'
alias zshconfig='chezmoi edit --apply ~/.zshrc'

# Enpass CLI helper
alias enp='enpasscli -vault="${HOME}/Documents/Enpass/Vaults/primary/" -sort'

# -----------------------------------------------------------------------------
# GPG & Security Helpers
# -----------------------------------------------------------------------------
alias verify='gpg --verify'
alias signd='gpg --detach-sign --armor'
alias pw="pwgen -Cs 24 1 | tr -d ' \n' | pbcopy && echo 'Password copied to clipboard!'"

# -----------------------------------------------------------------------------
# macOS Helpers
# -----------------------------------------------------------------------------
alias hiddenfiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias updatedb="sudo /usr/libexec/locate.updatedb"

# Useful Dockerized CLI tools
alias ocr='docker run --rm -v "${PWD}:/home/docker" jbarlow83/ocrmypdf --skip-text'
alias hadolint='docker run --rm -i hadolint/hadolint'

# -----------------------------------------------------------------------------
# File Suffix Aliases (Type filename to open directly)
# -----------------------------------------------------------------------------
alias -s pdf='open'
alias -s md='open -a "Marked 2"'
alias -s {png,PNG,jpg,jpeg,JPG,JPEG,gif,svg,tif,tiff,psd}='open'
alias -s {avi,AVI,mov,mpg,m4v,mp4,MP4,ogg,ogv,flv,mkv,wav,mp3,webm}='open'
alias -s {ods,xls,xlsx,csv,pot,odt,doc,docx,rtf,ppt,pptx,odp}='open'
alias -s json='bat'
alias -s {yml,yaml}='bat'
alias -s pem='openssl x509 -noout -text -in'
alias -s plist='plutil'
