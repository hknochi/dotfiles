#!/bin/zsh

/usr/local/bin/git status $*

branchName=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [[ "$branchName" != "" ]]
then
  if [[ "$(git stash list 2>/dev/null | grep $branchName)" != "" ]]
  then
    echo
    echo "Stashed changes:"
    echo
    output=$(git stash list 2>/dev/null | grep -i --color=never "On $branchName")
    while read -r line; do
      echo -e "\t\e[0;33m$line\e[0m"
    done <<< "$output"
    echo
  fi
fi
