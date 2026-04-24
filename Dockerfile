FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Install dependencies
RUN apt update && apt install -y \
    curl sudo git wget nano unzip \
    python3 python3-pip nodejs npm \
    && apt clean

# Create user
RUN useradd -m coder && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER coder
WORKDIR /home/coder

# Install code-server (official script)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Keepalive
RUN echo '#!/bin/bash\nwhile true; do sleep 300; done' > keepalive.sh && chmod +x keepalive.sh

EXPOSE 8080

# Start both processes
CMD ["sh", "-c", "./keepalive.sh & code-server --auth none --bind-addr 0.0.0.0:8080"]
