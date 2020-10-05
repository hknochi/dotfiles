# ls
# use GNU ls command (brew install coreutils)
alias ls=' gls -Fh --color=auto --group-directories-first'
alias lsa=' ls -a'
alias l=' ls -l'
alias ll=' ls -l'
alias la=' ls -la'
alias lr=' tree -d'
alias rsync='rsync -a -v --partial --progress'
alias cd=' cd'
alias ..=' cd ..'
alias ...=' cd ../..'
alias ....=' cd ../../..'
alias mmv='noglob zmv -W'

# http://rayninfo.co.uk/tips/zshtips.html
alias -g G='| grep -'
alias -g P='2>&1 | $PAGER'
alias -g L='| less'
alias -g LA='2>&1 | less'
alias -g M='| most'
alias -g C='| wc -l'
alias -g CP=' | pbcopy'

# fasd
alias j=' z'
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

alias g='git'
alias o='open'
alias s='subl && subl' # fix empty window if sublime was not running before opening file
alias v='vim'
alias d='docker'
alias k='kubectl'
alias tf='terraform'
alias tg='terragrunt'
alias rdf='rdf'
alias grep='grep --color=auto'
alias sign='function _blah(){ gpg --clearsign --output=${$(basename "$1")%.*}.signed.${$(basename "$1")##*.} ${1};  };_blah'
alias verify='gpg --verify'
alias signd='gpg --detach-sign --armor'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias diskusage='ncdu'
alias rm="rmtrash"
alias del="rmtrash"
alias trash="rmtrash"
alias rf='rm -rf'
alias tree='tree -N --dirsfirst' # support unicode characters

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '

# zsh
alias zshconfig="subl ~/.zshrc"

# os x
alias hiddenfiles="defaults write com.apple.finder AppleShowAllFiles NO"
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles YES"

#####Privat
# docker private
export PRVT_DOCKER="/usr/local/Cellar/docker/1.11.1/bin/docker --tlsverify --tlscacert=$HOME/.config/ssl/pki-hknochi/ca/docker-ca.cer --tlscert=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi.crt --tlskey=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi-rsa.key "
export DEV_DOCKER="docker --tlsverify --tlscacert=$HOME/.config/ssl/docker-hknochi/ca.pem --tlscert=$HOME/.config/ssl/docker-hknochi/cert.pem --tlskey=$HOME/.config/ssl/docker-hknochi/key.pem "

alias d-s="$DEV_DOCKER -H=docker.hknochi.de:2376 "
alias d-skrbnmb="$DEV_DOCKER -H=skrbnmb.hknochi.de:2376 "
alias d-htwk="$PRVT_DOCKER -H=docker-htwk.hknochi.de:2375 "
alias dm="docker-machine"
alias private="$HOME/Documents/encfslogin.sh"

# file suffix aliases
alias -s pdf="o"
alias -s md="open -a /Applications/Marked\ 2.app"
alias -s {png,PNG,jpg,jpeg,JPG,JPEG}="o"
alias -s jar="java -jar"
alias -s deb="sudo dpkg -i"
alias -s gpg="gpg"
alias -s iso="vlc"
alias -s avi=" open"
alias -s AVI=" open"
alias -s mov=" open"
alias -s mpg=" open"
alias -s m4v=" open"
alias -s mp4=" open"
alias -s rmvb=" open"
alias -s MP4=" open"
alias -s ogg=" open"
alias -s ogv=" open"
alias -s flv=" open"
alias -s mkv=" open"
alias -s wav=" open"
alias -s mp3=" open"
alias -s webm=" open"

alias -s tif="open"
alias -s tiff="open"
alias -s png="open"
alias -s jpg="open"
alias -s jpeg="open"
alias -s JPG="open"
alias -s gif="open"
alias -s svg="open"
alias -s psd="open"

alias -s com="open"
alias -s de="open"
alias -s org="open"

alias -s rdf="rapper --count"
alias -s owl="rapper --count"
alias -s ttl="rapper -i turtle --count"
alias -s tt="rapper -i turtle --count"
alias -s n3="rapper -i turtle --count"
alias -s nq="rapper -i nquads --count"
alias -s nt="rapper -i ntriples --count"
alias -s ntriples="rapper -i ntriples --count"
alias -s ntriple="rapper -i ntriples --count"
alias -s trig="rapper -i trig --count"

alias -s ods="open"
alias -s xls="open"
alias -s xlsx="open"
alias -s csv="open"

alias -s pot="open"
alias -s odt="open"
alias -s doc="open"
alias -s docx="open"
alias -s rtf="open"
alias -s dot="dot -Tpng -O"

alias -s ppt="open"
alias -s pptx="open"
alias -s odp="open"

alias -s plist="plutil"
alias -s log="open"

alias -s sla="open"

alias -s tjp="tj3"
alias -s asc="gpg"
alias -s pem="openssl x509 -noout -text -in "

alias -s zip="extract $@"
alias -s rar="extract $@"
alias -s tar.gz="extract $@"
alias -s 7z="extract $@"

# fancy mac aliases
alias pw="pwgen -Cs 20 1 | tr -d ' ' | tr -d '\n' | pbcopy"
alias macfind="mdfind -name '$@'"

alias yt='docker run --rm -v `pwd`:/data vimagick/youtube-dl'
alias ytmp3="yt '$@' --extract-audio --audio-format mp3 --audio-quality 0  -v"
alias letsencrypt='docker run -it --rm -p 443:443 -p 80:80 --name certbot -v /Users/hknochenhauer/.config/letsencrypt:/etc/letsencrypt -v /Users/hknochenhauer/.config/letsencrypt-backups:/var/lib/letsencrypt quay.io/letsencrypt/letsencrypt:latest auth'

alias ocr='docker run --rm -v "`pwd`:/home/docker" jbarlow83/ocrmypdf --skip-text'
alias hadolint='docker run --name hadolint --rm -i lukasmartinelli/hadolint '
alias groovy='docker run --rm -it -v "$PWD":/home/groovy/scripts -w /home/groovy/scripts -v grapes-cache:/home/groovy/.groovy/grapes groovy groovy'
alias intellij="open -a 'IntelliJ IDEA'"
alias idea="intellij"

export PATH=$PATH:/Users/hknochenhauer/bin


