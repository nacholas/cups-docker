#!/usr/bin/env bash
# This script install the Samsung unified linux drivers
#
# Supported variables
# `SULDR_DRIVER_VERSION` (Default: 4.00.39) - Version of suldr-driver to install
# `SULDR_DRIVER2_VERSION` (Default: 1.00.39) - Version of suldr-driver2 to install

source ${PREFIX}/functions

SULDR_DRIVER_VERSION="${FOOMATIC_FILTERS_VERSION:-1.00.39}"
SULDR_DRIVER2_VERSION="${FOOMATIC_FILTERS_VERSION:-1.00.39}"

if (isInst suld-driver2-${SULDR_DRIVER2_VERSION} || isInst suld-driver-${SULDR_DRIVER_VERSION}); then
    echo "suldr is already installed"
    exit
fi

PKGS="\
    suld-driver-${SULDR_DRIVER1_VERSION}\
	suld-driver2-${SULDR_DRIVER2_VERSION}"

echo "deb https://www.bchemnet.com/suldr/ debian extra" > /etc/apt/sources.list.d/suldr.list
curl -L -o suldr-keyring.deb http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_2_all.deb
dpkg -i suldr-keyring.deb

apt-get update
apt-get -qy install ${PKGS}

rm suldr-keyring.deb
rm -rf /var/lib/apt/lists/*