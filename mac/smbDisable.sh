#!/bin/bash
# This script works only if you have root priviliges!

if [ $USER == "root" ]; then
  if [ -e /etc/nsmb.conf ]; then
    echo "SMB was already disabled. Nothing to do!"
  else
    echo "[default]" >> /etc/nsmb.conf
    echo "streams=no" >> /etc/nsmb.conf
    echo "SMB disabled!"
  fi
else
  echo "Hello $USER. You have to sudo this script."
  echo "Nothing done!"
fi
