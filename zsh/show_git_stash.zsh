# show a message if there are stashed changes for current branch

show_branch_stash() {
  branchName=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ "$branchName" != "" ]]
  then
    if [[ "$(git stash list 2>/dev/null | grep --color=never $branchName)" != "" ]]
    then
      echo
      echoyellow "Stashes for current branch:"
      git stash list 2>/dev/null | grep -i --color=never "On $branchName"
    fi
  fi
}

add-zsh-hook precmd show_branch_stash