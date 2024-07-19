#!/bin/bash

# Run to avoid repeated entering in your ssh-key
# eval "$(ssh-agent)"
# ssh-add

# Source the config file
if [ -f config.sh ]; then
  source config.sh
else
  echo "Configuration file not found!"
  exit 1
fi

# Command line option to only sync
sync_only=false

# Parse command-line options
while getopts "s" opt; do
  case ${opt} in
    s)
      sync_only=true
      ;;
    *)
      echo "Usage: $0 [-s]"
      exit 1
      ;;
  esac
done

# Sync directories
unison "$SOURCE_DIR" "ssh://$SSH_HOST$DESTINATION_DIR" \
  -ignore 'Path tmp/cache/' \
  -ignore 'Path tmp/pids/' \
  -ignore 'Path tmp/sockets/' \
  -ignore 'Path tmp/sessions/' \
  -ignore 'Path tmp/bootsnap/' \
  -ignore 'Path log/' \
  -ignore 'Name Gemfile.lock' \
  -ignore 'Name .env*' \
  -ignore 'Path public/assets/' \
  -ignore 'Path public/packs/' \
  -ignore 'Path .git/'

# Run server
if ! $sync_only; then
  ssh -t $SSH_HOST "cd /Users/raymondliu$DESTINATION_DIR && bin/rails server"
fi
