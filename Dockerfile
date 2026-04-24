FROM codercom/code-server:latest

# Disable auth (⚠️ public access!)
ENV PASSWORD=""
ENV SUDO_PASSWORD=""
ENV TZ=Asia/Kolkata

# Install useful tools
RUN sudo apt update && sudo apt install -y \
    git curl wget nano htop unzip zip \
    python3 python3-pip nodejs npm \
    && sudo apt clean

# Install some VS Code extensions
RUN code-server --install-extension ms-python.python && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension dbaeumer.vscode-eslint

# Create workspace
WORKDIR /home/coder/project

# Add keepalive script
RUN echo '#!/bin/bash\nwhile true; do echo "alive"; sleep 240; done' > /home/coder/keepalive.sh \
    && chmod +x /home/coder/keepalive.sh

EXPOSE 8080

# Run keepalive + VS Code together
CMD bash -c "/home/coder/keepalive.sh & code-server --auth none --bind-addr 0.0.0.0:8080"
