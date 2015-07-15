#!/bin/bash

# bash prompt which asks for email address
# to configure for current git repository

# set your available emails
MAILS=(${MAIL_ADDRESSES})

# prompt for email
echo
echo "Which email address should be configured for this repository?"
echo
echo "Press [Enter] to abort..."
echo
for ((i = 0; i < ${#MAILS[*]}; i++))
do
  echo "$(tput bold)$(($i + 1))$(tput sgr 0): ${MAILS[$i]}"
done
echo
echo -n "email: "
read -n 1 email
echo
echo

# abort when pressing enter
if [[ "$email" == "" ]]
then
  echo "$(tput setaf 3)abort$(tput sgr 0): No email set."
  exit 0
fi

# error if entered number is less than 1 or greater than size of emails
if [[ $email -lt "1" || $email -gt ${#MAILS[*]} ]]
then
  echo "$(tput setaf 1)error$(tput sgr 0): Unknown email $(tput bold)$email$(tput sgr 0)"
  exit 1
fi

# set email
echo "Set '${MAILS[$(($email - 1))]}' as email address for this repository."
git config user.email ${MAILS[$(($email - 1))]}

exit 0

# EOF