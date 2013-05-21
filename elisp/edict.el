;;;
;;; Copyright (C) 1991, 1992 Per Hammarlund (perham@nada.kth.se)
;;;

;;; Some code that looks for translations of english and japanese using the
;;; EDICT Public Domain japanese/english dictionary.
;;;
;;; Helpful remarks from Ken-Ichi Handa (handa@etl.go.jp).
;;;

;;;
;;;   This program is free software; you can redistribute it and/or modify
;;;   it under the terms of the GNU General Public License as published by
;;;   the Free Software Foundation; either version 1, or (at your option)
;;;   any later version.
;;; 
;;;   This program is distributed in the hope that it will be useful,
;;;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;   GNU General Public License for more details.
;;; 
;;;   You should have received a copy of the GNU General Public License
;;;   along with this program; if not, write to the Free Software
;;;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;; 


;;; Add something like this to your .emacs file:
;;; (load "edict")
;;; (autoload 'edict-search-english "edict" "Search for a translation of an English word")
;;; (global-set-key "\e*" 'edict-search-english)
;;; (autoload 'edict-search-kanji "edict" "Search for a translation of a Kanji sequence")
;;; (global-set-key "\e_" 'edict-search-kanji)
;;;
;;; Also change the variable *edict-files* to reflect the real values.
;;; and perhaps also add something like:
;;; (setq *edict-files* (cons "~perham/emacs/local-edict" *edict-files*))
;;;

;;;
;;; TODO, at least this should be done.
;;;
;;; 1. Look at what is the best inteactive type for this code.
;;; 2. Perhaps create a version that actually lets the user choose
;;; from the matches.
;;; 3. Merge the two search funtion to one, depending on what we are
;;; looking at.
;;; 4. What are the best keys to bind to this function.
;;; 5. Make the windows fit snugly around the alternatives, but at
;;; most take half of the current window.
;;; 6. Make sure that it finds english words that are embedded in Japanese...
;;; 7. Take away \n in strings before matching...
;;;


;;*edict-files* should contain a list of filenames for the files that
;; should be read up into the *edict* buffer.
(defvar *edict-files* '("/u/s/matsu/lib/edictj")
"*This is a list of edict files that are loaded into the *edict* buffer
and searched. You will probably want at least one of them to be the real
EDICT file.")

;;The edict buffer where the data base, of sorts, is and the buffer
;; variable.
(defvar *edict-buffer-name* "*edict*")
(defvar *edict-buffer* nil)

;;The edict matches buffer and the name of it
(defvar *edict-match-buffer-name* "*edict matches*")
(defvar *edict-match-buffer* nil)


;;;
;;; Reads the edict files into a buffer.
;;;
(defun edict-init ()
  "Reads the edict file into a buffer called *edict*.

This is done only once and the *edict-buffer* is created.
Use edict-force-init to reread the edict files."

  ;;create a match buffer.
  (if (not (get-buffer *edict-match-buffer-name*))
    (setq *edict-match-buffer* (get-buffer-create
				*edict-match-buffer-name*)))
  ;;Create and read th edict files.
  (if (not (get-buffer *edict-buffer-name*))
    (progn
      (save-window-excursion

	;;First create the buffer and make it the current one
	(setq *edict-buffer* (get-buffer-create *edict-buffer-name*))
	(set-buffer *edict-buffer*)

	;;Read in the files from the list.
	(mapcar '(lambda (filename)
		   (if (file-readable-p filename)
		     (insert-file-contents filename)
		     (message (format "While loading edict files: \"%s\" isn't readable!" filename))))
		*edict-files*)

	;;If none of the files were readable 
	(if (= 0 (buffer-size))
	  (progn
	    (kill-buffer *edict-buffer*)
	    (error "No edict files found! Check value of *edict-files*.")))
	)))
  t)

;;;
;;;
;;;
(defun edict-force-init ()
  "This function rereads the edict files even if there is a edict buffer.

Used when you have updated the *edict-files* variable or corrupted the
edict buffer."
  (interactive)
  (kill-buffer *edict-buffer*)
  (edict-init))

;;;
;;;
;;;
(defun kanji-p ()
  (> (char-after (point)) 128))

;;;
;;;
;;;
(defun find-word-at-point ()
  "Find-word-at-point tries to find an English word close to or behind
point.

If it does not find any word it reports an error."
  (let (start end)

    ;; Move backward for word if not already on one.
    (if (not (looking-at "\\w"))
      (re-search-backward "\\w" (point-min) 'stay))

    (if (looking-at "[A-Za-z]")
      (progn
	(forward-char 1)

	(setq start (progn (backward-word 1) (point))
	      end (progn (forward-word 1) (point)))
	
	(buffer-substring start end))
      (error "Can't find English word!")
      )))

;;;
;;;
;;;
(defun edict-search-english ()
  "Attempts to translate the english word we are looking at. Picks the word 
in the same way as ispell, ie backs up from whitespace, and then expands.

Result is presented in a window that is not selected. Clear the window with
for instance C-X 1"

  (interactive)

  (let (word real-word)

    ;;Find the word
    (setq word (find-word-at-point))

    ;;ask the user if this is really the word that is interesting.
    (setq real-word (read-string
		     (format "Translate word (default \"%s\"): "
			     word)))

    ;;The user was interested in 'word', so move that to real-word.
    (if (equal real-word "")
      (setq real-word word))

    ;;Search if there is a word.
    (if (> (length real-word) 0)
      (edict-search-and-display real-word))
    ))

;;;
;;;
;;;
(defun edict-search-kanji (min max)
  "Attempts to translate the Kanji sequence between mark and point.

Result is presented in a window that is not selected. Clear the window
with for instance C-X 1"

  ;;Interactive, with a region as argument
  (interactive "r")

  ;;make sure that the dictionary is read
  (edict-init)

  (let ((word (buffer-substring min max)))
    (if (equal word "")
      (error "No word to search for!")
      (edict-search-and-display word)))
  t)

;;;
;;;
;;;
(defun copy-of-current-line ()
  "Copy-of-current-line creates and returns a copy of the line
where point is. It does not affect the buffer it is working on,
except for moving the point around.

It leaves the point at the end of the line, which is fine for this
application."

  ;;Find the start and end of the current line
  (let ((line-start (progn (beginning-of-line) (point)))
	(line-end   (progn (end-of-line) (point))))

    ;;return a copy of his line, perham, is there something that
    ;; should be tested here?
    (buffer-substring line-start line-end)))


;;;
;;;
;;;
(defun edict-search (key)
  "Searches the *edict-buffer* and returns a list of strings that are
the matches.

If there are no matches this string will be nil."

  ;;perham, should this really go here? Or what should we have? Look
  ;;at ispell.el...
  (save-window-excursion
    
    (message (format "Searching for word \"%s\"..." key))

    (let ((match-list nil))
      ;;select the database and goto to the first char
      (set-buffer *edict-buffer*)
      (goto-char (point-min))

      ;;Search for lines that match the key and copy the over to the
      ;; match buffer.
      (while (search-forward		;Ken-ichi says that one cannot
					;use the re-search-forward
					;function with actually having
					;some reg exp in the starget string.
;(concat "[\[/ 
;]" key "[\]/ ]")
key nil t)
	(setq match-list (append match-list (list
					     (copy-of-current-line)))))

      match-list)))


;;;
;;;
;;;
(defun edict-display (match-list)
  "Edict-display displayes the strings in a separate window that is
not seleceted."

  (set-buffer *edict-match-buffer*)
  (erase-buffer)

  (mapcar '(lambda (string-item)
	     (insert string-item)
	     (newline))
	  match-list)

  (display-buffer *edict-match-buffer*))


;;;
;;;
;;;
(defun edict-search-and-display (key)
  "Edict-search-and-display searches for matches to the argument key.
If there are any matches these are displayed in a window that is not
selected. This window can be removed with C-X 1."

  (edict-init)

  (save-excursion
    (let (match-list)

      ;;Search for matches
      (setq match-list (edict-search key))

      (if (not match-list)
	(error "No matches for key \"%s\"." key))

      (edict-display match-list))

    (message "Found it!")))



