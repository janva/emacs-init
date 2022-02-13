(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)         
(tooltip-mode -1)          
(set-fringe-mode 10)       

(menu-bar-mode -1)         

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 170)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 210 :weight 'regular)

(org-babel-do-load-languages
'org-babel-do-load-languages '(
(emacs-lisp . t)
(python . t)))

;; https://orgmode.org/worg/org-contrib/babel/languages/
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
