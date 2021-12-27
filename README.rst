
WARNING: these scripts were not tested yet!

These scripts allow to create RDP sessions based on virtual monitors.

install-deps.sh
	Install dependencies needed for Gnome Remote Desktop, and by the
	following programs/scripts.

gnome-rdp-setup.sh
	Configure and start the Gnome RDP server for accepting connections
	from the network. It uses virtual monitors by default.

gnome-rdp-set-creds.sh
        Configure username and password for RDP.

gnome-add-virtual-monitor.sh
	Creates a new virtual monitor. Run the command with `-h` option to
	see its documentation.


RecordVirtual method was introduced by Jonas Ådahl with the commit
74ab2120fa1c79eed0d2:

    screen-cast/session: Introduce RecordVirtual D-Bus API

    The new RecordVirtual API creates a virtual monitor, i.e. a region of
    the stage that isn't backed by real monitor hardware. It's intended to
    be used by e.g. network screens on active sessions, virtual remote
    desktop screens when running headless, and scenarios like that.
    
    A major difference between the current Record* API's is that
    RecordVirtual relies on PipeWire itself to negotiate the refresh rate
    and size, as it can't rely on any existing monitor, for those details.
    
    This also means that the virtual monitor is not created until the stream
    negotiation has finished and a virtual monitor resolution has been
    determined.

See <https://gitlab.gnome.org/GNOME/mutter/-/blob/gnome-40/src/org.gnome.Mutter.ScreenCast.xml#L158>.

