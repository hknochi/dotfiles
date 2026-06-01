#!/usr/bin/env bash

set -e

CONFIG="install.conf.yaml"
LOCAL_CONFIG="sfdc-cc/install.conf.yaml"
DOTBOT_DIR="submodules/dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install Homebrew if missing (prerequisite for all shell steps in the config)
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found — installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is on PATH (Apple Silicon installs to /opt/homebrew)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

cd "${BASEDIR}"
git submodule update --init --recursive "${DOTBOT_DIR}"

# Main install pass
python3 "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

# Optional local/work-specific install pass (sfdc-cc submodule)
if [[ -f "${BASEDIR}/${LOCAL_CONFIG}" ]]; then
  echo "Running local install steps from ${LOCAL_CONFIG}..."
  python3 "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${LOCAL_CONFIG}" "${@}"
fi
