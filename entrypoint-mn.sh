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


# Perform a clean
becho "*** Running MN clean..."
mn -c > /dev/null 2>&1
becho "*** MN clean complete ✅"

# Run topology (via mn)
becho "*** Running mininet using mn - flags: '$@'"
mn $@ && clean_exit 0
