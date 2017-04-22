#!/bin/bash

uname -a

PROXY=`docker inspect --format '{{ .State.Status }}' apt-cacher-ng`

if [ X$PROXY != Xrunning ] ; then
   ./run_proxy.sh
fi

git clone https://github.com/hernad/docker-machine.git

cd docker-machine

git checkout greenbox -f
git pull
git log -1

script/build_windows.sh 
if [ $? != 0 ] ; then
   echo "docker-machine windows build ERROR!"
   exit 1
fi

mv bin/*.exe ..

