#!/bin/bash

if [ -f /etc/debian_version ]
then
  LINUX_DISTRO="debian"
else
  if [ -f /etc/redhat-release ]
  then
     LINUX_DISTRO="redhat"
  else
     if [ -f /etc/SuSE-release ]
     then
        LINUX_DISTRO="suse"
     else
        LINUX_DISTRO="other"
     fi
   fi
fi

