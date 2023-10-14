
# Table of Contents

1.  [My  Emacs init file](#org7754a09)
    1.  [Note on requirements](#org275163c)
2.  [A couple of Emacs concepts](#org07cad9f)
    1.  [Buffers & windows](#orgd7a7d57)
        1.  [Point , Mark (PNT MRK) and region](#orgc7c00de)
    2.  [Modes](#org384bfd2)
3.  [Package handling](#orgeca8b66)
4.  [Some basic behaviours configs](#orgeffbaaf)
5.  [Global  keybindings](#orgf2a445d)
    1.  [](#orgc67e05b)
6.  [GLobal variables](#orgd164e48)
7.  [UI](#org670ea2e)
    1.  [Basic UI config](#orge85042c)
    2.  [Themes](#org1dd2ce4)
    3.  [Line numbers](#orgfbdfbd0)
    4.  [Fonts configuration](#org4ea750c)
8.  [Improve shell compability](#org012a349)
9.  [Completion  and tools to simplifying editing and navigation](#org65d258e)
    1.  [Flyspell mode](#org1d8b361)
    2.  [Swiper](#orge537f3c)
    3.  [Ivy](#org5be60a3)
    4.  [Counsel](#orge902140)
    5.  [Which-key](#org48b0ffc)
    6.  [Hydra](#org5565e25)
10. [latex mode](#org546c5c6)
11. [Org-mode](#orgd1cdd70)
    1.  [Org basic](#orgbe9e7a9)
    2.  [Org agenda](#org998467a)
    3.  [Captures](#org41ca70e)
    4.  [org-fragtog](#orgf70c821)
    5.  [Org babel mode](#org053d3ac)
        1.  [Babel languages config](#orga83bb50)
        2.  [Org-structure templates  configs structured templates](#org97482f5)
        3.  [Org-babel  tangle configs](#orgf913802)
12. [Development](#org8ad1737)
    1.  [Common settings for all dev modes](#org6d89e1e)
    2.  [languages](#org70e60da)
        1.  [yasnippets](#orgc75630a)
        2.  [Breadcrumbs in LSP mode](#org69d7636)
        3.  [LSP servers ( Language Server  Protocol)](#org512d895)
        4.  [Better LSP UI](#orge4b3e52)
        5.  [Treemacs for nice treestructures](#org8c0be70)
        6.  [lsp with ivy integration](#org0edd18f)
        7.  [C++](#orgb6a3076)
        8.  [TypeSript](#org313a7fe)
        9.  [python](#org3d32b6a)
        10. [Shell  scripts](#org84b91a2)
        11. [Emacs Lisp mode](#orgd73c895)
    3.  [Company mode](#orgfe05ac3)
    4.  [Projectile](#orgf282728)
13. [Better documentation](#orgc18e28c)
    1.  [The helpful package](#orge678081)
14. [Just some random helpfull packages](#orgcc37e50)
15. [Set by emacs customization](#org81a85d2)



<a id="org7754a09"></a>

# My  Emacs init file

This is just a setup for Emacs.  It's based on David Wilson work done in this  [youtube livestream](https://www.youtube.com/playlist?list=PLEoMzSkcN8oPH1au7H6B7bBJ4ZO7BXjSZ). I've picked the parts i feelt I needed/liked and added and tweaked things to my own taste. You can find Davids full code on i his
[Github repo](https://github.com/daviwil/emacs-from-scratch).


<a id="org275163c"></a>

## Note on requirements

This setup depends on a fonts **Cantarell** and **Fira code retina fonts**. I simply installed the by issuing  following in bash

    sudo apt install fonts-cantarell
    sudo apt install fonts-firacode

I'm also using icons to make things look a bit nicer.  These through Emacs using 
  M-x package-install all-the-icons
  M-x all-the-icons-install-fonts


<a id="org07cad9f"></a>

# A couple of Emacs concepts


<a id="orgd7a7d57"></a>

## Buffers & windows

Buffers are objects containing content of file we are **visiting**, usually the text we want to edit. Buffers are visible through **windows**. You can have several windows open at any time but not all all buffers have to be associated  with a window and hence all buffers might not be visible at current time. The  **current buffer**  is the buffer where your editing commands will have effect. This is not entirely true as there are commands that have effect on other buffers than current buffer,  but  for the main part its true .

So when we want to edit a file  stored on our hardrive an  associated buffer is created for the content of that file.  The buffer is an in memory object  which represents or is  a model of the underlying file. Visually  it is  presented to us on screen through a window.

the buffer itself contains a lot of information such as name of visited file ,wheter the buffer is editable or not 
number of character contained in buffer etc. Two such  pieces of information are the **point** (PNT) and **mark** (MRK).


<a id="orgc7c00de"></a>

### Point , Mark (PNT MRK) and region

**Point and mark** are two integers representing text positions inside buffer. We say that point is **looking at** charcter if point is placed before that character.  A point is hence not on the character but before after or inbetween characters. If the buffer is not empty and we are at point 0 we would be looking at first charcter of buffer. Every buffer has a single. A **mark** also represents a position in the buffer. There can be one or zero marks in a buffer. If there exist a mark then we call the text between position and mark the **region**.
The **cursor** is placed on the character following the point. 


<a id="org384bfd2"></a>

## Modes

Modes (editing modes) in emacs are used to alters how emacs behaves in some useful ways.Modes are categorized as being either major or minor. **Major mode** provides means for working with particular file type (.org, .c .pdf etc) or buffers of none-file type (shell etc). Each buffer allways uses a single major mode at any time. **Minor modes** are independent modes that associates some additional behaviour (suger) to file or buffer type. By independt we mean that they are not dependent on other modes neither major or minor ones and as such can be used independently of other modes. Minor modes can be turned on and off as we you wish you can have any number of minor modes in use for each buffer. Examples of minor modes are show-paren-mode, display-line-number-mode and cwarn-mode.

Modes are just code that adhere to a set of  conventions see links

-   [Systemcrafters tutorial on minor modes](https://systemcrafters.cc/learning-emacs-lisp/creating-minor-modes)
-   [Gnu Emacs manual pages on  minor modes conventions](https://www.gnu.org/software/emacs/manual/html_node/elisp/Minor-Mode-Conventions.html)
-   [Gnu Emacs manual pages on major mode conventions](https://www.gnu.org/software/emacs/manual/html_node/elisp/Major-Mode-Conventions.html)

keymap is a table that records the bindings between characters and command functions


<a id="orgeca8b66"></a>

# Package handling

In this setup use-package is used to simplify configuration and loading of packages. Usepackage introduces tidy syntax and isolate package loading in a performant way.

  We set a few package repositories, load and activate packages from package-load-list  `(package-initialize)`. Check if archive list (list of packateges) are cached if not we download list. The use-package comes preinstalled with emacs on most system but not necesarilly on windows so we check we can find this package and install it unless is has not yet been installed.
We require use-package `(require 'package).`  The require function loads feature (in this case 'package) only if it hasn't yet been loaded. Finally we set `:ensure t` as defualt for all package `(setq use-package-always-ensure t)`. This will cause packages to be downloaded and installed automatically unless they are already installed. For more on use-package see

TODO ensure only use secure chanels for packages 

[Use package github page](https://github.com/jwiegley/use-package)

     ;; Initialize package sources
     (require 'package)
    
    ;; Note org elpa will close before 9.6 use org gnu instead.
    (setq package-archives '(("melpa" ."https://melpa.org/packages/")
                             ;; seems this repo is closing
                             ;;("org" . "https://elpa.gnu.org/packages/")
                             ("nongnu". "https://elpa.nongnu.org/nongnu/")
                             ("elpa" . "https://elpa.gnu.org/packages/")))
    
     (package-initialize)
    
     (unless package-archive-contents
      (package-refresh-contents)) 
     ;; Initialize use-package on non-Linux platforms
     (unless (package-installed-p 'use-package)
        (package-install 'use-package))
    
     (require 'use-package)
     (setq use-package-always-ensure t)


<a id="orgeffbaaf"></a>

# Some basic behaviours configs

Turn on word wrappping on long lines using .Visual line mode turns on  word wrapping per buffer. It redefines some editing commands to work on visual lines rather than on logical lines.

    (global-visual-line-mode  1)

Documentation pages suggests to setting scroll conservatively to high value rather than setting scroll-step to 1 if you want to scroll only single line at the time.

    (setq scroll-conservatively 99)

Add some of my own editing commands like duplicate line.

    (use-package jv-basic-edit
      :config (jv-basic-edit-mode 1))


<a id="orgf2a445d"></a>

# Global  keybindings

Just a few global keybindings


<a id="orgc67e05b"></a>

## 

    ;; get to agen faster
    (global-set-key (kbd "C-c a") 'org-agenda)
    (global-set-key (kbd "C-c c") 'org-capture)
         ;; Make ESC quit prompts
         (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
         ;; Using keyboard macros to define thes for now. These will effect the
         ;; kill ring as well as point and mark
        ;;  (global-set-key (kbd" M-S-<down>") 'duplicate-line-down)
        ;;  (fset 'duplicate-line-down
        ;;        (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w return ?\C-a ?\C-y] 0 "%d"))
        ;; 
        ;;  (global-set-key (kbd" M-S-<up>") 'duplicate-line-up )
        ;;  (fset 'duplicate-line-up 
        ;;        (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w up return ?\C-a ?\C-y ?\C-a] 0 "%d"))
    
        ;; (global-set-key (kbd"M-<up>")  'swapline-up)
        ;; (fset 'swapline-up
        ;;       (kmacro-lambda-form [?\C-a ?\C-k backspace ?\C-a return up ?\C-y ?\C-a tab] 0 "%d"))
        ;;
        ;; (global-set-key (kbd "M-<down>")'swapline-down)
        ;; (fset 'swapline-down
        ;;       (kmacro-lambda-form [?\C-a ?\C-k down ?\C-e return ?\C-y up up ?\C-a ?\C-k down] 0 "%d"))
        ;;
        ;; (global-set-key (kbd" C-<return>") 'open-newline)
        ;; (fset 'open-newline
        ;;       (kmacro-lambda-form [?\C-e return tab] 0 "%d"))

Currently set environment variable named **EMACS<sub>INIT</sub><sub>FILE</sub>** to point to my emacs.org file (this file). If this file is not set we get default **init.el** file (Admittedly not ideal solution but works for now ). This file (emacs.org) is **tangled**  upon save to **./init.el**. Inside ~/emacs.d we create a soft link  to actual init.el file **ln -s ~/location/of/init.el init.el**  

If you start your emacs from shell you can simple set an environment variable  for instance in your local **.profile** file like so `export EMACS_INIT_FILE=path/to/emacs.org`. Most often i don't start emacs from shell so  instead i created a new  folder `~/.config/environment.d`. Inside that folder i create a new file with extension `.conf`
 for instance `my.conf`.  This file set a variable as so  `EMACS_INIT_FILE=path/to/emacs.org`.

    (global-set-key (kbd "<f12>")
                    (lambda () 
                      (interactive)
                      (let ((init-file-location (or (getenv "EMACS_INIT_FILE")
                                                   "~/.emacs.d/init.el")))
                        (find-file init-file-location)
                                             )))


<a id="orgd164e48"></a>

# GLobal variables

    (defcustom jv-agenda-directory "~/Documents/tasks" 
    "Base directory of my agenda files"
    :type 'string
    :options '("~/Documents/org-files" ))


<a id="org670ea2e"></a>

# UI


<a id="orge85042c"></a>

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


<a id="org1dd2ce4"></a>

## Themes

Doom are comunity inspired themes for emacs. It contains a large varietty of themes. This setup also uses icons in for instance modelines. I used `package-install all-the-icons` followed by  `M-x all-the-icons-install-fonts`  To pull down and install needed fonts manually for this to work.

`:init` keyword will make code run before package is loaded. We use thall-the-icons to get some nice icons and the tweak the mode-line. `:ensure t` isn't stricly needed as we set this as default for all packages. The `:custom`  keyword is used here to set custom variables of doom-modeline packages.

[Doom-themes github page](https://github.com/doomemacs/themes)

    (require 'all-the-icons)
                 (use-package doom-themes
                   :init (load-theme 'doom-horizon t))
                 ;;use refresh-pakcages to get this working
         ;; M-x all-the-icons-install-fonts
                 (use-package all-the-icons
                   :if (display-graphic-p)
                   )
                 (use-package doom-modeline
                   :ensure t
                   :init (doom-modeline-mode 1)
                   :custom ((doom-modeline-height 15)))


<a id="orgfbdfbd0"></a>

## Line numbers

   Most often i don't need to number per line. if i need to know line number i can see it mode-line.
   I use `M-g g` to get to specific line instead of arrows. I do want to se columnnumber in mode line.
   The rest of the code only serve as an example of how we how we could set some value for several modes.
So for instance if  we use global line number the coude would ensure that certain modes still didn't  show line numbers  by adding  hook to each mode  in  list.

    
    
    (column-number-mode)
    
    ;; (global-display-line-numbers-mode t)
    (dolist (mode'(org-mode-hook
                   term-mode-hook
                   shell-mode-hook
                   eshell-mode-hook))
      (add-hook mode (lambda() (display-line-numbers-mode 0))))


<a id="org4ea750c"></a>

## Fonts configuration

Here i use fira code font they can be installed on ubuntu by isuing `sudo apt install fonts-firacode` command. I also use the cantarell fonts which in similar fashion can be installed as so sudo `apt install fonts-cantarell`

    (set-face-attribute 'default nil :font "Fira Code Retina" :height 170)
    
    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 210)
    
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 210 :weight 'regular)


<a id="org012a349"></a>

# Improve shell compability

Shell in Emacs sometimes appears to behave differently from your native shell. This can sometimes be because  Emacs (especially GUI version in windows and OS x) only imports minimal set of environment variables. Following will fix this problem.

    (use-package exec-path-from-shell
      :ensure t
      :config
      (when (or (daemonp) (memq window-system '(ns x)))
        (exec-path-from-shell-initialize)))

`memq` tests if object is member of list and returns a list starting with that member and the rest of  the list. so `(memq 'b '(a b c d))`  returns `'(bcd)`.


<a id="org65d258e"></a>

# Completion  and tools to simplifying editing and navigation


<a id="org1d8b361"></a>

## Flyspell mode

    (add-hook 'flyspell-mode-hook (lambda () (local-set-key (kbd "C-.") #'flyspell-correct-word-before-point )))


<a id="orge537f3c"></a>

## Swiper

[swiper elpa](https://elpa.gnu.org/packages/swiper.html)
[swiper on github](https://github.com/abo-abo/swiper/tree/c97ea72285f2428ed61b519269274d27f2b695f9)

An UI on top of ISearch (Incremental Search). Swiper gives an overview of the current regex search candidates. Matches are presented in an intuitive fashion and you can jump to location of selected match  (in buffer search) presented in minibuffer

    (use-package swiper
         :ensure t)


<a id="org5be60a3"></a>

## Ivy

Ivy minor mode is a generic completion mechanism for Emacs. Ivy-mode ensures completing-read-function uses ivy for completion. Used for instance when finding files.

[Ivy on github](https://github.com/abo-abo/swiper) 

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


<a id="orge902140"></a>

## Counsel

[Counsel on github](https://github.com/abo-abo/swiper/tree/c97ea72285f2428ed61b519269274d27f2b695f9#counsel)

Counsel is defined as minor mode.ivy-mode ensures that any Emacs command using completing-read-function uses ivy for completion.
Counsel takes this further, providing versions of common Emacs commands that are customised to make the best use of Ivy. For example, counsel-find-file has some additional keybindings. Pressing DEL will move you to the parent directory.

Enabling counsel-mode remaps built-in Emacs functions that have counsel replacements:

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


<a id="org48b0ffc"></a>

## Which-key

Emacs minor mode that displays popup with possible keybindings on prefix commands such C-c C-x M-x. I this config I popup will ony show after beeing idle for at leas 1 second.  

    ;;cln/command-log-buffer
    ;;If package is not found try to refresh M-x package-list-packages
    (use-package which-key
      :init (which-key-mode)
      :diminish which-key-mode
      :config
      (setq which-key-idle-delay 1))


<a id="org5565e25"></a>

## Hydra

Lets you do repetive commands in convienient manner. 
[Hydra package on github](https://github.com/abo-abo/hydra)

    (use-package hydra)
    
    
    (defhydra hydra-text-scale(:timeout 4)
      "scale text"
      ("j" text-scale-increase "in")
      ("k" text-scale-decrease "out")
      ("f" nil "finnished" :exit t))


<a id="org546c5c6"></a>

# latex mode

    
    (use-package  tex
        :ensure auctex
        :hook (LaTeX-mode .  (lambda ()
                               (setq TeX-auto-save t)
                               (set TeX-parse-self t)
                               (set-default TeX-master nil)))
        :config
        (setq TeX-PDF-mode t)
        (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
        (setq TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))))
    
      (use-package pdf-tools
        :config
    (pdf-tools-install)
    (setq pdf-view-use-scaling t)
    (setq pdf-view-use-imagemagick nil)
    (setq pdf-view-resize-factor 1.1))
      ;; keybindings   
      (use-package latex
        :ensure auctex
        :bind (:map LaTeX-mode-map
                    ("C-c C-c". TeX-command-run-all)))
    
    ;; syntax highlight 
    (add-hook 'LaTeX-mode-hook 'turn-on-font-lock)


<a id="orgd1cdd70"></a>

# Org-mode

[org-mode-pages](https://orgmode.org/)
desribes org-mode as a major mode for keeping notes, authoring documents, computational notebooks, literate programming, maintaining to-do lists, planning projects, and more.
it's a realy versatile mode that does a lot of things. For instance this init-file has been written in org-mode using litterate programming. 


<a id="orgbe9e7a9"></a>

## Org basic

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
      (flyspell-mode 1)
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

    ;;(add-hook 'org-mode-hook #'turn-on-org-cdlatex)


<a id="org998467a"></a>

## Org agenda

For agenda to work we need to tell which file to track in our agenda  using `org-agenda-files.` Agenda doesn't output log when for instance when mark things as finnished or done by default `org-agenda-start-with-log-mode`  starts agenda with logging turned on. The `org-log-done` is used to tell what to log when we mark task as DONE. The org-log-drawer is at least suppose allow for us to fold away those notes so that they are not visibla all the the time but can be accessed through a "drawer".  Here i use backquote constructs to evaluate elements see [Backquote evaluate list elements](https://www.gnu.org/software/emacs/manual/html_node/elisp/Backquote.html). If we just create the list of function calls to expand-filename they want be evaluated and org-agende will throw wrong type error. Could probably us cons to create the list but this feels tidier  to me.

    (setq org-agenda-files 
          `( , (expand-file-name "Projects.org" jv-agenda-directory)
               , (expand-file-name "Learning.org" jv-agenda-directory)
               , (expand-file-name "Archives.org" jv-agenda-directory)
               , (expand-file-name "Current-project.org" jv-agenda-directory)
               , (expand-file-name "Todos.org" jv-agenda-directory)))
    
    (setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer t)

We can add our own keyword and workflow to our own taste using `org-todo-keywords`. These can be set inside org files per file as well.

      (setq org-todo-keywords  
            '((sequence  "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence  "BACKLOG(b)" "NEXT(n)" "ACTIVE(a)" "|" "DONE(d)")))
    
    ;; (setq org-todo-keyword-faces
    ;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
    ;;         ("CANCELED" . (:foreground "blue" :weight bold))))

At some point the task list might we swamped with finnished tasks. We can stash these away in a seperate file. This can be done with org-refile command. Below we set the allowed targets.   `Advice-add`
line makes sure things get saved after refiling. Use keybord shortcut `C-c C-w`.

    (setq org-refile-targets
      '(("Archives.org" :maxlevel . 1)
        ("Tasks.org" :maxlevel . 1)))
    ;; Save Org buffers after refiling!
    (advice-add 'org-refile :after 'org-save-all-org-buffers)

We can add tags to task   and here are some custom tags NEED TO LOOK OVER TAGS I WANT USE.
TODO think through which tags i want to use

    (setq org-tag-alist
        '((:startgroup)
           ; Put mutually exclusive tags here
           (:endgroup)
           ("@errand" . ?E)
           ("@home" . ?H)
           ("@work" . ?W)
           ("agenda" . ?a)
           ("planning" . ?p)
           ("publish" . ?P)
           ("batch" . ?b)
           ("note" . ?n)
           ("idea" . ?i)))

Customization of the agenda views 

    ;; Configure custom agenda views
    (setq org-agenda-custom-commands
    
     '(("g" "GTD view" 
        ((agenda "")
         (todo "NEXT" ((org-agenda-overriding-header "Next action:")))
         (todo "WAITING" ((org-agenda-overriding-header "Waiting on:")))
         (todo "DONE" ((org-agenda-overriding-header "Completed items:")))
         (tags "Project" ((org-agenda-overriding-header "Projects in progress:")))))
    
         ("d" "Dashboard" ((agenda "" ((org-deadline-warning-days 7)))
        (todo "NEXT"((org-agenda-overriding-header "Next Tasks")))
        (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
         ("n" "Next Tasks"
       ((todo "NEXT"((org-agenda-overriding-header "Next Tasks")))))
      ("W" "Work Tasks" tags-todo "+work-email")
      ;; Low-effort next actions
      ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
       ((org-agenda-overriding-header "Low Effort Tasks")
        (org-agenda-max-todos 20)
        (org-agenda-files org-agenda-files)))
    
      ("w" "Workflow Status"
       ((todo "WAIT"
              ((org-agenda-overriding-header "Waiting on External")
               (org-agenda-files org-agenda-files)))
        (todo "REVIEW"
              ((org-agenda-overriding-header "In Review")
               (org-agenda-files org-agenda-files)))
        (todo "PLAN"
              ((org-agenda-overriding-header "In Planning")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "BACKLOG"
              ((org-agenda-overriding-header "Project Backlog")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "READY"
              ((org-agenda-overriding-header "Ready for Work")
               (org-agenda-files org-agenda-files)))
        (todo "ACTIVE"
              ((org-agenda-overriding-header "Active Projects")
               (org-agenda-files org-agenda-files)))
        (todo "COMPLETED"
              ((org-agenda-overriding-header "Completed Projects")
               (org-agenda-files org-agenda-files)))
        (todo "CANC"
              ((org-agenda-overriding-header "Cancelled Projects")
               (org-agenda-files org-agenda-files)))))))


<a id="org41ca70e"></a>

## Captures

Will use this to scribble down ideas that pop up and disturb workflow. It will stash them away into task file under a separate heading 

        (setq org-capture-templates
          `(("t" "Tasks / Projects")
            ("tt" "Task" entry (file+olp
                                ,(expand-file-name "Tasks.org" jv-agenda-directory) "Inbox")
                 "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
    
            ("j" "Journal Entries")
            ("jj" "Journal" entry
                 (file+olp+datetree 
                  ,(expand-file-name "Journal.org"  jv-agenda-directory))
                 "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
                 ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
                 :clock-in :clock-resume
                 :empty-lines 1)
            ("jm" "Meeting" entry
                 (file+olp+datetree ,(expand-file-name "Journal.org"  jv-agenda-directory))
                 "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
                 :clock-in :clock-resume
                 :empty-lines 1)
    
            ("w" "Workflows")
            ("we" "Checking Email" entry (file+olp+datetree 
    ,(expand-file-name "Journal.org"  jv-agenda-directory))
                 "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)
    
            ("m" "Metrics Capture")
            ("mw" "Weight" table-line (file+headline ,(expand-file-name "Metrics.org"  jv-agenda-directory)
     "Weight")
             "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t))) 
    
                (define-key global-map (kbd "C-c j")
                  (lambda () (interactive) (org-capture nil "jj")))


<a id="orgf70c821"></a>

## org-fragtog

Renders LaTex math expressions in my org files. This  depends on **dvisvgm** package which needs to be installed separately  *sudo apt install dvisvgm*

    ;;  (setq org-fragtog-backend 'imagemagick)
    
      (use-package org-fragtog
       :hook (org-mode . org-fragtog-mode)
       :config
      (setq org-format-latex-options
          (plist-put org-format-latex-options :scale 2.0)))


<a id="org053d3ac"></a>

## Org babel mode

Babel adds ability to execute source code within org documents. Babel allows for data to be passed accross different parts of document independently of source languages and applications. For instance we could have a python block outputting some data as input to c block which later could be passed through GnuPlot block and to finally be embedded in document as plot. Using org babel mode we can use org for literal programming. Babel can reprocess document and write source code to seperate file  (tangled in literate programming jargon).  


<a id="orga83bb50"></a>

### Babel languages config

    (org-babel-do-load-languages
    'org-babel-do-load-languages '(
    (emacs-lisp . t)
    (java . t)
    (javascript. t)
    (python . t)))


<a id="org97482f5"></a>

### Org-structure templates  configs [structured templates](https://orgmode.org/worg/org-contrib/babel/languages/)

          (require 'org-tempo)
          (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
          (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
          (add-to-list 'org-structure-template-alist '("py" . "src python"))
          ( add-to-list 'org-structure-template-alist ' ("java"."src java"))
    ( add-to-list 'org-structure-template-alist ' ("javascript"."src javascript"))
          (add-to-list 'org-structure-template-alist '("xml" . "src xml"))


<a id="orgf913802"></a>

### Org-babel  tangle configs

        ;;auto-tangle files to target on save
    (defun efs/org-babel-tangle-config ()
      (when (string-equal (buffer-file-name)
    (expand-file-name "emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))
    
    (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))


<a id="org8ad1737"></a>

# Development

This is separate  section on development modes and tools.


<a id="org6d89e1e"></a>

## Common settings for all dev modes

rainbow delimiters helps you keep track of matching parantesis etc.

    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))

Auto match pairs of things such as parentecis with `electric-pair-mode` and light up matching parentices with `show-paren-mode`.

    (use-package prog-mode
      :ensure nil
      :init (show-paren-mode  t)
      (electric-pair-mode 1  ))


<a id="org70e60da"></a>

## languages


<a id="orgc75630a"></a>

### yasnippets

Is a minor mode providing template system. It features abbreviations that can be expanded automatically into function templates. You can define your own templates and/or use prexisting ones.

    (use-package yasnippet
     :init
     (setq lsp-completion-provider :none) 
    :config
     (setq yas-snippets-dirs '("~/programering/settings/emacs2021/snippets"))
     (yas-global-mode 1))    

`yasnippet-snippets` is a set of predefined snippets for a lot of languages.

    (use-package yasnippet-snippets)


<a id="org69d7636"></a>

### Breadcrumbs in LSP mode

    (defun  efs/lsp-mode-setup ()
      ;; (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file ;; symbols))
    (lsp-headerline-breadcrumb-mode 1))


<a id="org512d895"></a>

### LSP servers ( Language Server  Protocol)

LSP is an effort made by VSCode team to standardize the protocol for language servers.The idea is to have single standardize server protocol between language server and dev-tool. In such an scenario we can reuse language server accross different devtools with minimal effort which is good news for both language providers and tooling vendors. Information about LSP support can be found at [Emacs LSP-mode language support pages](https://emacs-lsp.github.io/lsp-mode/). 

LSP-mode for emacs aims to provide a more IDE like experience to emacs. Normally you are required to seperatly install a language server for each language. Again the link above will provide needed information on specific language support. 

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


<a id="orge4b3e52"></a>

### Better LSP UI

    (use-package lsp-ui
      :hook (lsp-ui . lsp-ui-mode)
      :config
      (setq lsp-ui-doc-enable nil)
      (setq lsp-ui-doc-header t)
      (setq lsp-ui-doc-include-signature t)
      :custom (lsp-ui-doc-position  'bottom))


<a id="org8c0be70"></a>

### Treemacs for nice treestructures

    (use-package lsp-treemacs
    :after lsp)


<a id="org0edd18f"></a>

### lsp with ivy integration

    (use-package lsp-ivy)


<a id="orgb6a3076"></a>

### C++

Tree-sitter is  a dynamic source code parser for editors. This provides the means for more accurate syntax highlighting and more complex functions like refactoring support and more. Emacs 29 comes with lib but we need grammar definitions for each language we want to use it for.  

    (setq treesit-language-source-alist
        '((cpp  "https://github.com/tree-sitter/tree-sitter-cpp")
        (c  "https://github.com/tree-sitter/tree-sitter-c")))
    
    (dolist (lang treesit-language-source-alist)
      (unless (treesit-language-available-p (car lang))
      (treesit-install-language-grammar (car lang))))
    
    ;;treesitter mode for c++ is the c++-ts-mode lets remap c++ to this name
    (setq treesit-load-name-override-list
          '((c++ "libtree-sitter-cpp")))
    
    ;; Lets use tree-sitter  as default mode for c++
    (add-to-list 'major-mode-remap-alist '(c-mode. c-ts-mode))
    (add-to-list 'major-mode-remap-alist '(c++-mode. c++-ts-mode))
    (add-to-list 'major-mode-remap-alist '(c-or-c++-mode. c-or-c++-ts-mode))


<a id="org313a7fe"></a>

### TypeSript

TypeScript mode to get lsp-server functioning the [JavaScript/TypeSecript theia-ide](https://emacs-lsp.github.io/lsp-mode/page/lsp-typescript/) from lsp documentation pages. You can install it using npm with following command. 

npm i -g typescript-language-server; npm i -g typescript

    (use-package typescript-mode
    :mode "\\.ts\\'"
    :hook (typescript-mode . lsp-deferred)
    :config
    (setq typescript-indent-level 2))


<a id="org3d32b6a"></a>

### python

(require 'cl)

    (use-package dap-mode
      ;; Uncomment the config below if you want all UI panes to be hidden by default!
      ;; :custom
      ;; (lsp-enable-dap-auto-configure nil)
      ;; :config
      ;; (dap-ui-mode 1)
      :commands dap-debug
      :config
      ;; Set up Node debugging
      (require 'dap-node)
      (dap-node-setup)) ;; Automatically installs Node debug adapter if needed
    
      ;; Bind `C-c l d` to `dap-hydra` for easy access
      ;; general-define-key
      ;;  :keymaps 'lsp-mode-map
      ;;  :prefix lsp-keymap-prefix
      ;;  "d" '(dap-hydra t :wk "debugger")))

`pip install --user "python-language-server[all]"`

    (use-package python-mode
      :ensure t
      :hook (python-mode . lsp-deferred)
      :custom
      ;; NOTE: Set these if Python 3 is called "python3" on your system!
      (python-shell-interpreter "python3")
       (dap-python-executable "python3")
      (dap-python-debugger 'debugpy)
      :config
      (require 'dap-python))

    (use-package pyvenv
      :after python-mode
      :config
      (pyvenv-mode 1))


<a id="org84b91a2"></a>

### Shell  scripts

Use `npm i -g bash-language-server` to install bash language server.

    (use-package sh-mode
      :mode "\\.sh\\'"
      :ensure nil
      :hook (sh-mode . lsp-deferred))


<a id="orgd73c895"></a>

### Emacs Lisp mode

(setq company-global-modes nil)

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
      :custom  (company-backends    '(( company-yasnippet :separate company-capf company-dabbrev-code ))))
                                              ;;  ( emacs-lisp-mode . jv/setup-emacs-lisp-mode) )


<a id="orgfe05ac3"></a>

## Company mode

Is a built in mode hence ensure nil.
[Company backends documentation](http://company-mode.github.io/manual/Backends.html#Backends-Usage-Basics) 

    (use-package company
      :after lsp-mode
      :hook (lsp-mode . company-mode)
      ;;:init
      ;;(setq company-format-margin-function  #'company-vscode-dark-icons-margin) 
      :bind (:map company-active-map
             ("<tab>" . company-complete-selection))
            (:map lsp-mode-map
             ("<tab>" . company-indent-or-complete-common))
            :config (setq    company-show-quick-access t)
            :custom
           ( company-format-margin-function  #'company-vscode-dark-icons-margin)
              (company-require-match 'never)
              (company-tooltip-align-annotations t)
            (company-minimum-prefix-length 1)
            (company-idle-delay 0.1))

    (use-package company-quickhelp
      :hook (company-mode . company-quickhelp-mode))


<a id="orgf282728"></a>

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


<a id="orgc18e28c"></a>

# Better documentation


<a id="orge678081"></a>

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


<a id="orgcc37e50"></a>

# Just some random helpfull packages

    (use-package command-log-mode)


<a id="org81a85d2"></a>

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

