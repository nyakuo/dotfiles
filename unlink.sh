#!/bin/sh
#
# 設定ファイルのシンボリックリンクを削除
########################################

unlink ~/.vimrc
unlink ~/.config/fish/config.fish
unlink ~/.config/fish/functions/fish_prompt.fish
unlink ~/.tmux.conf
unlink ~/.git_alias
unlink ~/.config/vifm/vifmrc
unlink ~/.xinitrc

