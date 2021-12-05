(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 170)

(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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

(use-package command-log-mode)
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

;;
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
;;use counsel-load-theme
(use-package doom-themes
  :init (load-theme 'doom-horizon t))
;;use refresh-pakcages to get this working
;; requires all-the-icons-install-fonts
(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))


;;(column-number-mode)
;;(global-display-line-numbers-mode t)

(dolist (mode'(org-mode-hook
	       term-mode-hook
	       shell-mode-hook
	  eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;cln/command-log-buffer
;;If package is not found try to refresh M-x package-list-packages
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

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


;;;;;;;;;;;;;;;;;;;inser helpful here;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

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
;; READ up on this. It might take som trickery to load this file such as revert buffer
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(counsel-projetile hydra helpful which-key doom-themes swiper doom-modeline ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

