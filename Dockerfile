FROM codercom/code-server:latest

# Disable auth
ENV PASSWORD=""
ENV TZ=Asia/Kolkata

# Install tools
RUN sudo apt update && sudo apt install -y \
    git curl wget nano htop unzip \
    python3 python3-pip nodejs npm \
    && sudo apt clean

# Extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension esbenp.prettier-vscode

# Keepalive script
RUN echo '#!/bin/bash\nwhile true; do sleep 240; done' > /home/coder/keepalive.sh \
 && chmod +x /home/coder/keepalive.sh

EXPOSE 8080

# ✅ IMPORTANT: use exec form (no bash -c)
CMD ["/bin/sh", "-c", "/home/coder/keepalive.sh & exec code-server --auth none --bind-addr 0.0.0.0:8080"]
