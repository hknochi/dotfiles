# show a message if there are stashed changes for current branch

show_branch_stash() {
  if [[ "$(git stash list 2>/dev/null)" != "" ]]
  then
    branchName="On $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [[ "$(git stash list 2>/dev/null | grep --color=never $branchName)" != "" ]]
    then
      echo
      echored "You have stashed changes:"
      git stash list 2>/dev/null | grep --color=never "$branchName"
    fi
  fi
}

add-zsh-hook precmd show_branch_stash