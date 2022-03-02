(defun duplicate--line (&optional direction)
  "Duplicates line of text in DIRECTION. 1 will duplicate to line bellow and -1 to line abbove current line. default value is 1"
  (message"Under construction"))
(duplicate--line)

(defun duplicate-line-down  ()
  "Creates a newline containing content of current line below the current line. "
  (interactive)
  (save-excursion 
    (beginning-of-line)
    (push-mark)
    (end-of-line)
    (copy-region-as-kill (point) (mark))
    (newline)
    (yank))
  (next-line))









