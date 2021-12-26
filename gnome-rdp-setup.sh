#!/bin/sh
# gnome-rdp-setup.sh

rdp_cfg_path="${HOME}/.config/gnome-remote-desktop"
rdp_dconf_path="/org/gnome/desktop/remote-desktop/rdp"

exit_error() {
	echo "$@"
	exit 1
}

# Build helper for setting credentials
echo "Building program for setting RDP credentials"
gcc grd_rdp_credentials.c -o set-rdp-creds $(pkg-config --libs --cflags libsecret-1)
[ $? -ne 0 ] && exit_error "Error while building credentials helper"

# Create config directory and cd to it
echo "Creating config directory (${$rdp_cfg_path})"
mkdir -p $rdp_cfg_path && cd $rdp_cfg_path
[ $? -ne 0 ] && exit_error "Error while creating directory"

# Create certificate for RDP signing
echo "Creating certificate for RDP with openssl"
   openssl genrsa -out tls.key 4096 \
&& openssl req -new -key tls.key -out tls.csr \
&& openssl x509 -req -days 730 -signkey tls.key -in tls.csr -out tls.crt
[ $? -ne 0 ] && exit_error "Error while creating certificate/key"

# Set path to certificate and key
echo "Setting path to certificate in dconf database"
   dconf write ${rdp_dconf_path}/tls-cert "'${rdp_cfg_path}/tls.crt'" \
&& dconf write ${rdp_dconf_path}/tls-key "'${rdp_cfg_path}/tls.key'" \
&& dconf write ${rdp_dconf_path}/view-only false

# Enable mutter support for screen-cast and remote-desktop
gsettings set org.gnome.mutter experimental-features "['screen-cast', 'remote-desktop']"

# TODO
#echo "Enabling virtual monitor"
#./gnome-add-virtual-monitor.sh

echo "=============================================================="
echo "Now set credentials and start RDP server"
echo "=============================================================="
echo
echo "1. Set RDP credentials with:"
echo "       ./set_rdp_creds <username> <password>"
echo "   - <username> will map to the local user running the RDP server"
echo "   - Use a **strong** password."
echo
echo "2. Restart/start the Gnome RDP server with:"
echo "       systemctl --user restart gnome-remote-desktop.service"
