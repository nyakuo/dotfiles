dotfiles
========

Emacsの設定

NOTE (1) clone直後にすること
     cloneした場合は dotfiles/elisp/local_setting.el を作成する．
     (もしくは dotfiles/elisp/init.el から (load "local_setting.el")をコメントアウトする)
     local_setting.elは，環境依存の設定ファイルとなる．

     例) ウィンドウの初期配置やサイズ，起動直後の作業ディレクトリなど

NOTE (2) .emacsの設定例
  (defconst my-elisp-directory "~/.emacs.d/dotfiles/")
   
  (dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
                 (list dir (format "%s%d" dir emacs-major-version))))
    (when (and (stringp dir) (file-directory-p dir))
      (let ((default-directory dir))
        (add-to-list 'load-path default-directory)
        (normal-top-level-add-subdirs-to-load-path))))
   
  (load "init")
  (load "coding_settings")

* coding_settingsを最後に読み込んでいるのは，他のelispによってエンコード設定が変更される可能性があるため
