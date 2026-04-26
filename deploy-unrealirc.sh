#!/bin/bash
set -euo pipefail

rx='^([0-9]+\.){0,3}(\*|[0-9]+)$'
if ! [[ $UNREAL_VERSION =~ $rx ]]; then
 echo "Invalid Unreal version: '$UNREAL_VERSION'"
 exit 1
fi

wget https://www.unrealircd.org/downloads/unrealircd-$UNREAL_VERSION.tar.gz{,.asc}
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xA7A21B0A108FF4A9
gpg --verify unrealircd-$UNREAL_VERSION.tar.gz.asc unrealircd-$UNREAL_VERSION.tar.gz
tar zxvf unrealircd-$UNREAL_VERSION.tar.gz
cd unrealircd-$UNREAL_VERSION
cat > config.settings <<'EOF'
BASEPATH="/home/ircd/unrealircd"
BINDIR="/home/ircd/unrealircd/bin"
DATADIR="/home/ircd/unrealircd/data"
CONFDIR="/home/ircd/unrealircd/conf"
MODULESDIR="/home/ircd/unrealircd/modules"
LOGDIR="/home/ircd/unrealircd/logs"
CACHEDIR="/home/ircd/unrealircd/cache"
DOCDIR="/home/ircd/unrealircd/doc"
TMPDIR="/home/ircd/unrealircd/tmp"
PRIVATELIBDIR="/home/ircd/unrealircd/lib"
MAXCONNECTIONS_REQUEST="auto"
NICKNAMEHISTORYLENGTH="2000"
GEOIP="classic"
DEFPERM="0600"
SSLDIR=""
REMOTEINC=""
CURLDIR=""
NOOPEROVERRIDE=""
OPEROVERRIDEVERIFY=""
GENCERTIFICATE=""
SANITIZER=""
EXTRAPARA=""
ADVANCED=""
EOF
./Config -quick
make
make install
