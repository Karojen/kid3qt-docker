#!/bin/bash

# Set password to none if VNC_PASSWORD is not provided
if [ -z "$VNC_PASSWORD" ]; then
    echo "No password set. VNC will not require a password."
    rm -f ~/.vnc/passwd  # Remove password file if it exists
else
    # Configure VNC server password
    echo "$VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd
    chmod 600 ~/.vnc/passwd
fi

# Start VNC server with resizing support
export DISPLAY=:1
vncserver $DISPLAY -geometry 1920x1080 -depth 24 -rfbwait 120000 -Resize=Dynamic

# Start Kid3-qt in fullscreen mode
xfwm4 &  # Start a lightweight window manager
kid3-qt --fullscreen &

# Start noVNC
websockify --web=/usr/share/novnc/ --wrap-mode=ignore 6080 localhost:5901 &

# Keep container running
tail -f /dev/null
