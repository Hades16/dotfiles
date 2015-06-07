#!/bin/bash
# This script works only if you have root privileges!

if [ $USER == "root" ]; then
  if [ -e /etc/nsmb.conf ]; then
    rm /etc/nsmb.conf
    echo "SMB enabled!"
  else
    echo "SMB was already disabled. Nothing to do!"
  fi
else
  echo "Hello $USER. You have to sudo this script."
  echo "Nothing done!"
fi
