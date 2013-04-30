;; --------------------------------------------------
;; ��{�ݒ�

;; common lisp
(require 'cl)

;; �����R�[�h
;; note: win �� mac �Ŋ��𕪂��Ă���
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

;; �t�H���g�ݒ�
;; Win: Meiryo
;; Mac: Ricty
(let ((ws window-system))
  (cond ((eq ws 'w64)
         (set-face-attribute 'default nil
                             :family "Menlo"  ;; �p��
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; ���{��
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Ricty"  ;; �p��
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty")))))  ;; ���{��


;; �X�^�[�g�A�b�v�̔�\��
(setq inhibit-startup-screen t)

;; scratch�̏������b�Z�[�W�̏���
(setq initial-scratch-message "")

;; �^�u���X�y�[�X�ɕϊ�
(setq-default indent-tabs-mode nil)

;; �^�u���̎w��
(custom-set-variables '(tab-width 4))

;; �o�b�N�A�b�v�t�@�C�������Ȃ�
(setq make-backup-files nil)

;; �b��}�[�N���[�h
(transient-mark-mode t)

;; �f�t�H���g��ƃf�B���N�g���̕ύX
;; Note: ��Ƃ���}�V���ɂ���ăA�h���X��ύX���邱��
(cd "C:/Users/Takahiro/Desktop")

;; �f�t�H���g�̃t���[���ʒu�E���W
(setq default-frame-alist
      (append '((top . 0)
                (left . 0)
                (height . 65)
                (width . 116)
                ) initial-frame-alist))

;; --------------------------------------------------
;; �L�[�o�C���h

;; C-h: backspace
(global-set-key "\C-h" 'delete-backward-char)

;; M-g: goto-line
(global-set-key "\M-g" 'goto-line)

;; C-Return: ��`�I��
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; M-y: anything-show-kill-ring
(define-key global-map "\M-y" 'anything-show-kill-ring)

;; C-t: �E�B���h�E�̐؂�ւ� (�{����transpose-chars)
(define-key global-map "\C-t" 'other-window)

;; --------------------------------------------------
;; �O���t�B�b�N�ݒ�

;; �Ή��J�b�R���n�C���C�g�\��
(show-paren-mode t)
(setq show-paren-style 'expression)
(setq show-paren-delay 0)
(set-face-background 'show-paren-match-face "Pink")
(set-face-foreground 'show-paren-match-face "Blue")

;; ���{����͂�ON/OFF�ŃJ�[�\���̐F��ς���
(add-hook 'mw32-ime-on-hook
	  (function(lambda() (set-cursor-color "Pink"))))
(add-hook 'wm32-ime-off-hook
	  (function(lambda() (set-cursor-color "Green"))))

;; �^�C�g���o�[�Ƀt�@�C���̃t���p�X��\��
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; �s�ԍ��̕\��
(global-linum-mode t)
(set-face-attribute 'linum nil
		    :foreground "Green"
		    :background "Black"
		    :height 0.9)

;; �s��
(setq-default line-spacing 0)

;; ���[�h���C���ɍs�ԍ���\��
(line-number-mode t)

;; ���[�h���C���ɗ�ԍ���\��
(column-number-mode t)

;; ���[�h���C���̊����\���𑍍s���\���ɕύX
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

;; �J���[�e�[�}
;; http://code/google/com/p/gnuemacscolorthemetest/
(when (and (require 'color-theme nil t) (window-system))
  (color-theme-initialize)
  (color-theme-comidia))

;; ���j���[�o�[�̔�\��
(menu-bar-mode -1)

;; �c�[���o�[�̔�\��
(tool-bar-mode -1)

;; �X�N���[���o�[�̔�\��
(toggle-scroll-bar nil)

;; ���ݍs���n�C���C�g
(global-hl-line-mode t)
(setq hl-line-face 'underline)

;; �w�i�̓���
(set-frame-parameter nil 'alpha 90)

;; --------------------------------------------------
;; auto-install
;; Elisp�C���X�g�[���x��

(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


;; --------------------------------------------------
;; auto-complete-mode
;; �����⊮�@�\

(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; --------------------------------------------------
;; point-undo
;; �J�[�\���̈ړ�����

(when (require 'point-undo nil t)
  (define-key global-map "\M-[" 'point-undo)
  (define-key global-map "\M-]" 'point-redo)
)

;; --------------------------------------------------
;; undo-tree
;; Undo�̕��򗚗�
;; Note: C-x u �ŋN�����C�����c���[���ړ��D
;;       �K���ȏꏊ��q���^�C�v���I��
;;       t�Ŏ��`�}�Ǝ��ԕ\����؂�ւ��邱�Ƃ��ł���

(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; --------------------------------------------------
;; redo+
;; Redo�@�\

;; Redo�@�\�̃L�[�o�C���h�̐ݒ�
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo)
)

;; --------------------------------------------------
;; Anything (���I���^�C���^�t�F�[�X)

(when (require 'anything nil t)
  (setq
   ;; ����\������܂ł̎���
   anything-idle-delay 0.3

   ;; �^�C�v���čĕ`�悷��܂ł̎���
   anything-input-idle-delay 0.2

   ;; ���̍ő�\����
   anything-candiate-number-limit 100

   ;; ��₪�������ɑ̊����x�𑁂�����
   anything-quick-update t

   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

(when (require 'anything-config nil t)
  (setq anything-su-or-sudo "sudo"))

(require 'anything-match-plugin nil t)

(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (require 'anything-migemo nil t))

(when (require 'anything-complete nil t)
  ;; lisp�V���{���̕⊮���̍Č�������
  (anything-lisp-complete-symbol-set-timer 150))

(require 'anything-show-completion nil t)

(when (require 'auto-install nil t)
  (require 'anything-auto-install nil t))

(when (require 'descbinds-anything nil t)
  ;; describe-bindings��Anything�ɒu��������
  (descbinds-anything-install)))


;; --------------------------------------------------
;; verilog-mode 
;; VerilogHDL(.v�t�@�C��)

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
;; .cs�t�@�C��

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
;; .tex�t�@�C��

;; �G���R�[�f�B���O��utf-8�ɂ���
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
