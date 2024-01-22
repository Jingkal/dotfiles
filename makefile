# ------------------------------------------------------
# ------ Neovim Configs
# ------------------------------------------------------
pull.vim:
	rsync -av -c ${HOME}/.config/nvim .

install.vim:
	rsync -av -c --delete ./nvim ${HOME}/.config

# ------------------------------------------------------
# ------ Zsh Configs
# ------------------------------------------------------
pull.zsh:
	rsync -av -c ${HOME}/.zshrc ./shell/.zshrc
	rsync -av -c ${HOME}/.zshenv ./shell/.zshenv
	rsync -av -c ${HOME}/.zsh_funcs ./shell/.zsh_funcs

install.zsh:
	rsync -av -c ./shell/.zshrc ${HOME}/.zshrc
	rsync -av -c ./shell/.zshenv ${HOME}/.zshenv
	rsync -av -c ./shell/.zsh_funcs ${HOME}/.zsh_funcs

# ------------------------------------------------------
# ------ Tmux Config
# ------------------------------------------------------
pull.tmux:
	rsync -av -c ${HOME}/.config/tmux .

install.tmux:
	rsync -av -c --delete ./nvim ${HOME}/.config

