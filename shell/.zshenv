# Browser for wsl
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    export BROWSER=wslview
fi

# Java
if [ $(which javac) ]; then
    export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
export PATH=$PATH:/usr/local/go/bin

# Cmake when manually install
# export PATH=$PATH:/opt/cmake/cmake-3.30.3-linux-x86_64/bin/

# Rust
. "$HOME/.cargo/env"
