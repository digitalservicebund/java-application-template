#!/usr/bin/env bash

set -euo pipefail

_fail() {
  printf "\033[0;31m==> %s\033[0m\n" "$1"
}

_success() {
  printf "\033[0;32m==> %s\033[0m\n" "$1"
}

_info() {
  printf "\033[1;33m==> %s\033[0m\n" "$1"
}

_setup() {
  if ! command -v lefthook &> /dev/null
  then
    _fail "lefthook could not be found, please install first: \`brew install lefthook\`"
    exit
  fi
  _info "Installing git hooks..."
  lefthook install
  _success "Done"
}

_help() {
  echo "Usage: ./run.sh [command]"
  echo ""
  echo "Available commands:"
  echo "setup               Set up repository for development"
}

case "$@" in
"setup") _setup;;
*) _help;;
esac
