# ls
# use GNU ls command (brew install coreutils)
alias ls=' gls -Fh --color=auto --group-directories-first'
alias lsa=' ls -a'
alias l=' ls -l'
alias ll=' ls -l'
alias la=' ls -la'
alias lr=' tree -d'
alias cd=' cd'
alias ..=' cd ..'
alias ...=' cd ../..'

# fasd
alias j=' z'
alias js=' a -e subl'

alias g='git'
alias o='open'
alias s='subl && subl' # fix empty window if sublime was not running before opening file
alias v='vim'
alias d='docker'
alias rdf='rdf'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias diskusage='ncdu'
alias rf='rm -rf'
alias rm='trash'

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '

# zsh
alias zshconfig="subl ~/.zshrc"

# os x 
alias hiddenfiles="defaults write com.apple.finder AppleShowAllFiles NO"
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles YES"

#####Privat
# docker private
export PRVT_DOCKER="docker --tlsverify --tlscacert=$HOME/.config/ssl/pki-hknochi/ca/docker-ca.cer --tlscert=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi.crt --tlskey=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi-rsa.key "

alias d-s1="$PRVT_DOCKER -H=docker-server1.hknochi.de:2376 "
alias d-htwk="$PRVT_DOCKER -H=docker-htwk.hknochi.de:2375 "

alias ecc-d-i="ecc-docker-includes "

alias private="$HOME/Documents/encfslogin.sh"

####ECCENCA
# Docker Config
export ECC_DOCKER="--tlsverify --tlscacert=$HOME/.config/ssl/docker-eccenca/ca.pem --tlscert=$HOME/.config/ssl/docker-eccenca/client-cert.pem --tlskey=$HOME/.config/ssl/docker-eccenca/client-key.pem "
export ECC_DOCKER_PORT="2375"
# docker
alias d-p1="docker $ECC_DOCKER -H=p1.eccenca.com:$ECC_DOCKER_PORT"
alias d-p2="docker $ECC_DOCKER -H=p2.eccenca.com:$ECC_DOCKER_PORT"
alias d-mopsos="docker $ECC_DOCKER -H=mopsos.eccenca.com:$ECC_DOCKER_PORT"
alias d-idas="docker $ECC_DOCKER -H=idas.eccenca.com:$ECC_DOCKER_PORT"
alias d-kepheus="docker $ECC_DOCKER -H=kepheus.eccenca.com:$ECC_DOCKER_PORT"
# get a running instance of our eccenca-base image
alias ubuntu=runUbuntu

# ansible 
alias server='ansibleWrapper'
