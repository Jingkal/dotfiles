########################################################################
########## Interactive Config
########################################################################
bindkey -e
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

########################################################################
########## History
########################################################################
export LESSHISTFILE=${HOME}/.cache
HISTFILE=${HOME}/.cache/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

########################################################################
########## Prompt
########################################################################
PROMPT="%F{119}[%f%F{14}%n%f%F{119}@%f%F{14}%m%f%F{119}]%f %F{87}%1~%f %F{13}%#%f "
RPROMPT="%?"

########################################################################
########## Editor
########################################################################
if which nvim >/dev/null 2>&1; then
    export EDITOR=`which nvim`
else
    export EDITOR="vi"
fi
export VISUAL=${EDITOR}
export SUDO_EDITOR=${EDITOR}


########################################################################
########## ALIAS
########################################################################
# RCs
alias zshenv="${EDITOR} ${ZDOTDIR:-$HOME}/.zshenv"
alias zshrc="${EDITOR} ${ZDOTDIR:-$HOME}/.zshrc"
alias zshf="${EDITOR} ${ZDOTDIR:-$HOME}/.zsh_funcs"
alias termrc="${EDITOR} ${HOME}/.config/alacritty/alacritty.toml"
alias vigit="${EDITOR} ${HOME}/.config/git/config"
alias rezsh="source ${ZDOTDIR:-$HOME}/.zshenv; source ${ZDOTDIR:-$HOME}/.zshrc"

# listing
alias l="/bin/ls --color"
alias ls="/bin/ls -r --color"
alias la="/bin/ls -Ar --color"
alias ll="/bin/ls -lArh --color"
alias lt="tree -shL 2"

# Applications
alias vi="${EDITOR}"
alias tma="tmux new -A -s"
alias tml="tmux ls"
alias docker="sudo docker"

### NAVI aliase
alias cdetc="cd /etc"
alias cdtmp="cd /tmp"
alias cdgh="cd ${HOME}/Documents/github"
alias cdssh="cd ${HOME}/.ssh"
alias cdbin="cd ${HOME}/.local/bin"
alias cddoc="cd ${HOME}/Documents"
alias cdpic="cd ${HOME}/Pictures"
alias cdvid="cd ${HOME}/Movies/videos"
alias cddev="cd ${HOME}/Documents/dev"
alias cdconf="cd ${HOME}/.config"
alias cddown="cd ${HOME}/Downloads"
alias cdnotes="cd ${HOME}/Documents/notes"

########################################################################
########## Source files
########################################################################
declare -a srcfiles=(
    "${ZDOTDIR:-$HOME}/.zsh_funcs"
)
for srcfile in ${srcfiles[@]}; do
    [[ -f ${srcfile} ]] && source $srcfile
done

########################################################################
########## Completion
########################################################################
autoload -Uz compinit && compinit -d ${HOME}/.cache/.zcompdump
# compinit -d ${HOME}/.cache/.zcompdump
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.cache/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
