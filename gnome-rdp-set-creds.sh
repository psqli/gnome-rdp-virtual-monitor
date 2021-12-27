#!/bin/sh
# gnome-rdp-set-creds.sh

echo -n "Username: "
read username
echo -n "Password: "
read -s password

echo -n "{'username': <'${username}'>, 'password': <'${password}'>}" | \
secret-tool store -l 'GNOME Remote Desktop RDP credentials' xdg:schema org.gnome.RemoteDesktop.RdpCredentials
