#!/bin/sh
#
# 設定ファイルをシンボリックリンクで配置
# tmux のプライグインマネージャ(TPM)を ~/.tmux/plugins/tpm にインストールする
#########################################

DIR=$(pwd)

ln -s ${DIR}/neovim/vimrc ~/.config/nvim/init.vim
ln -s ${DIR}/neovim/vimrc ~/.vimrc
ln -s ${DIR}/tmux/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ${DIR}/git/git_alias ~/.git_alias
ln -s ${DIR}/vifm/vifmrc ~/.config/vifm/vifmrc
ln -s ${DIR}/xinitrc ~/.xinitrc
ln -s ${DIR}/fonts.conf ~/.config/fontconfig/fonts.conf
ln -s ${DIR}/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ${DIR}/xremap/config ~/.config/xremap/config
ln -s ${DIR}/emacs/init.el ~/.emacs.d/init.el
ln -s ${DIR}/zsh/zshrc ~/.zshrc
