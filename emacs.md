
# Table of Contents

1.  [Package handeling](#org84a8046)
2.  [UI](#orgbf12b12)
    1.  [Basic UI config](#org8da23d3)
    2.  [Skins](#org3933860)
    3.  [Line numbers](#org0ffd4bc)
3.  [Fonts configuration](#org11e928e)
4.  [Org babel mode](#orgaedf971)
    1.  [Babel languages config](#orgf9613c4)
    2.  [Org-structure templates  configs](#orga5328f9)
    3.  [Org-babel  tangle configs](#orgf33430a)
5.  [Applications](#org668ef72)
    1.  [Swiper](#org0cea079)
    2.  [Ivy](#org6a45e53)
    3.  [Counsel](#orgda5fee5)
    4.  [Which-key](#orgf20374c)
    5.  [Org-mode](#org659f344)
    6.  [The helpful package](#org7682028)
    7.  [Hydra](#orgb1ec600)
    8.  [Projectile](#org0fd66d2)
    9.  [Parentices rainbow delimiters](#org5b3b5a4)
6.  [Just some random helpfull packages](#orgec5b859)
7.  [Set by emacs customization](#orgfa56865)

\#+title Emacs config


<a id="org84a8046"></a>

# Package handeling

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


<a id="orgbf12b12"></a>

# UI


<a id="org8da23d3"></a>

## Basic UI config

        (setq inhibit-startup-message t)
    
        (scroll-bar-mode -1)        ; Disable visible scrollbar
        (tool-bar-mode -1)          ; Disable the toolbar
        (tooltip-mode -1)           ; Disable tooltips
        (set-fringe-mode 10)        ; Give some breathing room
    
        (menu-bar-mode -1)           ; Disable the menu bar
    ;; TODO Move these to some ohter block 
        ;; Set up the visible bell
        (setq visible-bell t)
    
        ;; Make ESC quit prompts
        (global-set-key (kbd "<escape>") 'keyboard-escape-quit)


<a id="org3933860"></a>

## Skins

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


<a id="org0ffd4bc"></a>

## Line numbers

    (dolist (mode'(org-mode-hook
    	       term-mode-hook
    	       shell-mode-hook
    	  eshell-mode-hook))
      (add-hook mode (lambda() (display-line-numbers-mode 0))))


<a id="org11e928e"></a>

# Fonts configuration

    (set-face-attribute 'default nil :font "Fira Code Retina" :height 170)
    
    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)
    
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 295 :weight 'regular)
    
    ;; (load-theme 'wombat)


<a id="orgaedf971"></a>

# Org babel mode


<a id="orgf9613c4"></a>

## Babel languages config

    (org-babel-do-load-languages
    'org-babel-do-load-languages '(
    (emacs-lisp . t)
    (python . t)))


<a id="orga5328f9"></a>

## Org-structure templates  configs

      ;; https://orgmode.org/worg/org-contrib/babel/languages/
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python"))


<a id="orgf33430a"></a>

## Org-babel  tangle configs

         ;;auto-tangle files to target on save
    (defun efs/org-babel-tangle-config ()
      (when (string-equal (buffer-file-name)
    		      (expand-file-name "~/.emacs.d/emacs.org"))
        ;; Dynamic scoping to the rescue
        (let ((org-confirm-babel-evaluate nil))
          (org-babel-tangle))))
    
    (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))


<a id="org668ef72"></a>

# Applications


<a id="org0cea079"></a>

## Swiper

   [swiper elpa](https://elpa.gnu.org/packages/swiper.html)
   This package gives an overview of the current regex search
candidates.  The search regex can be split into groups with a
space.  Each group is highlighted with a different face.

It can double as a quick \`regex-builder', although only single
lines will be matched.

    (use-package swiper
         :ensure t)


<a id="org6a45e53"></a>

## Ivy

Taken from github page [Ivy on github](https://github.com/abo-abo/swiper) 
Ivy is a generic completion mechanism for Emacs. While it operates similarly to other completion schemes such as icomplete-mode, Ivy aims to be more efficient, smaller, simpler,and smoother to use yet highly customizable.To try Ivy, just call M-x ivy-mode. This will enable generic Ivy completion including specific completion for file and buffer names.

    
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

;;TODO move to keyboard setting settings

    (global-set-key (kbd "C-M-j") 'counsel-switch-buffer)


<a id="orgda5fee5"></a>

## Counsel

[counsel on melpa](https://melpa.org/#/counsel)
Just call one of the interactive functions in this file to complete
the corresponding thing using \`ivy'.

Currently available:

-   Symbol completion for Elisp, Common Lisp, Python, Clojure, C, C++.
-   Describe functions for Elisp: function, variable, library, command,
    bindings, theme.
-   Navigation functions: imenu, ace-line, semantic, outline.
-   Git utilities: git-files, git-grep, git-log, git-stash, git-checkout.
-   Grep utilities: grep, ag, pt, recoll, ack, rg.
-   System utilities: process list, rhythmbox, linux-app.
-   Many more.
    
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


<a id="orgf20374c"></a>

## Which-key

    ;;cln/command-log-buffer
    ;;If package is not found try to refresh M-x package-list-packages
    (use-package which-key
      :init (which-key-mode)
      :diminish which-key-mode
      :config
      (setq which-key-idle-delay 1))


<a id="org659f344"></a>

## Org-mode

    (defun efs/org-font-setup ()
      ;; Replace list hyphen with dot
      (font-lock-add-keywords 'org-mode
    			  '(("^ *\\([-]\\) "
    			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

    (defun efs/org-mode-setup()
      (org-indent-mode)
      (variable-pitch-mode 1)
      (auto-fill-mode 0)
      (visual-line-mode 1))
    
         ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    ;; part of function por own block
         (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
         (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
         (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
         (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
         (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
         (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
         (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
         ;;)

    (use-package org
      :config
      (setq org-elisp " ▾" 
    	org-hide-emphasis-markers t)
      (efs/org-font-setup))

    (use-package org-bullets
      :after org
      :hook (org-mode . org-bullets-mode)
      :custom
      (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
    (dolist (face '((org-level-1 .  1.2 )
    		(org-level-2 .  1.1 )
    		(org-level-3 .  1.05 )
    		(org-level-4 .  1.0 )
    		(org-level-5 .  1.1 )
    		(org-level-6 .  1.1 )
    		(org-level-7 .  1.1 )
    		(org-level-8 .  1.1 )))
      (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

    (defun efs/org-mode-visual-fill ()
      (setq visual-fill-column-width 100
    	visual-fill-column-center-text t)
      (visual-fill-column-mode 1))

    (use-package visual-fill-column
      :hook (org-mode . efs/org-mode-visual-fill))

    ;; READ up on this. It might take som trickery to load this file such as revert buffer
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


<a id="org7682028"></a>

## The helpful package

[helpful github page](https://github.com/Wilfred/helpful)
 Helpful is an alternative to the built-in Emacs help that provides much more contextual information.

    (use-package helpful
      :custom
      (counsel-describe-function-function #'helpful-callable)
      (counsel-describe-variable-function #'helpful-variable)
      :bind
      ([remap describe-function] . counsel-describe-function)
      ([remap describe-command] . helpful-command)
      ([remap describe-variable] . counsel-describe-variable)
      ([remap describe-key] . helpful-key))


<a id="orgb1ec600"></a>

## Hydra

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


<a id="org0fd66d2"></a>

## Projectile

Project managing package. [Projectile github-page](https://github.com/bbatsov/projectile)

    
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


<a id="org5b3b5a4"></a>

## Parentices rainbow delimiters

    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))


<a id="orgec5b859"></a>

# Just some random helpfull packages

    (use-package command-log-mode)


<a id="orgfa56865"></a>

# Set by emacs customization

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

