# =============================================================================
# Shell Functions (~/.config/zsh/functions.zsh)
# =============================================================================

# Create a new directory and enter it
function mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Create a date-prefixed directory (YYYY-MM-DD or YYYY-MM-DD-name)
function mkdate() {
  local name
  name="$(date +%Y-%m-%d)"
  if [[ -n "${1:-}" ]]; then
    name="${name}-${1}"
  fi
  mkdir -p "${name}" && cd "${name}"
}

# Edit Markdown file and preview in Marked 2
function markdown() {
  open -a "Marked 2" "$@"
  ${VISUAL:-subl} "$@"
}

# Smart Git wrapper: prompts for repository email after `git init` or `git clone`
function git() {
  local lastArgument=""
  for i in "$@"; do
    lastArgument="$i"
  done

  command git "$@"
  local exit_code=$?

  if [[ $exit_code -eq 0 ]]; then
    if [[ "${1:-}" == "init" || "${1:-}" == "clone" ]]; then
      if [[ "${1:-}" == "init" && "${lastArgument}" == "--bare" ]]; then
        return 0
      fi
      if [[ -d "${lastArgument}" ]]; then
        cd "${lastArgument}" || return 0
      elif [[ "${1:-}" == "clone" ]]; then
        local repo_dir
        repo_dir="$(basename "${lastArgument}" .git)"
        [[ -d "${repo_dir}" ]] && cd "${repo_dir}"
      fi
      command -v git-mail &>/dev/null && git-mail
    fi
  fi
  return $exit_code
}

# Sign a file with GPG clearsign
function sign() {
  if [[ -z "${1:-}" ]]; then
    echo "Usage: sign <file>"
    return 1
  fi
  local base="${1:t:r}"
  local ext="${1:e}"
  gpg --clearsign --output="${base}.signed.${ext}" "${1}"
}

# Create a .tar.gz archive from a directory + SHA256 checksum
function maketar() {
  local target="${1%%/}"
  tar cvzf "${target}.tar.gz" "${target}/"
  shasum -a 256 "${target}.tar.gz"
}

# Create a .zip archive from a directory + SHA256 checksum
function makezip() {
  local target="${1%%/}"
  zip -r "${target}.zip" "$1"
  shasum -a 256 "${target}.zip"
}

# Full system & dotfiles update (macOS Homebrew + Chezmoi + Oh-My-Zsh)
function update() {
  echo "🍺 Updating Homebrew packages..."
  brew update && brew upgrade && brew cleanup

  if command -v omz &>/dev/null; then
    echo "🐚 Updating Oh-My-Zsh..."
    omz update
  fi

  if command -v chezmoi &>/dev/null; then
    echo "🏠 Checking dotfiles status..."
    chezmoi status
  fi
}

# Determine size of a file or total size of a directory
function fs() {
  if [[ -n "$*" ]]; then
    du -sh -- "$@"
  else
    du -sh .[^.]* ./* 2>/dev/null
  fi
}

# Create a base64 data URL from a file
function dataurl() {
  local mimeType
  mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Show all names (CNs and SANs) listed in the SSL certificate for a given domain
function getcertnames() {
  if [[ -z "${1:-}" ]]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo ""

  local tmp
  tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

  if [[ "${tmp}" == *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText
    certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version")
    echo "Common Name:"
    echo ""
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" -e "s/\/emailAddress=.*//"
    echo ""
    echo "Subject Alternative Name(s):"
    echo ""
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found."
    return 1
  fi
}

# Batch OCR PDFs in a directory using Dockerized ocrmypdf
function do_ocr() {
  local dir="${1:-.}"
  find "$dir" -maxdepth 1 -type f -name "*.pdf" ! -name "*.ocr.pdf" | while read -r file; do
    local base="${file:t:r}"
    local ext="${file:e}"
    local out="${dir}/${base}.ocr.${ext}"
    if [[ -f "${out}" ]]; then
      echo "Skipping ${file} (already OCR'ed)"
      continue
    fi
    echo "Running OCR on ${file} -> ${out}"
    ocr "${file}" "${base}.ocr.${ext}"
  done
}
