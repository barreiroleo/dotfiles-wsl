# Tmux autostart/exit. Preserve at very top.
# If tmux is executable && Graphical session is running && We aren't already inside a tmux session
# Start a new session and close terminal at exit. tmux -u force UTF-8
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     tmux -u >/dev/null 2>&1 && exit
# fi

# Include binaries locations to PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ZSH / Oh-my-zsh configs
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git sudo vi-mode timer fzf)
source $ZSH/oh-my-zsh.sh

# Completion system
# zstyle <pattern> <style> <values>
# :completion:<function>:<completer>:<command>:<argument>:<tag>
# - Automatically update PATH entries (i.e. after install packages)
# - Keep directories and files separated
zstyle ':completion:*' rehash true
zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %d --%f'

# Exec programs and as disowned
# run_disown the_thing
function run_disown() {
    "$@" & disown
}
function run_disown_silence(){
    run_disown "$@" 1>/dev/null 2>/dev/null
}

# Use vim as diff viewer
# $1 Local; $2 Remote
function diffmerge() {
    nvim -d "$1" "$1".new "$2" \
        -c 'nnoremap dgh :diffget 1<CR>' -c 'nnoremap dgl :diffget 3<CR>' -c 'nnoremap dp :diffput 2<CR>' \
        -c 'nnoremap ZZ :wqall<CR>' -c 'nnoremap ZQ :quitall<CR>' -c 'wincmd w' -c 'read ++edit #'
}

# Send a notify at the end of a execution
# run command x | alert
alias alert='notify-send --urgency=normal -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Enable "C-x + e" for edit-command-line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Aliases
source $HOME/.zshaliases
