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

function lpass-ssh-add(){
  KEY_NAME=$1

  if ! ( which lpass > /dev/null ); then
    echo "LastPass CLI is required."
  fi

  # Require something to be passed to this command
  if [ -z "${KEY_NAME}" ]; then
    echo "You need to specify a key name."
  fi

  # Try to find the passed key path / name
  if ! [ -e "${KEY_NAME}" ]; then
    if [ -e "${HOME}/.ssh/${KEY_NAME}" ]; then
      KEY_NAME="${HOME}/.ssh/${KEY_NAME}"
    else
      echo "Could not find key file."
    fi
  fi

  local username="${CUSTOM_MAIL_ADDRESS}"
  echo "debug ..."
  local lp_status=$(lpass status)

  if [ $? -ne 0 ]
  then
      if [ "${lp_status}" = 'Not logged in.' ]
      then
        # Make sure DISPLAY is set
        DISPLAY=${DISPLAY:-:0} lpass login "${username}" 1>&2
          else
        echo "Lastpass error: ${lp_status}" 1>&2
        exit 1
      fi
  fi

  echo "SSH passhprase? "; read passhprase; \
  lpass add --non-interactive \
  --note-type=ssh-key \
  --sync=now \
  "SSH: $(basename ${KEY_NAME})"  <<EOF
Passphrase: $(echo "${passhprase}")
NoteType: SSH Key
Private Key: $(awk -v ORS='\\n' '1' ${KEY_NAME})
Public Key:  $(cat ${KEY_NAME}.pub)
Date: $(date "+%d.%m.%Y")
EOF
}

# edit markdown files with Sublime Text and view them with Marked 2
function markdown() {

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
      git-mail
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
    echo "\033[31mrunning custom command\033[0m"
    subcommand=$1
    shift
    docker-$subcommand $@
  else
    /usr/local/bin/docker $@
  fi
}

kubectl() {
  if command -v "kubectl-$1" > /dev/null 2>&1; then
    echo "\033[31mrunning custom command\033[0m"
    subcommand=$1
    shift
    kubectl-$subcommand $@
  else
    /usr/local/bin/kubectl $@
  fi
}

terraform() {
  if command -v "terraform-$1" > /dev/null 2>&1; then
    echo "\033[31mrunning custom command\033[0m"
    subcommand=$1
    shift
    terraform-$subcommand $@
  else
    /usr/local/bin/terraform $@
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

#convert skeletton
convert(){
  if [ -f $1 ] ; then
    filename="${1##*/}"              # Strip longest match of */ from start
    base="${filename%.[^.]*}"               # Strip shortest match of . plus at least one non-dot char from end
    ext="${filename:${#base} + 1}"          # Substring from len of base thru end
    if [[ -z "$base" && -n "$ext" ]]; then  # If we have an extension and no base, it's really the base
        base=".$ext"
        ext=""
    fi

    //check the file extension
    case $1 in
      *.heic) docker run -it --rm -v ${PWD}:/data -w /data --entrypoint /tifig/build/tifig monostream/tifig -v -i "$1" -o "$base.jpg" ;;
      *.mov) docker run --rm -v  ${PWD}:/data -w /data --entrypoint ffmpeg vimagick/youtube-dl -i "$1" -vcodec h264 -acodec copy "$base.mp4" ;;
      *) echo "'$1' cannot be converted via convert()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#adjust creation dsate of pictures
pictureCreationDate(){
  timestamp=$(mdls -name kMDItemContentCreationDate "$1" | awk '{print $3 $4}')
  timestamp="${timestamp//-}"
  timestamp="${timestamp//:}"
  timestamp="${timestamp:0:-2}"
  touch -t "$timestamp" "$1"
}
adjustCreationDate (){
  if [ -f $1 ] ; then
    //check the file extension
    case $1 in
      *.jpeg) pictureCreationDate "$1" ;;
      *.png) pictureCreationDate "$1" ;;
      *.gif) pictureCreationDate "$1" ;;
      *.jpg) pictureCreationDate "$1" ;;
      *.mov) pictureCreationDate "$1" ;;
      *) echo "'$1' cannot adjust creationDate via adjustCreationDate()" ;;
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
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
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

function mkdate() {
  name=$(date --iso)
  if [ ! -z "${1}" ]; then
    name="${name}-${1}"
  fi;
  mkdir -p ${name}
}

function restructure(){
  IFS=$'\n'
  find . -maxdepth 1 -type f ! -iname ".*" | egrep -v '^./[0-9]{4}-[0-9]{2}' | while read FILE;
  do
    DIR=$(date -r "$FILE" "+%Y-%m")
    FILE_DATE=$(date -r "$FILE" "+%Y-%m-%d")
    [[ -d $DIR ]] || mkdir -p "${DIR}"
    mv "$FILE" "$DIR/${FILE_DATE}-${FILE#*/}"
  done
  for dir in $(find . -maxdepth 1 -type d ! -iname ".*" -print | egrep -v '^./[0-9]{4}-[0-9]{2}' )
  do
    echo "${dir}"
    date_dir=$(stat "${dir}" | grep Modify |  awk '{ print $2}'| cut -f1,2 -d'-')
    echo "${date_dir}"
    [[ -d "${date_dir}" ]] || mkdir -p "${date_dir}"
    if [[ -d "${date_dir}" ]]
      then
      echo 'move '"${dir}"' to '"${date_dir}"
      mv -f "${dir}" "${date_dir}"
    else
      echo "${date_dir}" 'creat failed'
    fi
  done
}

function do_ocr(){
  OCR_COUNT=0
  DIR=${1}
  find $DIR -maxdepth 1 -type f -name "*.pdf" ! -name "*.ocr.pdf" | while read FILE;
  do
    if [ -f "$DIR/${$(basename "$FILE")%.*}.ocr.${$(basename "$FILE")##*.}" ]; then
      echo "skip $FILE because already ocr'ed"
      continue
    fi
    if [ $OCR_COUNT -lt 16 ]; then
      echo ocr "${FILE}" "${$(basename "$FILE")%.*}.ocr.${$(basename "$FILE")##*.}"
      ocr "${FILE}" "${$(basename "$FILE")%.*}.ocr.${$(basename "$FILE")##*.}" &
      let OCR_COUNT=OCR_COUNT+1
    fi
  done
}

docker-pull-refresh() {
local image=$1
local exitCode
docker pull "$image" &
while : ; do
  timeout 5s docker pull "$image"  > /dev/null 2> /dev/null
  local exitCode=$?
  if [ ! "124" = "${exitCode}" ]; then
    break
  fi
done
}

#TODO
# generate server cert (with serial)
# generate client cert (with serial)
# sign client cert
