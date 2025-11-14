export EDITOR="nvim"

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

# fnm
FNM_PATH="${HOME}/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Go
export PATH=$PATH:/usr/local/go/bin

# Cmake when manually install
# export PATH=$PATH:/opt/cmake/cmake-3.30.3-linux-x86_64/bin/

# Rust
. "$HOME/.cargo/env"
