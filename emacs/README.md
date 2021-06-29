# Emacsの設定

## clone直後にすること
1. dotfiles/elisp/local_setting.el を作成する
   もしくは dotfiles/elisp/init.el から (load "local_setting.el")をコメントアウトする
   ※ local_setting.elは環境依存の設定ファイル(ウィンドウの初期配置やサイズ，起動直後の作業ディレクトリなど)
2. `dotfiles/init.sh` を実行して `~/.emacs.d/init.el` のシンボリックリンクを作成する

