;; a variable ending with -mode
;; a function with same name as variable
;;if we want it to be local to certain buffer set make-variable-buffer-localm

;; we can in addtition enable keymaps by adding entries in minor-mode-map-alist. should be pairs of minor modes symbol and keymap to be used

;;we can alsp enable lighter for minor-mode-alist
;; again usin minor mode variable symbol and

(make-variable-buffer-local
 (defvar jv-basic-edit-mode nil)
 "Toggle jv-edit-basic-mode")

(defvar jv-basic-edit-mode-map (make-sparse-keymap) "The keymap for jv-edit-basic-mode")

(define-key jv-basic-edit-mode-map (kbd "C-<return>" 'open-new-line ))
;;register minor mode
(add-to-list 'minor-mode-alist '(jv-basic-edit-mode " jv-edit"))
;;register keybingings map
(add-to-list 'minor-mode-alist '(jv-basic-edit-mode jv-basic-edit-mode-map))

(defun jv-basic-edit-mode (&optional ARG)
  "jv-basic-edit-mode is a minor mode consisting of a few basic editing commands. If ARG positive number > 0  activate mode else deactivate.If ARG is 'toggle then toggle mode"
  (interactive (list 'toggle))
  (setq jv-basic-mode
	(if (eq ARG 'toggle)
	    (not jv-basic-edit-mode)
	  (> ARG 0)))
  (if jv-basic-edit-mode
      (message "jv-basic-mode activated")
    (message "jv-basic-mode deactivated"))
  (run-hooks 'jv-basic-edit-mode-hook))

(defun open-newline (&optional n)
  "Opens a new line below current line even if cursor is in middle of current line.Move point to opened line. If N is set open n lines."
  (interactive "pNumber of lines to open: ")
  (goto-char (line-end-position))
	     (newline (or n 1)))


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

(defun swapline-down (args)
  "Swaps current line with next line below. Point is set to beginning of line which was selected for swapping."
  (interactive "P")
  (kill-whole-line args)
  (end-of-line)
  (newline)
  (save-excursion 
    (insert  (substring  (current-kill 0 ) 0 -1))))

(defun swapline-up (arg)
  "Swaps current line with previous line above."
  (interactive "P")
  (kill-whole-line)
  (beginning-of-line)
  (save-excursion
    (insert
     (current-kill 0))))

;;hmmm;;hmmm
;; more
;; (barf-if-buffer-read-only)
;; (barf-if-buffer-read-only)
(insert
(current-kill 0));; (barf-if-buffer-read-only)




;;;;; just some stuff from eintr ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mark-whole-buffer ( )
  "put point at beginning and mark at end of buffer"
  (interactive)
  (goto-char(point-max))    
  (push-mark(point))
  (goto-char(point-min))
  )


(defun display-60-first-chars ()
  "displays 60 first character in buffer even if buffer is narrowed"
  (interactive )
  (save-excursion
    (save-restriction
      (widen)
      (message "%s" (buffer-substring (point-min) 60)))))

(defun test-search (string)
  "search for for STRING in forward direction inside current buffer. Set point after string if found else error. "
  (interactive "sString of text to searh for:")
  (search-forward string)
  )

(defun thrid-el-in-kill-ring ()
  "Print value of third element in kill ring if exists in minibuffer."
  (interactive )
  (if (>(length kill-ring) 2 )
      (nth 3 kill-ring )
    (message "Kill ring does not contain 3 elements.")  
)
  )
(forward-line 1)

dskaölfkfd yank
dsfasfdsdf
sdfasa

;;(buffer-substring)
;; (filter-buffer-substring)
;; is replacement for buffer-substring it returns substring whitout certain text properties

;; (condition-case)
;; is elisp exception handeling mechanism similar a bit like try catch 

;; (save-restriction)
;; is similiar to save-excursion but it reset narrowing.
;; (condition-case
;;     (var-part)
;;     (body-part)
;;  (error-part))
