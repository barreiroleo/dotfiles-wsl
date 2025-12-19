# Uncomment to run profiler. Add `zprof` at the end of the file to see results.
# zmodload zsh/zprof
#
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

# Completion system
# zstyle <pattern> <style> <values>
# :completion:<function>:<completer>:<command>:<argument>:<tag>
# - Automatically update PATH entries (i.e. after install packages)
# - Keep directories and files separated
zstyle ':completion:*' rehash true
zstyle ':completion:*:*:*:*:descriptions' format '%F{cyan}-- %d --%f'

source $ZSH/oh-my-zsh.sh

# Exec programs and as disowned
function run-disown() {
    "$@" & disown
}
function run-disown-silence(){
    run-disown "$@" 1>/dev/null 2>/dev/null
}

# Use vim as diff viewer
# $1 Local; $2 Remote
function diffmerge() {
    nvim -d "$1" "$1".new "$2" \
        -c 'nnoremap dgh :diffget 1<CR>' -c 'nnoremap dgl :diffget 3<CR>' -c 'nnoremap dp :diffput 2<CR>' \
        -c 'nnoremap ZZ :wqall<CR>' -c 'nnoremap ZQ :quitall<CR>' -c 'wincmd w' -c 'read ++edit #'
}

# Ripgrep search and pipe to jq to postprocess the results as csv format. E.g:
# rg_to_csv "foo::(bar|fizz)([ |>,&*{(::)])" > output.csv
function rg-to-csv() {
    rg "$1" --json | jq -s -r '
      .[] |
      select(.type == "match") |
      ( .data.path.text as $fullpath |
        ($fullpath | capture("^(?<dir>.*)/(?<file>[^/]+)$")) as $p |
        [
          $p.dir,
          $p.file,
          (.data.lines.text | gsub("\n"; " ")),
          .data.line_number
        ] |
      @csv)'
}

function launch-termux-i3() {
    am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
    dbus-run-session i3 >/dev/null 2>&1 & disown
}

# Send a notify at the end of a execution
# run command x | alert
alias alert='notify-send --urgency=normal -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Enable "C-x + e" for edit-command-line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Aliases
source $HOME/.config/fzf-custom.sh
source $HOME/.zshaliases
source $HOME/.zshenv
