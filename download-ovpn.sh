#!/usr/bin/env bash

if [[ ! -d config ]]; then
    mkdir -p config
fi

# download a bunch of openvpn config files from ipspeed.info

wget --no-directories --directory-prefix=./config/ --continue -r -A .ovpn https://ipspeed.info/freevpn_openvpn.php
