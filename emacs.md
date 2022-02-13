
# Table of Contents

1.  [Package handeling](#org5929541)
2.  [Keybindings](#org06b86d7)
3.  [UI](#org737ff1a)
    1.  [Basic UI config](#orge1e6348)
    2.  [Themes](#orgc7b9196)
    3.  [Line numbers](#org4d8ea02)
4.  [Fonts configuration](#orgc0f71cd)
5.  [Some basic behaviours configs](#org6bd4e7e)
    1.  [Swiper](#orgab7332f)
    2.  [Ivy](#org270cdf1)
    3.  [Counsel](#org8d4de36)
6.  [Modes](#org1b455ea)
    1.  [Org-mode](#org2e17b0e)
        1.  [Org basic](#org7beff22)
    2.  [Org babel mode](#orgdc4fdff)
        1.  [Babel languages config](#org8232cbc)
        2.  [Org-structure templates  configs](#orgae04900)
        3.  [Org-babel  tangle configs](#orgd3a4569)
    3.  [Which-key](#orged264c1)
    4.  [Hydra](#org4e08efa)
    5.  [The helpful package](#orge2ae967)
    6.  [Parentices rainbow delimiters](#orga26221b)
7.  [Development](#orgf95eb3d)
    1.  [Common settings for all dev modes](#org4c1636b)
    2.  [langauges](#orgae3d316)
        1.  [yasnippets](#org0a666f0)
        2.  [Breadcrumbs in LSP mode](#org5ebe8a4)
        3.  [LSP servers ( language server protocol)](#org07b55f8)
        4.  [Better LSP UI](#org6aa867b)
        5.  [Treemacs for nice treestructures](#orgbbcfc7f)
        6.  [lsp with ivy integration](#org4bffad6)
        7.  [TypeSript](#org3fdb950)
        8.  [Bash scripts](#orgc991733)
    3.  [Company](#org377cf8b)
        1.  [Company box mode](#org8f56531)
    4.  [Git tools ie magit](#orgabcbe7d)
    5.  [Projectile](#org38f0e67)
8.  [Just some random helpfull packages](#orga3e7e67)
9.  [Set by emacs customization](#org8d066f1)

\#+title Emacs config


<a id="org5929541"></a>

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


<a id="org06b86d7"></a>

# Keybindings

    ;; Make ESC quit prompts
        (global-set-key (kbd "<escape>") 'keyboard-escape-quit)


<a id="org737ff1a"></a>

# UI


<a id="orge1e6348"></a>

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


<a id="orgc7b9196"></a>

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


<a id="org4d8ea02"></a>

## Line numbers

       (column-number-mode)
    ;; (global-display-line-numbers-mode t)
    
         (dolist (mode'(org-mode-hook
    		    term-mode-hook
    		    shell-mode-hook
    	       eshell-mode-hook))
           (add-hook mode (lambda() (display-line-numbers-mode 0))))


<a id="orgc0f71cd"></a>

# Fonts configuration

    (set-face-attribute 'default nil :font "Fira Code Retina" :height 170)
    
    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)
    
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 295 :weight 'regular)


<a id="org6bd4e7e"></a>

# Some basic behaviours configs

Turn on word wrappping on long lines using v. 

    (visual-line-mode 1)

Documentation pages suggests to setting scroll conservatively to high value rather than setting scroll-step to 1 if you want to scroll only single line at the time.

    (setq scroll-conservatively 99)


<a id="orgab7332f"></a>

## Swiper

[swiper elpa](https://elpa.gnu.org/packages/swiper.html)
[swiper on github](https://github.com/abo-abo/swiper/tree/c97ea72285f2428ed61b519269274d27f2b695f9)
An UI on top of ISearch (Incremental Search). Swiper gives an overview of the current regex search candidates. Matches are presented in an intuitive fashion and you cab jump to location of selected match. (in buffer search) presented in minibuffer

    (use-package swiper
         :ensure t)


<a id="org270cdf1"></a>

## Ivy

Ivy minor mode is a generic completion mechanism for Emacs. Ivy-mode ensures completing-read-function uses ivy for completion. Used for instance when finding files.

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


<a id="org8d4de36"></a>

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


<a id="org1b455ea"></a>

# Modes

Modes (editing modes) in emacs are used to alters how emacs behaves in some useful ways.Modes are categorized as being either major or minor.
Major mode provides means for working with particular file type (.org, .c .pdf etc) or buffers of none-file type (shell etc). Each buffer allways uses a single major mode at any time.
Minor modes are independent modes that associates some additional behaviour (suger) to file or buffer type. By independt we mean that they are not dependent on other modes neither major or minor ones and as such can be used independently of other modes. Minor modes can be turned on and off as we you wish you can have any number of minor modes in use for each buffer. Examples of minor modes are show-paren-mode, display-line-number-mode and cwarn-mode 


<a id="org2e17b0e"></a>

## Org-mode

Org mode is similar to markdown but with a lot more functionallity.


<a id="org7beff22"></a>

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


<a id="orgdc4fdff"></a>

## Org babel mode

   Babel adds ability to exucute source code within org documents. Babel allows for data to be passed accross different parts of document independantly of source languges and applications. For instance we could have a python block outputting some data as input to c block which later could be passed through GnuPlot block and to finally be embeded in document as plot. Using org babel mode we can use org for litteral programming. Babel can preprocess document and write source code to seperate file  (tangled in litterate programming jargon).  
breadcrumb


<a id="org8232cbc"></a>

### Babel languages config

    (org-babel-do-load-languages
    'org-babel-do-load-languages '(
    (emacs-lisp . t)
    (python . t)))


<a id="orgae04900"></a>

### Org-structure templates  configs

      ;; https://orgmode.org/worg/org-contrib/babel/languages/
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python"))


<a id="orgd3a4569"></a>

### Org-babel  tangle configs

        ;;auto-tangle files to target on save
    (defun efs/org-babel-tangle-config ()
    (when (string-equal (buffer-file-name)
    (expand-file-name "~/.config/emacs/emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
    (org-babel-tangle))))
    
    (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))


<a id="orged264c1"></a>

## Which-key

Emacs minor mode that displays popup with possible keybindings on prefix commands such C-c C-x M-x. I this config I popup will ony show after beeing idle for at leas 1 second. 

    ;;cln/command-log-buffer
    ;;If package is not found try to refresh M-x package-list-packages
    (use-package which-key
      :init (which-key-mode)
      :diminish which-key-mode
      :config
      (setq which-key-idle-delay 1))


<a id="org4e08efa"></a>

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


<a id="orge2ae967"></a>

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


<a id="orga26221b"></a>

## Parentices rainbow delimiters

    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))


<a id="orgf95eb3d"></a>

# Development


<a id="org4c1636b"></a>

## Common settings for all dev modes

matching pairs of things such as parentecis


<a id="orgae3d316"></a>

## langauges


<a id="org0a666f0"></a>

### yasnippets

    (use-package yasnippet
    ;; :init
    ;; (setq lsp-completion-provider :none) 
    :config
     (setq yas-snippets-dirs '("~/programering/settings/emacs2021/snippets"))
     (yas-global-mode 1))    

    (use-package yasnippet-snippets)


<a id="org5ebe8a4"></a>

### Breadcrumbs in LSP mode

     (defun efs/lsp-mode-setup ()
    ;; (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
     (lsp-headerline-breadcrumb-mode 1))


<a id="org07b55f8"></a>

### LSP servers ( language server protocol)

LSP is an effort made by VSCode team to standardize the protocol for language servers.The idea is to have single standardize server protocol between language server and dev-tool. In such an scenario we can reuse language server accross different devtools with minimal effort which is good news for both language providers and tooling vendors. Information about LSP support can be found at [Emacs LSP-mode language support pages](https://emacs-lsp.github.io/lsp-mode/). 

LSP-mode for emacs aims to provide a more IDE like experience to emacs.
Normally you are required to seperatly install a language server for each language. Again the link above will provide needed information on specific language support. 

`:commands` keyword  creates autoloads for the commands you list. An autoload in elisp is a mechanism to make known (register) a function but defer of loading the file that actualy defines it.
The file is instead loaded at first call to function or macro. The hook `(:hook)` is setup to call `efs/lsp-mode-setup` function which simply setups breadcrumb mode in all our LSP buffers(windows?).The prefix keybinding for lsp commmands is set to `C-c l`. Finally we enable which-key for LSP.

Some keybinding and commands to get you started  (remember prefix keybining was set to C-c l).

C-c l g r find references
C-c l g g find definitions
C-l l r r refactor rename
fly-make-show-diagnostic-buffer show buffer with errors

There exist a `lsp-format-buffer` command but might be a better idea to us seperate language specific formatter for this job

    (use-package lsp-mode
    :commands (lsp lsp-deferred)
    :hook (lsp-mode . efs/lsp-mode-setup)
    :init
    (setq lsp-keymap-prefix "C-c l")  
    :config
    (lsp-enable-which-key-integration t))


<a id="org6aa867b"></a>

### Better LSP UI

    (use-package lsp-ui
    :hook (lsp-ui . lsp-ui-mode))
    ;; :custom (lsp-ui-doc-position 'bottom))


<a id="orgbbcfc7f"></a>

### Treemacs for nice treestructures

    (use-package lsp-treemacs
    :after lsp)


<a id="org4bffad6"></a>

### lsp with ivy integration

    (use-package lsp-ivy)


<a id="org3fdb950"></a>

### TypeSript

TypeScript mode to get lsp-server functioning the [JavaScript/TypeSecript theia-ide](https://emacs-lsp.github.io/lsp-mode/page/lsp-typescript/) from lsp documentation pages. You can install it using npm with following command. 

npm i -g typescript-language-server; npm i -g typescript

    (use-package typescript-mode
    :mode "\\.ts\\'"
    :hook (typescript-mode . lsp-deferred)
    :config
    (setq typescript-indent-level 2))


<a id="orgc991733"></a>

### Bash scripts

    (use-package sh-mode
    :ensure nil
    :hook (sh-mode . lsp-deferred))


<a id="org377cf8b"></a>

## Company

Complete anything is an text completion framework. Used to get better 

    (use-package company
      :after lsp-mode
      :hook (lsp-mode . company-mode)
      :bind (:map company-active-map
    	 ("<tab>" . company-complete-selection))
    	(:map lsp-mode-map
    	 ("<tab>" . company-indent-or-complete-common))
      :custom
      (company-minimum-prefix-length 1)
      (company-idle-delay 0.1))


<a id="org8f56531"></a>

### Company box mode

    ;; (use-package company-box
    ;; ;; :init (setq company-box-backend 'company-lsp)
    ;; :hook (company-mode . company-box-mode)
    ;; :config  (setq company-box-doc t)
    ;; )


<a id="orgabcbe7d"></a>

## Git tools ie magit

    (use-package magit
    ;; :custom 
    ;; (magit-display-buffer-function #'magit-display-same-except-diff-v1)
    )


<a id="org38f0e67"></a>

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


<a id="orga3e7e67"></a>

# Just some random helpfull packages

    (use-package command-log-mode)


<a id="org8d066f1"></a>

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

