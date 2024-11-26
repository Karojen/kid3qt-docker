FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    tigervnc-standalone-server \
    xfce4 \
    xfwm4 \
    xfce4-terminal \
    kid3-qt \
    novnc \
    websockify \
    wget && \
    apt-get clean

# Create VNC password directory
RUN mkdir -p ~/.vnc

# Add start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port for noVNC
EXPOSE 6080

CMD ["/start.sh"]
