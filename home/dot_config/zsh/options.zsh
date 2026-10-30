# =============================================================================
# Zsh Options & Keybindings (~/.config/zsh/options.zsh)
# =============================================================================

# History configuration
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS      # Ignore duplicate history entries
setopt HIST_IGNORE_SPACE         # Ignore commands starting with a space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from history
setopt NO_SHARE_HISTORY          # Do not share history live across open tabs
setopt INC_APPEND_HISTORY        # Append commands to history immediately

# Safety & Navigation
setopt IGNOREEOF                 # Require typing 'exit' or 'logout' instead of ^D
setopt NOCLOBBER                 # Prevent overwriting existing files with '>' (use '>!' to force)
setopt AUTO_CD                   # Type directory name to cd into it
setopt INTERACTIVE_COMMENTS      # Allow comments (#) even in interactive shells

# Load Zsh massive move/rename module
autoload -Uz zmv

# Fuzzy match mistyped completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
