#!/bin/sh

set -eu

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
  set -x
fi

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
  if ! command -v lefthook > /dev/null 2>&1; then
    _fail "Setup requires Lefthook, please install first: \`brew install lefthook\`"
    exit 1
  fi
  if ! command -v talisman > /dev/null 2>&1; then
    _fail "Setup requires Talisman, please install first: \`brew install talisman\`"
    exit 1
  fi
  _info "Installing Git hooks..."
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
  "setup") _setup ;;
  *) _help ;;
esac
