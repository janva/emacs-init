
# Table of Contents

1.  [Package handeling](#org008fad9)
2.  [Keybindings](#orga3b7a96)
3.  [UI](#org9f02aa0)
    1.  [Basic UI config](#org0ef7f4b)
    2.  [Themes](#org8b77e60)
    3.  [Line numbers](#org7c79edc)
4.  [Fonts configuration](#orgb7e37b0)
5.  [Some basic behaviours configs](#orgf956157)
    1.  [Swiper](#org2afd85c)
    2.  [Ivy](#org8e1555d)
    3.  [Counsel](#orgf5e6e0d)
6.  [Modes](#org4114f0e)
    1.  [Org-mode](#orgaf492db)
        1.  [Org basic](#orgedb452c)
    2.  [Org babel mode](#org02bd6ff)
        1.  [Babel languages config](#orge4b0273)
        2.  [Org-structure templates  configs](#org73651c7)
        3.  [Org-babel  tangle configs](#org3548b88)
    3.  [Which-key](#orga16bb7f)
    4.  [Hydra](#org3766834)
    5.  [The helpful package](#org2938e88)
    6.  [Parentices rainbow delimiters](#orgabc2da7)
7.  [Development](#orgf9d119e)
    1.  [Projectile](#org85f9bf1)
8.  [Just some random helpfull packages](#orgf025533)
9.  [Set by emacs customization](#org9d67e17)



<a id="org008fad9"></a>

# Package handeling

In this setup use-package is used to simplify configuration and loading of packages. Usepackage introduces tidy syntax to isolate package loading in a performant way.

  We set a few package repositories, load and activate packages from package-load-list  `(package-initialize)`. Check if archive list (list of packateges) are cached if not we download list. The use-package comes preinstalled with emacs on most system but not necesarilly on windows so we check we can find this package and install it unless is has not yet been installed.
We require use-package `(require 'package).`  The require function loads feature (in this case 'package) only if it hasn't yet been loaded. Finally we set `:ensure t` as defualt for all package `(setq use-package-always-ensure t)`. This will cause packages to be downloaded and installed automatically unless they are already installed. For more on use-package see

[Use package github page](https://github.com/jwiegley/use-package)

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


<a id="orga3b7a96"></a>

# Keybindings

    ;; Make ESC quit prompts
        (global-set-key (kbd "<escape>") 'keyboard-escape-quit)


<a id="org9f02aa0"></a>

# UI


<a id="org0ef7f4b"></a>

## Basic UI config

As little distraction as possible please. No scroll-bars tool-bars and no annoying sounds instead use visible bell.

    (setq inhibit-startup-message t)
    
    (scroll-bar-mode -1)        ; Disable visible scrollbar
    (tool-bar-mode -1)         
    (tooltip-mode -1)          
    (set-fringe-mode 10)       
    
    (menu-bar-mode -1)         
    
    ;; Set up the visible bell
    (setq visible-bell t)


<a id="org8b77e60"></a>

## Themes

I like the Doom-themes. These themes comes with some nice icons which for instance are used in the mode line. I had to install requires all-the-icons-install-fonts on my Ubuntu get this working. `:init` keyword will make code run before package is loaded. We use th all-the-icons to get some nice icons and the tweak the mode-line. `:ensure t` isn't stricly needed as we set this as default for all packages. The `:custom`  keyword is used here to set custom variables of doom-modeline packages.

[Doom-themes github page](https://github.com/doomemacs/themes)

    (use-package doom-themes
      :init (load-theme 'doom-horizon t))
    ;;use refresh-pakcages to get this working
    (use-package all-the-icons)
    (use-package doom-modeline
      :ensure t
      :init (doom-modeline-mode 1)
      :custom ((doom-modeline-height 15)))


<a id="org7c79edc"></a>

## Line numbers

    (column-number-mode)
    ;; (global-display-line-numbers-mode t)
    
         (dolist (mode'(org-mode-hook
    		    term-mode-hook
    		    shell-mode-hook
    	       eshell-mode-hook))
           (add-hook mode (lambda() (display-line-numbers-mode 0))))


<a id="orgb7e37b0"></a>

# Fonts configuration

    (set-face-attribute 'default nil :font "Fira Code Retina" :height 170)
    
    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)
    
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 295 :weight 'regular)
    
    ;; (load-theme 'wombat)


<a id="orgf956157"></a>

# Some basic behaviours configs

    (setq scroll-step 1)


<a id="org2afd85c"></a>

## Swiper

   [swiper elpa](https://elpa.gnu.org/packages/swiper.html)
   [swiper on github](https://github.com/abo-abo/swiper/tree/c97ea72285f2428ed61b519269274d27f2b695f9)
   This package gives an overview of the current regex search
candidates.  The search regex can be split into groups with a
space.  Each group is highlighted with a different face.

It can double as a quick \`regex-builder', although only single
lines will be matched.

    (use-package swiper
         :ensure t)


<a id="org8e1555d"></a>

## Ivy

Ivy minor mode is a generic completion mechanism for Emacs. Ivy-mode ensures completing-read-function uses ivy for completion

[Ivy on github page](https://github.com/abo-abo/swiper) 

    
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


<a id="orgf5e6e0d"></a>

## Counsel

   [counsel on melpa](https://melpa.org/#/counsel)
ivy-mode ensures that any Emacs command using completing-read-function uses ivy for completion.

Counsel takes this further, providing versions of common Emacs commands that are customised to make the best use of Ivy. For example, counsel-find-file has some additional keybindings. Pressing DEL will move you to the parent directory.

Enabling counsel-mode remaps built-in Emacs functions that have counsel replacements:

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


<a id="org4114f0e"></a>

# Modes

Modes (editing modes) in emacs are used to alters how emacs behaves in some useful ways.Modes are categorized as being either major or minor.
Major mode provides means for working with particular file type (.org, .c .pdf etc) or buffers of none-file type (shell etc). Each buffer allways uses a single major mode at any time.
Minor modes are independent modes that associates some additional behaviour (suger) to file or buffer type. By independt we mean that they are not dependent on other modes neither major or minor ones and as such can be used independently of other modes. Minor modes can be turned on and off as we you wish you can have any number of minor modes in use for each buffer. Examples of minor modes are show-paren-mode, display-line-number-mode and cwarn-mode 


<a id="orgaf492db"></a>

## Org-mode


<a id="orgedb452c"></a>

### Org basic

    (defun efs/org-font-setup ()
      ;; Replace list hyphen with dot
      (font-lock-add-keywords 'org-mode
    			  '(("^ *\\([-]\\) "
    			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))))

    (use-package org
      :config
      (setq org-elisp " ▾" 
    	org-hide-emphasis-markers t)
      (efs/org-font-setup))

    (defun efs/org-mode-setup()
      (org-indent-mode)
      (variable-pitch-mode 1)
      (auto-fill-mode 0)
      (visual-line-mode 1))
    
    (dolist (face '((org-level-1 .  1.2 )
    		(org-level-2 .  1.1 )
    		(org-level-3 .  1.05 )
    		(org-level-4 .  1.0 )
    		(org-level-5 .  1.1 )
    		(org-level-6 .  1.1 )
    		(org-level-7 .  1.1 )
    		(org-level-8 .  1.1 )))
      (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))
    
    
    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
    ;;)

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

    ;; READ up on this. It might take som trickery to load this file such as revert buffer
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


<a id="org02bd6ff"></a>

## Org babel mode

Babel adds ability to exucute source code within org documents. Babel allows for data to be passed accross different parts of document independantly of source languges and applications. For instance we could have a python block outputting some data as input to c block which later could be passed through GnuPlot block and to finally be embeded in document as plot. Using org babel mode we can use org for litteral programming. Babel can preprocess document and write source code to seperate file  (tangled in litterate programming jargon).  


<a id="orge4b0273"></a>

### Babel languages config

    (org-babel-do-load-languages
    'org-babel-do-load-languages '(
    (emacs-lisp . t)
    (python . t)))


<a id="org73651c7"></a>

### Org-structure templates  configs

      ;; https://orgmode.org/worg/org-contrib/babel/languages/
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python"))


<a id="org3548b88"></a>

### Org-babel  tangle configs

         ;;auto-tangle files to target on save
    (defun efs/org-babel-tangle-config ()
      (when (string-equal (buffer-file-name)
    		      (expand-file-name "~/.emacs.d/emacs.org"))
        ;; Dynamic scoping to the rescue
        (let ((org-confirm-babel-evaluate nil))
          (org-babel-tangle))))
    
    (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))


<a id="orga16bb7f"></a>

## Which-key

Emacs minor mode that displays popup with possible keybindings on prefix commands such C-c C-x M-x. I this config I popup will ony show after beeing idle for at leas 1 second. 

    ;;cln/command-log-buffer
    ;;If package is not found try to refresh M-x package-list-packages
    (use-package which-key
      :init (which-key-mode)
      :diminish which-key-mode
      :config
      (setq which-key-idle-delay 1))


<a id="org3766834"></a>

## Hydra

Lets you do repetive commands in convienient manner
[Hydra package on github](https://github.com/abo-abo/hydra)

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


<a id="org2938e88"></a>

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


<a id="orgabc2da7"></a>

## Parentices rainbow delimiters

    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))


<a id="orgf9d119e"></a>

# Development


<a id="org85f9bf1"></a>

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


<a id="orgf025533"></a>

# Just some random helpfull packages

    (use-package command-log-mode)


<a id="org9d67e17"></a>

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

