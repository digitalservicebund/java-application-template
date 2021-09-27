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

_user() {
  printf "\033[0;33m%s\033[0m" "$1"
}

_init() {
  defaultname="$(basename "$(git rev-parse --show-toplevel)")"
  _user "What is the name of the application? ($defaultname) "
  read -r name
  newname=$name
  if [ -z "$newname" ]; then
    newname=$defaultname
  fi
  grep -rlZ 'java-application-template' --exclude-dir=.git --exclude-dir=.gradle --exclude-dir=.idea --exclude-dir=build --exclude=run.sh . | xargs sed -i '' 's/java-application-template/'"$newname"'/g'
  _info "Renamed, please commit the changes! You might have to adapt the package structure as well.."
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
  echo "init                Initialize repository with name (after creating from template)"
  echo "setup               Set up repository for development"
}

case "$@" in
  "init") _init ;;
  "setup") _setup ;;
  *) _help ;;
esac
