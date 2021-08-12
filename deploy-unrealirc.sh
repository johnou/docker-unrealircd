#!/bin/bash

rx='^([0-9]+\.){0,3}(\*|[0-9]+)$'
if ! [[ $UNREAL_VERSION =~ $rx ]]; then
 echo "Invalid Unreal version: '$UNREAL_VERSION'"
 exit 1
fi

wget https://www.unrealircd.org/downloads/unrealircd-$UNREAL_VERSION.tar.gz{,.asc}
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xA7A21B0A108FF4A9
gpg --verify unrealircd-$UNREAL_VERSION.tar.gz.asc unrealircd-$UNREAL_VERSION.tar.gz || exit 1
tar zxvf unrealircd-$UNREAL_VERSION.tar.gz
cd unrealircd-$UNREAL_VERSION
./Config
make
make install
