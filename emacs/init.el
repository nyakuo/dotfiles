(defconst my-elisp-directory "~/.emacs.d/dotfiles/")

(dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
	 (list dir (format "%s%d" dir emacs-major-version))))
(when (and (stringp dir) (file-directory-p dir))
(let ((default-directory dir))
(add-to-list 'load-path default-directory)
(normal-top-level-add-subdirs-to-load-path))))

(load "init")
(load "coding_settings")
