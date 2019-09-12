#!/bin/sh
#
# 設定ファイルをシンボリックリンクで配置
#########################################

DIR=$(pwd)

ln -s ${DIR}/vim/vimrc ~/.vimrc
ln -s ${DIR}/fish/config.fish ~/.config/fish/config.fish
ln -s ${DIR}/tmux/tmux.conf ~/.tmux.conf
ln -s ${DIR}/git/git_alias ~/.git_alias
