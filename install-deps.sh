#!/bin/sh
# install-deps.sh

exit_error() {
	echo "$@"
	exit 1
}

[ "$(id -u)" -ne 0 ] && exit_error "run with sudo"
[ "$(id -r)" -eq 0 ] && echo "WARNING: Real User ID is 0 (root)."

# Install dependencies
echo "Installing dependencies"
   { command -v apt && apt install openssl libsecret-tools gnome-remote-desktop dconf-cli libglib2.0-bin; } \
|| { command -v dnf && dnf install openssl libsecret gnome-remote-desktop dconf glib2;     } \
|| { command -v pacman && pacman -S openssl libsecret gnome-remote-desktop dconf glib2;     }
[ $? -ne 0 ] && exit_error "Error while installing dependencies"
