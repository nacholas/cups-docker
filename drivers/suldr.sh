#!/usr/bin/env bash
# This script install the Samsung unified linux drivers
#
# Supported variables
# `SULDR_DRIVER2_VERSION` (Default: 1.00.39) - Version of suldr-driver2 to install

source ${PREFIX}/functions

SULDR_DRIVER2_VERSION="${SULDR_DRIVER2_VERSION:-1.00.39}"

if (isInst suld-driver2-${SULDR_DRIVER2_VERSION}); then
    echo "suldr is already installed"
    exit
fi

PKGS="\
    suld-driver2-${SULDR_DRIVER2_VERSION}\
	suld-ppd-4\
	suld-driver2-common-1"

DEPS="\
    curl\
	dirmngr\
    gnupg\
    gnupg-l10n\
    gnupg-utils\
    gpg\
    gpg-agent\
    gpg-wks-client\
    gpg-wks-server\
    gpgconf\
    gpgsm\
    libassuan0\
    libksba8\
    libnpth0\
    libreadline7\
    lsb-base\
    pinentry-curses\
    readline-common"

apt-get update
apt-get -qy install ${DEPS}

echo "deb https://www.bchemnet.com/suldr/ debian extra" > /etc/apt/sources.list.d/suldr.list
curl -L -o suldr-keyring.deb http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb
dpkg -i suldr-keyring.deb

apt-get update
apt-get -qy install ${PKGS}

rm suldr-keyring.deb
rm -rf /var/lib/apt/lists/*