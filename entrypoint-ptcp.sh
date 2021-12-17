#!/bin/bash
set -e

function becho {
  echo -e "\033[1m$1\033[0m"
}

function clean_exit {
  becho "*** Exiting Container... 👋"
  exit $1
}

stty -echoctl
trap 'clean_exit 0' SIGINT

becho "Running the test controller 🎛"
controller ptcp:6633
clean_exit 1
