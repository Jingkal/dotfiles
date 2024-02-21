######################################################################
######## PATHS
######################################################################
my_paths=(              # add paths here in order
    "$HOME/Library/Python/3.9/bin"
    "$HOME/.local/bin"
)
for _mypath in "${my_paths[@]}"; do
    [[ ! "$PATH" =~ "${_mypath}" ]] && export PATH=$PATH:${_mypath}
done
unset my_paths

######################################################################
######## Locale
######################################################################
if [[ ${OSTYPE} == 'darwin'* ]] then
    export LANG=zh_CN.UTF-8
    export LC_ALL=zh_CN.UTF-8
    export LC_COLLATE=zh_CN.UTF-8
    export LC_CTYPE=zh_CN.UTF-8
    export LC_MESSAGES=zh_CN.UTF-8
    export LC_MONETARY=zh_CN.UTF-8
    export LC_NUMERIC=zh_CN.UTF-8
    export LC_TIME=zh_CN.UTF-8
fi

######################################################################
######## Applications
######################################################################
# fzf
export FZF_DEFAULT_OPTS="--ansi --height=25 --reverse"
# MacOS
if [[ ${OSTYPE} == 'darwin'* ]] then
    # CMAKE ENVs
    export CMAKE_PREFIX_PATH="/opt/homebrew/lib"
    export HOMEBREW_INSTALL_FROM_API=1
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Diable .zsh_session caching on macOS
    # This ENV is to allow macOS to restore shell state
    export SHELL_SESSIONS_DISABLE=1
fi
