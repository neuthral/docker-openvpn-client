#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cleanup() {
    kill TERM "$openvpn_pid"
    exit 0
}

# openvpn_args+=("--route-up" "/usr/local/bin/killswitch.sh $ALLOWED_SUBNETS")
# openvpn_args+=("--auth-user-pass" "/run/secrets/$AUTH_SECRET")

# added by neuthral
# download a bunch of openvpn config files from ipspeed.info
# wget --no-directories --directory-prefix=./config/ --continue -r -A .ovpn https://ipspeed.info/freevpn_openvpn.php
#
# get new vpn ip
# docker run --rm -it --network=container:openvpn-client alpine wget -qO - ifconfig.me
#
# select a ovpn file by random
config_file=$(find config -name '*.ovpn' 2> /dev/null | grep tcp | sort | shuf -n 1)

if [[ -z $config_file ]]; then
    echo "no openvpn configuration file found" >&2
    exit 1
fi

#for conf in /etc/openvpn/*.conf
#do
#  openvpn --config $conf --daemon
#done

echo "using openvpn configuration file: $config_file"

openvpn_args=(
    "--config" "$config_file"
    "--cd" "/config"
)

openvpn "${openvpn_args[@]}" &
openvpn_pid=$!

trap cleanup TERM

wait $openvpn_pid

#wget -qO - ifconfig.me > ipaddress
