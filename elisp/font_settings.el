;; --------------------------------------------------
;; フォント設定
;; Win: Meiryo
;; Mac: Menlo
;; X:   Ricty
(let ((ws window-system))
  (cond ((eq ws 'w64)
         (set-face-attribute 'default nil
                             :family "メイリオ"  ;; 英数
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "メイリオ")))  ;; 日本語
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Menlo"  ;; 英数
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Osaka")))    ;; 日本語
        ((eq ws 'x)
         (set-face-attribute 'default nil
                             :family "Ricty" ;; 英数
                             :height 130)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty")))))   ;; 日本語
