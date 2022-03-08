

;; maybe refactor...
(defun copy-line ()
"Copy line(s) into kill-ring. "
  (let ((beg (line-beginning-position))
	(end (line-end-position)))
    (save-excursion 
    (when mark-active
     (if (> (point) (mark))
 	 (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
       (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
     (copy-region-as-kill beg end)
   )))


(defun duplicate--line (&optional direction)
  "Duplicates line(s) of text in DIRECTION. if DIRECTION is 1  duplicate to line bellow else duplicate to line abbove current line." 
  (save-mark-and-excursion
(copy-line)
(open-newline)
  (yank))
  (when (eq direction 1)
    (next-line)))

;;Fixme only works once for selected region since loosing the marked area when doing next line
(defun duplicate-line-down  ()
  "Creates newline(s) containing content of current line(s) below the current line. "
  (interactive)
  (duplicate--line 1))


(defun duplicate-line-up  ()
  "Creates  newline(s) containing content of current line(s) above the current line. "
  (interactive)
    (duplicate--line))

(defun open-newline (&optional n)
  "Opens a new line below current line even if cursor is in middle of current line.Move point to opened line. If N is set open n lines."
  (interactive "pNumber of lines to open: ")
  (goto-char (line-end-position))
	     (newline (or N 1)))

(defun move-line-down ()
  "Moves whole line down"
  (interactive "P")
  )

