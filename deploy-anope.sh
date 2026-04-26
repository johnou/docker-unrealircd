#!/bin/bash
set -euo pipefail

rx='^([0-9]+\.){0,3}(\*|[0-9]+)$'
if ! [[ $ANOPE_VERSION =~ $rx ]]; then
 echo "Invalid Anope version: '$ANOPE_VERSION'"
 exit 1
fi

wget -O anope-$ANOPE_VERSION-source.tar.gz https://github.com/anope/anope/archive/refs/tags/$ANOPE_VERSION.tar.gz
echo "$ANOPE_CHECKSUM anope-$ANOPE_VERSION-source.tar.gz" > anope-$ANOPE_VERSION-source.tar.gz.sha256
sha256sum --quiet -c anope-$ANOPE_VERSION-source.tar.gz.sha256 || exit 1
tar zxvf anope-$ANOPE_VERSION-source.tar.gz
cd anope-$ANOPE_VERSION
ln -sf extra/m_ssl_openssl.cpp modules/m_ssl_openssl.cpp
cat > config.cache <<'EOF'
INSTDIR="/home/ircd/unrealircd/services"
RUNGROUP="ircd"
UMASK=007
DEBUG="no"
USE_PCH="no"
EXTRA_INCLUDE_DIRS=""
EXTRA_LIB_DIRS=""
EXTRA_CONFIG_ARGS=""
EOF
./Config -quick
cd build
make
make install
