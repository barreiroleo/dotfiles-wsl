#!/data/data/com.termux/files/usr/bin/bash

USER="leonardo"

proot-distro login --shared-tmp --no-arch-warning --user ${USER} archlinux -- \
	/bin/bash -c 'export XDG_RUNTIME_DIR=${TMPDIR} && env DISPLAY=:0 zsh'
