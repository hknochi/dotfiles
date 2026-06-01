# Path expansion
export PATH="/opt/homebrew/bin/vsts-npm-auth:/opt/homebrew/bin/grunt:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

export PATH=$HOME/.bin:$PATH # add user binaries to path
export PATH=/usr/local/opt/openssl@1.1/bin:$PATH # add custom openssl version
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.dotfiles/sfdc-cc/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# run configuration scripts found in conf/init
if [ "$(ls $HOME/.dotfiles/sfdc-cc/source)" ]; then
  for init in $HOME/.dotfiles/sfdc-cc/source/*.sh; do
    . $init
  done
fi

# nvm config
#export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh

#gpg config
export GPG_TTY=$(tty)

export NODE_EXTRA_CA_CERTS="$HOME/.dotfiles/sfdc-cc/certs/npm-sfdc-certs.pem"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

#for OpenJDK
export PATH=$PATH:$JAVA_HOME/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#zsh-completion
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

