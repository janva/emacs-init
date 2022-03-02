;; Initialize package sources
 (require 'package)


(setq package-archives '(("melpa" ."https://melpa.org/packages/")
                          ("org" . "https://orgmode.org/elpa/")
                          ("elpa" . "https://elpa.gnu.org/packages/")))

 (package-initialize)

 (unless package-archive-contents
  (package-refresh-contents)) 
 ;; Initialize use-package on non-Linux platforms
 (unless (package-installed-p 'use-package)
    (package-install 'use-package))

 (require 'use-package)
 (setq use-package-always-ensure t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Using keyboard macros to define thes for now. These will effect the
;; kill ring as well as point and mark
(global-set-key (kbd" M-S-<down>") 'duplicate-line-down)
(fset 'duplicate-line-down
      (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w return ?\C-a ?\C-y] 0 "%d"))

(global-set-key (kbd" M-S-<up>") 'duplicate-line-up )
(fset 'duplicate-line-up 
      (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w up return ?\C-a ?\C-y ?\C-a] 0 "%d"))

(global-set-key (kbd"M-<up>")  'swapline-up)
(fset 'swapline-up
      (kmacro-lambda-form [?\C-a ?\C-k backspace ?\C-a return up ?\C-y ?\C-a tab] 0 "%d"))

(global-set-key (kbd "M-<down>")'swapline-down)
(fset 'swapline-down
      (kmacro-lambda-form [?\C-a ?\C-k down ?\C-e return ?\C-y up up ?\C-a ?\C-k down] 0 "%d"))

(global-set-key (kbd" C-<return>") 'open-newline)
(fset 'open-newline
      (kmacro-lambda-form [?\C-e return tab] 0 "%d"))

(global-set-key (kbd "<f12>")
                (lambda () 
                  (interactive) 
                  (find-file "~/.config/emacs/emacs.org")))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)         
(tooltip-mode -1)          
(set-fringe-mode 10)       

(menu-bar-mode -1)         

;; Set up the visible bell
(setq visible-bell t)

(use-package doom-themes
  :init (load-theme 'doom-horizon t))
;;use refresh-pakcages to get this working
(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(column-number-mode)

;; (global-display-line-numbers-mode t)
(dolist (mode'(org-mode-hook
               term-mode-hook
               shell-mode-hook
               eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "Fira Code Retina" :height 170)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 210 :weight 'regular)

(global-visual-line-mode  1)

(setq scroll-conservatively 99)

(use-package swiper
     :ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)	
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-alist nil )) ; don't start search with ^

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(defun efs/org-font-setup ()
;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾" 
	org-hide-emphasis-markers t
	org-src-tab-acts-natively t))

(defun efs/org-mode-setup()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
'org-babel-do-load-languages '(
(emacs-lisp . t)
(python . t)))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;;auto-tangle files to target on save
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
(expand-file-name "~/.config/emacs/emacs.org"))
;; Dynamic scoping to the rescue
(let ((org-confirm-babel-evaluate nil))
(org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;;cln/command-log-buffer
;;If package is not found try to refresh M-x package-list-packages
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;hydra;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hydra lets you repeat commands in convienient manner 
;;
;;
(use-package hydra)


(defhydra hydra-text-scale(:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finnished" :exit t))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(electric-pair-mode 1)  
(show-paren-mode t)

(use-package yasnippet
;; :init
;; (setq lsp-completion-provider :none) 
:config
 (setq yas-snippets-dirs '("~/programering/settings/emacs2021/snippets"))
 (yas-global-mode 1))

(use-package yasnippet-snippets)

(defun efs/lsp-mode-setup ()
  ;; (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file ;; symbols))
(lsp-headerline-breadcrumb-mode 1))

(use-package lsp-mode
:commands (lsp lsp-deferred)
:hook (lsp-mode . efs/lsp-mode-setup)
:init
(setq lsp-keymap-prefix "C-c l")  
:config
(lsp-enable-which-key-integration t))

(use-package lsp-ui
:hook (lsp-ui . lsp-ui-mode)
:custom (lsp-ui-doc-position  'bottom))

(use-package lsp-treemacs
:after lsp)

(use-package lsp-ivy)

(use-package typescript-mode
:mode "\\.ts\\'"
:hook (typescript-mode . lsp-deferred)
:config
(setq typescript-indent-level 2))

(use-package sh-mode
  :mode "\\.sh\\'"
  :ensure nil
  :hook (sh-mode . lsp-deferred))

(defun   jv/setup-emacs-lisp-mode()
   (message "running my hook")
;;     (push '(company-elisp :with company-yasnippet)  company-backends)
     (setq-local  company-backends '((company-elisp :with company-yasnippet))))

;; TODO hmm would like to make a seperation as well that is use :separate
(use-package emacs-lisp-mode
  :ensure nil
  :mode  "\\.el\\'"
  :hook (emacs-lisp-mode . company-mode)
  ;;company-elisp is obsolete?
  ;; could just use push instead?
  :custom  (company-backends    '(( :separate company-yasnippet company-capf  )

                                  company-bbdb  company-files 
                                  (company-dabbrev-code company-gtags  company-keywords :with company-yasnippet ::separate)
                                  company-oddmuse company-dabbrev)))
          ;; TODO make yassnippets local maybe 2. push infront of already existing list
            ;; figure out the :separate

     ;; (push '(company-elisp :with company-yasnippet)  company-backends) ) 

            ;;:hook(  emacs-lisp-mode . company-mode ))
       ;;  ( emacs-lisp-mode . jv/setup-emacs-lisp-mode) )

(use-package company
 ;; :after lsp-mode
  ;; :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.1))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p". projectile-command-map)
  :init
  (when (file-directory-p "~/programering")
    (setq projectile-project-search '("~programering")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package  counsel-projectile
  :config (counsel-projectile-mode))
;;#' is like ' but for functions returns function object without evaluating it # is mainly help to byte compiler 
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Anonymous-Functions.html#Anonymous-Functions  

;;.dir-locals.el
;; can be use for directory local variables for instance
;;((nil .((projectile-project-run-cmd ."npm start") )))

(use-package command-log-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("23c806e34594a583ea5bbf5adf9a964afe4f28b4467d28777bcba0d35aa0872e" default))
 '(exwm-floating-border-color "#16161c")
 '(fci-rule-color "#f9cec3")
 '(highlight-tail-colors ((("#203a3b") . 0) (("#283841") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#16161c" "#e95678"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#16161c" "#09f7a0"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#16161c" "#6a6a6a"))
 '(objed-cursor-color "#e95678")
 '(package-selected-packages
   '(visual-fill-column org-bullets magit counsel-projetile hydra helpful which-key doom-themes swiper doom-modeline ivy command-log-mode use-package))
 '(pdf-view-midnight-colors (cons "#c7c9cb" "#232530"))
 '(rustic-ansi-faces
   ["#232530" "#e95678" "#09f7a0" "#fab795" "#21bfc2" "#6c6f93" "#59e3e3" "#c7c9cb"])
 '(vc-annotate-background "#232530")
 '(vc-annotate-color-map
   (list
    (cons 20 "#09f7a0")
    (cons 40 "#59e19c")
    (cons 60 "#a9cc98")
    (cons 80 "#fab795")
    (cons 100 "#f6ab8f")
    (cons 120 "#f39f89")
    (cons 140 "#f09383")
    (cons 160 "#c48788")
    (cons 180 "#987a8d")
    (cons 200 "#6c6f93")
    (cons 220 "#95668a")
    (cons 240 "#bf5e81")
    (cons 260 "#e95678")
    (cons 280 "#c95b74")
    (cons 300 "#a96071")
    (cons 320 "#89656d")
    (cons 340 "#f9cec3")
    (cons 360 "#f9cec3")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
