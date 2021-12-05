#!/bin/bash
set -e

service openvswitch-switch start > /dev/null 2>&1
ovs-vsctl set-manager ptcp:6640 > /dev/null 2>&1

function becho {
  echo -e "\033[1m$1\033[0m"
}

function clean_exit {
  service openvswitch-switch stop > /dev/null 2>&1
  becho "*** Exiting Container... 👋"
  exit $1
}

function file_exists {
  if [ ! -f "$1" ]; then
    becho "*** Error: given topology script does not exist in containers filesystem 🆘"
    clean_exit 1
  fi
}

# Perform a clean
becho "*** Running MN clean..."
mn -c > /dev/null 2>&1
becho "*** MN clean complete ✅"

# Run topology script (via mininet python api)
file_exists $1
becho "*** Running mininet via the Python API..."
echo "*** Ignoring any command line flags"
python3 $1 && clean_exit 0
