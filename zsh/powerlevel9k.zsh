POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=".."
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

#zsh_git_version(){
#  if git rev-parse --git-dir > /dev/null 2>&1; then
#    git describe --dirty --always
#  fi
#}

#POWERLEVEL9K_CUSTOM_GIT_VERSION="zsh_git_version"
#POWERLEVEL9K_CUSTOM_GIT_VERSION_BACKGROUND="green"

POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs )
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_git_version status root_indicator background_jobs time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)