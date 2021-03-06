#!/bin/sh
#
# 設定ファイルをシンボリックリンクで配置
#########################################

DIR=$(pwd)

ln -s ${DIR}/neovim/vimrc ~/.config/nvim/init.vim
ln -s ${DIR}/fish/config.fish ~/.config/fish/config.fish
ln -s ${DIR}/fish/extra_settings ~/.config/fish/extra_settings
ln -s ${DIR}/fish/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
ln -s ${DIR}/tmux/tmux.conf ~/.tmux.conf
ln -s ${DIR}/git/git_alias ~/.git_alias
ln -s ${DIR}/vifm/vifmrc ~/.config/vifm/vifmrc
ln -s ${DIR}/xinitrc ~/.xinitrc
ln -s ${DIR}/fonts.conf ~/.config/fontconfig/fonts.conf
ln -s ${DIR}/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ${DIR}/xremap/config ~/.config/xremap/config
ln -s ${DIR}/emacs/init.el ~/.emacs.d/init.el
