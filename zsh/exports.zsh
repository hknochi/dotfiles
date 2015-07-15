# Path expansion
export PATH=$HOME/.bin:$PATH # add user binaries to path
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$HOME/.dotfiles/eccenca/bin:$PATH
# Load all files from .dotfiles/zsh/ directory
if [ -d $HOME/.dotfiles/eccenca ]; then
  for file in $HOME/.dotfiles/eccenca/*.zsh; do
    source $file
  done
fi

# nvm config
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export ANDROID_HOME=/usr/local/opt/android-sdk

# export docker host address
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Java home
export JAVA_HOME="$(/usr/libexec/java_home)"
