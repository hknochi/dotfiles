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
alias ....=' cd ../../..'
alias mmv='noglob zmv -W'

# http://rayninfo.co.uk/tips/zshtips.html
alias -g G='| grep -'
alias -g P='2>&1 | $PAGER'
alias -g L='| less'
alias -g LA='2>&1 | less'
alias -g M='| most'
alias -g C='| wc -l'

# fasd
alias j=' z'
alias js=' a -e subl'

alias g='git'
alias o='open'
alias s='subl && subl' # fix empty window if sublime was not running before opening file
alias v='vim'
alias d='docker'
alias rdf='rdf'
alias grep='grep --color=auto'
alias sign='gpg --detach-sign --armor'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias diskusage='ncdu'
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
export PRVT_DOCKER="docker --tlsverify --tlscacert=$HOME/.config/ssl/pki-hknochi/ca/docker-ca.cer --tlscert=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi.crt --tlskey=$HOME/.config/ssl/pki-hknochi/certs/docker/client/hknochi-rsa.key "

alias d-s1="$PRVT_DOCKER -H=docker-server1.hknochi.de:2375 "
alias d-s="$PRVT_DOCKER -H=docker.hknochi.de:2376 "
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

# fancy mac aliases
alias pw="pwgen -Cs 20 1 | tr -d ' ' | tr -d '\n' | pbcopy"
alias macfind="mdfind -name '$@'"

alias yt='docker run --rm -v `pwd`:/data vimagick/youtube-dl'
alias letsencrypt='docker run -it --rm -p 443:443 -p 80:80 --name certbot -v /Users/hknochenhauer/.config/letsencrypt:/etc/letsencrypt -v /Users/hknochenhauer/.config/letsencrypt-backups:/var/lib/letsencrypt quay.io/letsencrypt/letsencrypt:latest auth'

alias intellij="open -a 'IntelliJ IDEA'"
alias idea="intellij"