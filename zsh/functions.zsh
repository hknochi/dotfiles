# additional functions to load
fpath=(/usr/local/share/zsh-completions $fpath)

# add new line before prompt
#precmd() { print "" }

# takes an input command name and checks for availability with which
# credits: https://github.com/seebi/rdf.sh/blob/master/rdfw
_checkTool() {

    tool=$1
    if [[ "$tool" == "" ]]
    then
        echo "checkTool error: need an parameter"
        exit 1
    fi

    for tool in $*
    do
        check=`which $tool 2>/dev/null >/dev/null`
        if [[ "$?" == "1" ]]
        then
            echo "Error: you need '$tool' for this command."
            exit 1
        fi
    done
}

# extend rdf tool
# https://github.com/seebi/rdf.sh
function rdf() {

  _checkTool rdf

  if [[ "$1" = "ns" ]] # extend ns parameter to copy namespace to clipboard too
  then
    namespace=$(/usr/local/bin/rdf ns $2)
    echo "$namespace"
    echo "$namespace" | perl -ne 'chomp and print' | pbcopy
  elif [[ "$1" = "desc" ]]
  then
    _checkTool pygmentize
    data=$(any23 rover -t -f turtle $2)
    echo "$data" | pygmentize -l turtle
  else
      /usr/local/bin/rdf $@
  fi
}

# edit markdown files with Sublime Text and view them with Marked 2
function md() {

  open -a Marked\ 2 $*
  subl && open -a Sublime\ Text $*
}

# email prompt for new git repositories
function git() {

  for i do
        lastArgument=$i # last argument can be the directory or the repository url
  done

  /usr/local/bin/git $@

  if [[ $? -eq 0 ]] # only show prompt if git command was successful
  then
    if [[ "$1" = "init" || "$1" = "clone" ]]
    then
      if [[ -d "$lastArgument" ]]
      then
        # it was the directory argument, cd it
        cd $lastArgument
      else
        if [[ "$1" = "clone" ]]
        then
          # no directory given, parse it from repository url
          cd $(echo $lastArgument | awk -F/ '{ print $NF }' | rev | sed 's/tig.//' | rev)
        else if [[ "$1" = "init" && "$lastArgument" = "--bare" ]]
          return 0
        fi
      fi
      git-email-prompt
    fi
  else
    # return the exit code of the failed git command call
    return $?
  fi
}

# http://lucapette.me/docker/a-couple-of-useful-aliases-for-docker/
# to add a custom docker command, make an executable named "docker-COMMAND" available in your path
# example: add docker-psa to your path to have the command "docker psa"
docker() {
  if command -v "docker-$1" > /dev/null 2>&1; then
    subcommand=$1
    shift
    docker-$subcommand $@
  else
    /usr/local/bin/docker $@
  fi
}

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Creates an archive (*.tar.gz) from given directory.
maketar () {
  tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
  md5 ${1%%/}.tar.gz;
}

# Creates an archive (*.zip) from given directory.
makezip () {
  zip -r "${1%%/}.zip" "$1" ;
  md5 ${1%%/}.zip;
}

update () {
case "$(uname -s)" in

   Darwin)
     echo 'Mac OS X'
     brew update && brew upgrade
     ;;

   Linux)
     echo 'Linux'
     sudo apt-get update && sudo apt-get upgrade
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
     ;;

   *)
     echo 'other OS (or missing cases for above OSs)' 
     ;;
esac
}

## system
# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* *;
	fi;
}
# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}
# Create a git.io short URL
function gitio() {
	if [ -z "${1}" -o -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`";
		return 1;
	fi;
	curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

####ECCENCA

ansibleWrapper(){
  ansible webservers -a "$1" --sudo -K  -i ~/.config/ansible_hosts
}

ecc-docker-includes(){
  git submodule add ssh://git@gitlab.eccenca.com:8101/devops/docker-includes.git includes
  git submodule init; git submodule update
  ln -s includes/Makefile.dist Makefile
  cp includes/Dockerfile.dist Dockerfile
  cp includes/README.md.dist README.md
  cp includes/Dockerignore .dockerignore
}

runUbuntu(){
    if [ -f $1 ] ; then
        case $1 in
            p1) d-$1 run --rm -it -p 49500:80 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker docker-registry.eccenca.com/eccenca-base /bin/bash ;;
            p2) d-$1 run --rm -it -p 49500:80 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker docker-registry.eccenca.com/eccenca-base /bin/bash ;;
            idas) d-$1 run --rm -it -p 49500:80 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker docker-registry.eccenca.com/eccenca-base /bin/bash ;;
            kepheus) d-$1 run --rm -it -p 49500:80 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker docker-registry.eccenca.com/eccenca-base /bin/bash ;;
            mopsos) d-$1 run --rm -it -p 49500:80 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker docker-registry.eccenca.com/eccenca-base /bin/bash ;;
            esac
    else
         docker run --rm -it ubuntu:14.04 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker /bin/bash
    fi
}

#TODO
# generate server cert (with serial)
# generate client cert (with serial)
# sign client cert
