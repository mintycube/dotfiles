# ~/.bashrc
bind "set completion-ignore-case on"     # Perform file completion in a case insensitive fashion
bind "set completion-map-case on"        # Treat hyphens and underscores as equivalent
bind "set show-all-if-ambiguous on"      # Display matches for ambiguous patterns at first tab press
bind "set mark-symlinked-directories on" # Immediately add a trailing slash when autocompleting symlinks to directories

HISTSIZE=500000
HISTFILESIZE=100000
shopt -s histappend                                       # Append to the history file, don't overwrite it
shopt -s cmdhist                                          # Save multi-line commands as one command
PROMPT_COMMAND='history -a'                               # Record each line as it gets issued
HISTCONTROL="erasedups:ignoreboth"                        # Avoid duplicate entries
export HISTIGNORE="&:[ ]*:exit:ls:lf:bg:fg:history:clear" # Don't record some commands
HISTTIMEFORMAT='%F %T '                                   # Use standard ISO 8601 timestamp

export MANPAGER="nvim +Man!"

bind Space:magic-space                 # Typing !!<space> will replace the !! with your last command
bind '"\e[A": history-search-backward' # Enable incremental history search with up/down arrows (also Readline goodness)
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

shopt -s autocd 2>/dev/null   # Prepend cd to directory names automatically
shopt -s dirspell 2>/dev/null # Correct spelling errors during tab-completion
shopt -s cdspell 2>/dev/null  # Correct spelling errors in arguments supplied to cd
shopt -s expand_aliases       # expand aliases
shopt -s checkwinsize         # checks term size when bash regains control

[ -f "$HOME/.config/shell/shortcutrc" ] && source "$HOME/.config/shell/shortcutrc" # shortcuts
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"       # aliases

PS1='\[\e[34;3m\]\w \[\e[0;32m\] \[\e[0m\]' # prompt with dir in italic

source "$HOME/.local/src/fzf-tab-completion/bash/fzf-bash-completion.sh" # https://github.com/lincheney/fzf-tab-completion.git
bind -x '"\t": fzf_bash_completion'
