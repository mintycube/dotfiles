# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:bindkey' keyboard  'pc'
zstyle ':z4h:' start-tmux 'no'
# if [[ -z $DISPLAY && XDG_VTNR -eq 1 ]]; then
  # zstyle ':z4h:' start-tmux 'no'
# else
  # zstyle ':z4h:' start-tmux command tmux -u new -A -D -t z4h
  # zstyle ':z4h:' start-tmux 'no'
# fi
zstyle ':z4h:' propagate-cwd yes
zstyle ':z4h:' prompt-at-bottom 'no'
zstyle ':z4h:' term-shell-integration 'yes'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'
zstyle ':z4h:direnv' enable 'no'
zstyle ':z4h:direnv:success' notify 'yes'
alias clear=z4h-clear-screen-soft-bottom

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
# zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
# zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
# zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
# z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PATH=$PATH:~/.local/share/npm/bin

# Export environment variables.
export GPG_TTY=$TTY
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"
export MANPAGER="nvim +Man!"
export XDG_SESSION_TYPE="x11"
export FZF_DEFAULT_OPTS="--height=50% --reverse --info=inline \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--height=100% --prompt='  ' --pointer=' ' --ellipsis='' --border=horizontal \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

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

[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc ] && setsid shortcuts >/dev/null 2>&1

sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null

# Source additional local files if they exist.
z4h source ~/.config/shell/{aliasrc,shortcutrc,zshnameddirrc,exportsrc,vi.zsh}

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace
z4h bindkey undo Ctrl+/ Shift+Tab
z4h bindkey redo Alt+/

# z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
# z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
# z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
# z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

# Autoload functions.
autoload -Uz zmv

function font-search () {
  fc-list | cut -d: -f2- | fzf --info=inline --padding=1
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

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
unsetopt PROMPT_SP
setopt glob_dots
setopt autocd always_to_end interactive_comments extended_glob multios
setopt extended_history inc_append_history share_history hist_ignore_dups hist_find_no_dups hist_ignore_space hist_verify hist_save_no_dups
