# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '28'
zstyle ':z4h:bindkey' keyboard  'pc'
zstyle ':z4h:' start-tmux       no
zstyle ':z4h:' term-shell-integration 'yes'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs yes
zstyle ':z4h:direnv' enable 'no'
zstyle ':z4h:direnv:success' notify 'yes'

z4h init || return

export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PATH=$PATH:~/.local/share/npm/bin
export GPG_TTY=$TTY
# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export MANPAGER="nvim +Man!"
export XDG_SESSION_TYPE="x11"
# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export BUNDLE_PATH="$HOME/.cache/bundle"

#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export HISTFILE="$XDG_DATA_HOME/history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2" # Have QT use gtk2 theme.
export QT_SCALE_FACTOR=1.1
export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D" # May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm
export FZF_DEFAULT_OPTS="--layout=reverse --height=70% --inline-info"

[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc ] && setsid shortcuts >/dev/null 2>&1

sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null

z4h source ~/.config/shell/{aliasrc,shortcutrc,zshnameddirrc,exportsrc,vi.zsh}

z4h bindkey z4h-backward-kill-word  Ctrl+Backspace
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace
z4h bindkey undo Ctrl+/ Shift+Tab
z4h bindkey redo Alt+/

z4h bindkey z4h-cd-back    Alt+Left
z4h bindkey z4h-cd-forward Alt+Right
z4h bindkey z4h-cd-up      Alt+Up
z4h bindkey z4h-cd-down    Alt+Down
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

# Autoload functions.
autoload -Uz zmv

function font-search () {
  fc-list | cut -d: -f2- | fzf --layout=reverse --info=inline --padding=1
}
# Use lf to switch directories and bind it to ctrl-o
function lfcd () {
  tmp="$(mktemp -uq)"
  trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

unsetopt PROMPT_SP
setopt glob_dots
setopt autocd always_to_end interactive_comments extended_glob multios
setopt extended_history append_history hist_ignore_dups hist_find_no_dups hist_ignore_space hist_verify hist_save_no_dups
