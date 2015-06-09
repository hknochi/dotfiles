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