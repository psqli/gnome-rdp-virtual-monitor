#!/bin/sh
#
# Set up virtual monitor on the fly
#     gdbus is used dbus-send does not support arrays of variants
#     (see <https://dbus.freedesktop.org/doc/dbus-send.1.html>)
#
# based on gnome-screen-cast.py <https://gitlab.gnome.org/-/snippets/15>

# CreateSession() on ScreenCast API
# This returns a path like /org/gnome/Mutter/ScreenCast/Session/u0
create_session() {
  gdbus call \
    --session \
    --dest org.gnome.Mutter.ScreenCast \
    --object-path /org/gnome/Mutter/ScreenCast \
    --method org.gnome.Mutter.ScreenCast.CreateSession \
    "{}"
}

# usage: record_virtual <session_obj_path>
record_virtual() {
  gdbus call \
    --session \
    --dest org.gnome.Mutter.ScreenCast \
    --object-path ${1} \
    --method org.gnome.Mutter.ScreenCast.Session.RecordVirtual \
    "{}"
}


instrospect_record_virtual() {
  gdbus introspect -r \
    --session \
    --dest org.gnome.Mutter.ScreenCast \
    --object-path /org/gnome/Mutter/ScreenCast
}


res=$(create_session | cut -d "'" -f 2)
echo "D-Bus ScreenCast session obj = ${res}"

instrospect_record_virtual $res
