;; --------------------------------------------------
;; 基本設定

;; common lisp
(require 'cl)

;; 文字コード
;; note: win と mac で環境を分けている
(set-language-environment "Japanese")
(let ((ws window-system))
  (cond ((eq ws 'w64)
         (prefer-coding-system 'utf-8-unix)
         (set-default-coding-systems 'utf-8-unix)
         (setq file-name-coding-system 'sjis)
         (setq locale-coding-system 'utf-8))
        ((eq ws 'ns)
         (require 'ucs-normalize)
         (prefer-coding-system 'utf-8-hfs)
         (setq file-name-coding-system 'utf-8-hfs)
         (setq locale-coding-system 'utf-8-hfs))))

;; フォント設定
;; Win: Meiryo
;; Mac: Ricty
(let ((ws window-system))
  (cond ((eq ws 'w64)
         (set-face-attribute 'default nil
                             :family "Menlo"  ;; 英数
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; 日本語
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Ricty"  ;; 英数
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty")))))  ;; 日本語


;; スタートアップの非表示
(setq inhibit-startup-screen t)

;; scratchの初期メッセージの消去
(setq initial-scratch-message "")

;; タブをスペースに変換
(setq-default indent-tabs-mode nil)

;; タブ幅の指定
(custom-set-variables '(tab-width 4))

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; 暫定マークモード
(transient-mark-mode t)

;; デフォルト作業ディレクトリの変更
;; Note: 作業するマシンによってアドレスを変更すること
(cd "C:/Users/Takahiro/Desktop")

;; デフォルトのフレーム位置・座標
(setq default-frame-alist
      (append '((top . 0)
                (left . 0)
                (height . 65)
                (width . 116)
                ) initial-frame-alist))

;; --------------------------------------------------
;; キーバインド

;; C-h: backspace
(global-set-key "\C-h" 'delete-backward-char)

;; M-g: goto-line
(global-set-key "\M-g" 'goto-line)

;; C-Return: 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; M-y: anything-show-kill-ring
(define-key global-map "\M-y" 'anything-show-kill-ring)

;; C-t: ウィンドウの切り替え (本来はtranspose-chars)
(define-key global-map "\C-t" 'other-window)

;; --------------------------------------------------
;; グラフィック設定

;; 対応カッコをハイライト表示
(show-paren-mode t)
(setq show-paren-style 'expression)
(setq show-paren-delay 0)
(set-face-background 'show-paren-match-face "Pink")
(set-face-foreground 'show-paren-match-face "Blue")

;; 日本語入力のON/OFFでカーソルの色を変える
(add-hook 'mw32-ime-on-hook
	  (function(lambda() (set-cursor-color "Pink"))))
(add-hook 'wm32-ime-off-hook
	  (function(lambda() (set-cursor-color "Green"))))

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号の表示
(global-linum-mode t)
(set-face-attribute 'linum nil
		    :foreground "Green"
		    :background "Black"
		    :height 0.9)

;; 行間
(setq-default line-spacing 0)

;; モードラインに行番号を表示
(line-number-mode t)

;; モードラインに列番号を表示
(column-number-mode t)

;; モードラインの割合表示を総行数表示に変更
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of $$I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format "(%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format "L%%l")))
        ((eq column-number-mode-t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

;; カラーテーマ
;; http://code/google/com/p/gnuemacscolorthemetest/
(when (and (require 'color-theme nil t) (window-system))
  (color-theme-initialize)
  (color-theme-comidia))

;; メニューバーの非表示
(menu-bar-mode -1)

;; ツールバーの非表示
(tool-bar-mode -1)

;; スクロールバーの非表示
(toggle-scroll-bar nil)

;; 現在行をハイライト
(global-hl-line-mode t)
(setq hl-line-face 'underline)

;; 背景の透過
(set-frame-parameter nil 'alpha 90)

;; --------------------------------------------------
;; auto-install
;; Elispインストール支援

(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


;; --------------------------------------------------
;; auto-complete-mode
;; 自動補完機能

(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; --------------------------------------------------
;; point-undo
;; カーソルの移動履歴

(when (require 'point-undo nil t)
  (define-key global-map "\M-[" 'point-undo)
  (define-key global-map "\M-]" 'point-redo)
)

;; --------------------------------------------------
;; undo-tree
;; Undoの分岐履歴
;; Note: C-x u で起動し，履歴ツリーを移動．
;;       適当な場所でqをタイプし終了
;;       tで樹形図と時間表示を切り替えることができる

(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; --------------------------------------------------
;; redo+
;; Redo機能

;; Redo機能のキーバインドの設定
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
)

;; --------------------------------------------------
;; Anything (候補選択型インタフェース)

(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間
   anything-idle-delay 0.3

   ;; タイプして再描画するまでの時間
   anything-input-idle-delay 0.2

   ;; 候補の最大表示数
   anything-candiate-number-limit 100

   ;; 候補が多い時に体感速度を早くする
   anything-quick-update t

   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

(when (require 'anything-config nil t)
  (setq anything-su-or-sudo "sudo"))

(require 'anything-match-plugin nil t)

(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (require 'anything-migemo nil t))

(when (require 'anything-complete nil t)
  ;; lispシンボルの補完候補の再検索時間
  (anything-lisp-complete-symbol-set-timer 150))

(require 'anything-show-completion nil t)

(when (require 'auto-install nil t)
  (require 'anything-auto-install nil t))

(when (require 'descbinds-anything nil t)
  ;; describe-bindingsをAnythingに置き換える
  (descbinds-anything-install)))


;; --------------------------------------------------
;; verilog-mode 
;; VerilogHDL(.vファイル)

;; Load verilog-mode only when needed
(autoload 'verilog-mode "verilog-mode" "verilog mode" t)

;; Any files that end in .v should be in velilog mode
(setq auto-mode-alist (cons '("\\.v\\'" . verilog-mode) auto-mode-alist))

;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook '(lambda () (font-look-mode 1)))

(add-hook 'verilog-mode-hook '(lambda ()
         (add-hook 'local-write-file-hooks
	 (lambda() (untabify (point-min) (point-max))))))

;; --------------------------------------------------
;; C# mode
;; .csファイル

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;; Patterns for finding Microsoft C# compiler error messages:
(require 'compile)
(push '("^\\(.*\\)(\\[0-9]+\\),\\([0-9]+\\)): error" 1 2 3 2) compilation-error-regexp-alist)
(push '("\\(.*\\)(\\[0-9]+\\),\\([0-9]+\\)): warning" 1 2 3 1) compilation-error-regexp-alist)

;; Patterns for defining blocks to hide/show
(push '(csharp-mode
        "\\(^\\s *#\\s *region\\b\\)\\|{"
        "\\(^\\s *#\\s *endregion\\b\\)\\|}"
        "/[*/]"
        nil
        hs-c-like-adjust-block-beginning)
      hs-special-modes-alist)


;; --------------------------------------------------
;; YaTeX (LaTeX)
;; .texファイル

;; エンコーディングをutf-8にする
(setq YaTeX-kanji-code 4)

(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("dviout" . ".dvi")
        ("psv" . ".ps")
        ("TeXworks\\|SumatraPDF\\|evince\\|okular\\|firefox\\|chrome\\|AcroRd32\\|pdfopen" . ".pdf")))
(setq tex-command "ptex2pdf -l -ot \"-kanji=utf8 -guess-input-enc -synctex=1\"")
;(setq tex-command "ptex2pdf -l -u -ot \"-kanji=utf8 -no-guess-input-enc -synctex=1\"")
;(setq tex-command "pdfplatex.bat")
;(setq tex-command "pdfplatex2.bat")
;(setq tex-command "pdfuplatex.bat")
;(setq tex-command "pdfuplatex2.bat")
;(setq tex-command "pdflatex -synctex=1")
;(setq tex-command "lualatex -synctex=1")
;(setq tex-command "luajitlatex -synctex=1")
;(setq tex-command "xelatex -synctex=1")
;(setq tex-command "latexmk")
;(setq tex-command "latexmk -e \"$latex=q/platex -kanji=utf8 -guess-input-enc -synctex=1/\" -e \"$bibtex=q/pbibtex -kanji=utf8/\" -e \"$makeindex=q/mendex -U/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e \"$latex=q/platex -kanji=utf8 -guess-input-enc -synctex=1/\" -e \"$bibtex=q/pbibtex -kanji=utf8/\" -e \"$makeindex=q/mendex -U/\" -e \"$dvips=q/dvips %O -z -f %S | convbkmk -g > %D/\" -e \"$ps2pdf=q/ps2pdf.bat %O %S %D/\" -norc -gg -pdfps")
;(setq tex-command "latexmk -e \"$latex=q/uplatex -kanji=utf8 -no-guess-input-enc -synctex=1/\" -e \"$bibtex=q/upbibtex/\" -e \"$makeindex=q/mendex -U/\" -e \"$dvipdf=q/dvipdfmx %O -o %D %S/\" -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e \"$latex=q/uplatex -kanji=utf8 -no-guess-input-enc -synctex=1/\" -e \"$bibtex=q/upbibtex/\" -e \"$makeindex=q/mendex -U/\" -e \"$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/\" -e \"$ps2pdf=q/ps2pdf.bat %O %S %D/\" -norc -gg -pdfps")
;(setq tex-command "latexmk -e \"$pdflatex=q/pdflatex -synctex=1/\" -e \"$bibtex=q/bibtex/\" -e \"$makeindex=q/makeindex/\" -norc -gg -pdf")
;(setq tex-command "latexmk -e \"$pdflatex=q/lualatex -synctex=1/\" -e \"$bibtex=q/bibtexu/\" -e \"$makeindex=q/texindy/\" -norc -gg -pdf")
;(setq tex-command "latexmk -e \"$pdflatex=q/luajitlatex -synctex=1/\" -e \"$bibtex=q/bibtexu/\" -e \"$makeindex=q/texindy/\" -norc -gg -pdf")
;(setq tex-command "latexmk -e \"$pdflatex=q/xelatex -synctex=1/\" -e \"$bibtex=q/bibtexu/\" -e \"$makeindex=q/texindy/\" -norc -gg -xelatex")
(setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex -kanji=utf8")
                           ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "bibtexu")
                           ((string-match "pdflatex\\|latex" tex-command) "bibtex")
                           (t "pbibtex -kanji=utf8")))
(setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "mendex -U")
                              ((string-match "platex" tex-command) "mendex -U")
                              ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "texindy")
                              ((string-match "pdflatex\\|latex" tex-command) "makeindex")
                              (t "mendex -U")))
(setq dvi2-command "texworks")
;(setq dvi2-command "start SumatraPDF -rese-instance")
;(setq dvi2-command "powershell -Command \"& {$p = [System.String]::Concat('\"\"\"',[System.IO.Path]::GetFileName($args),'\"\"\"');Start-Process firefox -ArgumentList ('-new-window',$p)}\"")
;(setq dvi2-command "powershell -Command \"& {$p = [System.String]::Concat('\"\"\"',[System.IO.Path]::GetFullPath($args),'\"\"\"');Start-Process chrome -ArgumentList ('--new-window',$p)}\"")
(setq dviprint-command-format "powershell -Command \"& {$r = Write-Output %s;$p = [System.String]::Concat('\"\"\"',[System.IO.Path]::GetFileNameWithoutExtension($r),'.pdf','\"\"\"');Start-Process pdfopen -ArgumentList ('--rxi','--file',$p)}\"")

(defun sumatrapdf-forward-search ()
  (interactive)
  (let* ((ctf (buffer-name))         (mtf)
         (pf)
         (ln (format "%d" (line-number-at-pos)))
         (cmd "start SumatraPDF")
         (args))
    (if (YaTeX-main-file-p)
        (setq mtf (buffer-name))
      (progn
        (if (equal YaTeX-parent-file nil)
            (save-excursion
              (YaTeX-visit-main t)))
        (setq mtf YaTeX-parent-file)))
    (setq pf (concat (car (split-string mtf "\\.")) ".pdf"))
    (setq args (concat "-reuse-instance \"" pf "\" -forward-search \"" ctf "\" " ln))
    (message (concat cmd " " args))
    (process-kill-without-query
     (start-process-shell-command "sumatrapdf" nil cmd args))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c s") 'sumatrapdf-forward-search)))

(defun fwdsumatrapdf-forward-search ()
  (interactive)
  (let* ((ctf (buffer-name))
         (mtf)
         (pf)
         (ln (format "%d" (line-number-at-pos)))
         (cmd "fwdsumatrapdf")
         (args))
    (if (YaTeX-main-file-p)
        (setq mtf (buffer-name))
      (progn
        (if (equal YaTeX-parent-file nil)
            (save-excursion
              (YaTeX-visit-main t)))
        (setq mtf YaTeX-parent-file)))
    (setq pf (concat (car (split-string mtf "\\.")) ".pdf"))
    (setq args (concat "\"" pf "\" \"" ctf "\" " ln))
    (message (concat cmd " " args))
    (process-kill-without-query
     (start-process-shell-command "fwdsumatrapdf" nil cmd args))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c w") 'fwdsumatrapdf-forward-search)))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))

;; --------------------------------------------------
;; RefTeX with YaTeX
;;

;(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
