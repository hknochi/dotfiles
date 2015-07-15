# ignore duplicate history entries
setopt hist_ignore_all_dups
# do not share global history
setopt no_share_history
# forces the user to type exit or logout, instead of just pressing ^D
setopt ignoreeof
# prevents accidentally overwriting an existing file while clobbering
setopt noclobber

# Set keystrokes for zsh-users/zsh-history-substring-search plugin
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# zsh's massive move/rename module
autoload zmv

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'