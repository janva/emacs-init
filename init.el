;; Silence compiler warnings as they can be pretty disruptive
(setq comp-async-report-warnings-errors nil)

;; seems to start daemon by default so no need?
;; (server-start)

;; Initialize package sources
;;          (require 'package)
;; 
;;         ;; Note org elpa will close before 9.6 use org gnu instead.
;;         (setq package-archives '(("melpa" ."https://melpa.org/packages/")
;;                                  ;; seems this repo is closing
;;                                  ;;("org" . "https://elpa.gnu.org/packages/")
;;                                  ("nongnu". "https://elpa.nongnu.org/nongnu/")
;;                                  ("elpa" . "https://elpa.gnu.org/packages/")))
;; 
;;          (package-initialize)
;; 
;;          (unless package-archive-contents
;;           (package-refresh-contents)) 
;; 
      ;; Initialize use-package on non-Linux platforms
      ;;       (unless (package-installed-p 'use-package)
      ;;          (package-install 'use-package))
      ;;
      ;;       (require 'use-package)
      ;;       (setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(require 'straight-x)

(global-visual-line-mode  1)

(setq scroll-conservatively 99)

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

(global-set-key (kbd "<f12>")
                (lambda () 
                  (interactive)
                  (let ((init-file-location (or (getenv "EMACS_INIT_FILE")
                                               "~/.emacs.d/init.el")))
                    (find-file init-file-location)
                                         )))

(defcustom jv-agenda-directory "~/Documents/tasks" 
"Base directory of my agenda files"
:type 'string
:options '("~/Documents/org-files" ))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)         
(tooltip-mode -1)          
(set-fringe-mode 10)       

(menu-bar-mode -1)         

;; Set up the visible bell
(setq visible-bell t)

;; (use-package all-the-icons
;;   :straight t
;;   :if (display-graphic-p))

(use-package nerd-icons
  :straight t)


 (use-package doom-themes
   :init (load-theme 'doom-horizon t))
 ;;use refresh-pakcages to get this working
 ;; M-x all-the-icons-install-fonts
 (use-package doom-modeline
   :straight t
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

(use-package exec-path-from-shell
  :straight t
  :config
  (when (or (daemonp) (memq window-system '(ns x)))
    (exec-path-from-shell-initialize)))

(add-hook 'flyspell-mode-hook (lambda () (local-set-key (kbd "C-.") #'flyspell-correct-word-before-point )))

(use-package swiper
     :straight t)

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

;;cln/command-log-buffer
;;If package is not found try to refresh M-x package-list-packages
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package hydra)


(defhydra hydra-text-scale(:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finnished" :exit t))

(use-package  tex
    :straight auctex
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
    :straight auctex
    :bind (:map LaTeX-mode-map
		  ("C-c C-c". TeX-command-run-all)))

;; syntax highlight 
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)

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
;;	(set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
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

(setq org-agenda-files 
      `( , (expand-file-name "Projects.org" jv-agenda-directory)
           , (expand-file-name "Learning.org" jv-agenda-directory)
           , (expand-file-name "Archives.org" jv-agenda-directory)
           , (expand-file-name "Current-project.org" jv-agenda-directory)
           , (expand-file-name "Todos.org" jv-agenda-directory)))

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

(setq org-todo-keywords  
        '((sequence  "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence  "BACKLOG(b)" "NEXT(n)" "ACTIVE(a)" "|" "DONE(d)")))
          
;; (setq org-todo-keyword-faces
;;       '(("TODO" . org-warning) ("STARTED" . "yellow")
;;         ("CANCELED" . (:foreground "blue" :weight bold))))

(setq org-refile-targets
  '(("Archives.org" :maxlevel . 1)
    ("Tasks.org" :maxlevel . 1)))
;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

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

;;  (setq org-fragtog-backend 'imagemagick)

  (use-package org-fragtog
   :hook (org-mode . org-fragtog-mode)
   :config
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 2.0)))

(org-babel-do-load-languages
'org-babel-load-languages '(
(emacs-lisp . t)
(java . t)
(shell . t)
(javascript. t)
(python . t)))

(require 'org-tempo)
      (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
      (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
      (add-to-list 'org-structure-template-alist '("py" . "src python"))
      ( add-to-list 'org-structure-template-alist ' ("java"."src java"))
( add-to-list 'org-structure-template-alist ' ("javascript"."src javascript"))
      (add-to-list 'org-structure-template-alist '("xml" . "src xml"))

;;auto-tangle files to target on save
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
(expand-file-name "emacs.org"))
;; Dynamic scoping to the rescue
(let ((org-confirm-babel-evaluate nil))
  (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Your Name\n"
  "#+email: your-email@server.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *Javascript* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
 )
(global-set-key [C-S-f4] 'org-skeleton)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package prog-mode
  :straight nil
  ;; :hook (prog-mode . lsp-deffered)
  :init (show-paren-mode  t)
  (electric-pair-mode 1  ))

(use-package yasnippet
 :init
 (setq lsp-completion-provider :none) 
:config
 (setq yas-snippets-dirs '("~/programering/settings/emacs2021/snippets"))
 (yas-global-mode 1))

(use-package yasnippet-snippets)

(defun  efs/lsp-mode-setup ()
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
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  :custom (lsp-ui-doc-position  'bottom))

(use-package lsp-treemacs
:after lsp)

(use-package lsp-ivy)

(use-package treesit
      :straight (:type built-in)
      :if  (featurep 'treesit)
      :config
      (setq treesit-language-source-alist      
     '((cpp  "https://github.com/tree-sitter/tree-sitter-cpp")
       (c  "https://github.com/tree-sitter/tree-sitter-c")
       (java "https://github.com/tree-sitter/tree-sitter-java")
       (bash "https://github.com/tree-sitter/tree-sitter-bash")
       (cmake "https://github.com/uyha/tree-sitter-cmake")
       (css "https://github.com/tree-sitter/tree-sitter-css")
       (elisp "https://github.com/Wilfred/tree-sitter-elisp")
       (go "https://github.com/tree-sitter/tree-sitter-go")
       (html "https://github.com/tree-sitter/tree-sitter-html")
       (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
       (json "https://github.com/tree-sitter/tree-sitter-json")
       (make "https://github.com/alemuller/tree-sitter-make")
       (markdown "https://github.com/ikatyang/tree-sitter-markdown")
       (python "https://github.com/tree-sitter/tree-sitter-python")
       (toml "https://github.com/tree-sitter/tree-sitter-toml")
       (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
       (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
       (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
      (setq treesit-font-lock-level 4)
     ;;  (setq treesit-extra-load-path '("/home/janne/.emacs.d/tree-sitter"))
;;(setq languages (mapcar #'car treesit-language-source-alist))
;;
;;(setq not-yet-installed (seq-filter(lambda (lang)
;;    (not (treesit-language-available-p lang)))languages))
;;
;;(setq not-yet-installed (mapcar (lambda (lang)
;;   (if  (not (treesit-language-available-p lang))
;;         lang))languages))
      
      (mapc (lambda (lang)
  	      (if (not (treesit-language-available-p lang))
  		  (treesit-install-language-grammar lang)))
  	    (mapcar #'car treesit-language-source-alist))

      ;; worst cas scenario just run below line
      ;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
            ;; currently only c c++ add to list maybe iterate over list again
      ;; note should be list of three elements each
      (setq treesit-load-name-override-list 
            '(;;(c "libtree-sitter-c")
	      (c++ "libtree-sitter-cpp")))
	
    ;; Lets use tree-sitter  as default mode for c++
      (setq major-mode-remap-alist
  	    '( (typescript-mode . typescript-ts-mode)
  	       (js-mode . javascript-ts-mode)
  	       (python-mode . python-ts-mode)
  	       (json-mode . json-ts-mode)))
   

      (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
       (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
      (add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode)))

(use-package cmake-mode
  :straight t
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :hook (cmake-mode . lsp-deferred))

(use-package cmake-font-lock
  :straight t
  :after cmake-mode
  :config (cmake-font-lock-activate))

(use-package c++-mode 
:straight nil
:mode "\\.cpp\\'" "\\.cc\\'" "\\.h\\'"
:hook (c++-mode . lsp-deferred))

(use-package lsp-java
  :straight t
  :after (lsp)
  :config
  (setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz"))

(add-hook 'java-mode-hook #'smartparens-mode)
;; (add-hook 'java-mode-hook #'hs-minor-mode)
;; (my/set-smartparens-indent 'java-mode)

(use-package emmet-mode
  :straight t)

(use-package web-mode
  :straight t)
(add-to-list 'auto-mode-alist  ' ("\\.html\\ $'" . web-mode ))
(add-to-list 'auto-mode-alist  ' ("\\.css?\\ $'" . web-mode ))
(add-to-list 'auto-mode-alist  ' ("\\.js\\ $'" . web-mode ))
(add-hook 'web-mode-hook 'emmet-mode)

(use-package typescript-mode
:mode "\\.ts\\'"
:hook (typescript-mode . lsp-deferred)
:config
(setq typescript-indent-level 2))

(use-package dap-mode
    ;; Uncomment the config below if you want all UI panes to be hidden by default!
    ;; :custom
    ;; (lsp-enable-dap-auto-configure nil)
    ;; :config
    ;; (dap-ui-mode 1)
    ;;:commands dap-debug
    :config (dap-auto-configure-mode)
    :bind(("<f7>" .  dap-step-in)
  	("<f8>" . dap-next)
  	("<f9>" . dap-continue)))

(require 'dap-firefox)
(setq dap-firefox-debug-program '("node" "/home/janva/.emacs.d/.extension/vscode/firefox-devtools.vscode-firefox-debug-2.9.10/extension/dist/adapter.bundle.js"))
    
    ;; Set up Node debugging
    ;;(require 'dap-node)
    ;;(dap-node-setup)) ;; utomatically installs Node debug adapter if needed

    ;; Bind `C-c l d` to `dap-hydra` for easy access
    ;; general-define-key
    ;;  :keymaps 'lsp-mode-map
    ;;  :prefix lsp-keymap-prefix
    ;;  "d" '(dap-hydra t :wk "debugger")

(use-package python-mode
  :straight t 
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

(use-package sh-mode
  :mode "\\.sh\\'"
  :straight nil
  :hook (sh-mode . lsp-deferred))

(defun   jv/setup-emacs-lisp-mode()
   (message "running my hook")
;;     (push '(company-elisp :with company-yasnippet)  company-backends)
          (setq-local  company-backends '((company-elisp :with company-yasnippet))))

(setq company-global-modes nil)
    
 ;;(use-package lisp
 ;;    :straight (:type built-in))
;;     :hook (after-save . check-parens))
;; annoying checks inside comments as well
;;  (add-hook 'after-save #'check-parens)
      (use-package elisp-mode
        :straight (:type built-in)
        :hook (elisp-mode .company-mode
      		    'emacs-lisp-mode-hook .'jv/setup-emacs-lisp-mode))

;; TODO hmm would like to make a seperation as well that is use :separate

   ;;  (use-package emacs-lisp
   ;;   :straight (:type built-in) 
   ;;   :commands emacs-lisp-mode
   ;;   :mode  "\\.el\\'"
   ;;   :hook (emacs-lisp-mode . company-mode)
   ;;   ;;company-elisp is obsolete?
   ;;   ;; could just use push instead?
   ;;   :custom  (company-backends    '(( company-yasnippet :separate company-capf company-dabbrev-code ))))
                                             ;;  ( emacs-lisp-mode . jv/setup-emacs-lisp-mode) )
;;  (add-hook 'emacs-lisp-mode-hook #'jv/setup-emacs-lisp-mode)
;;  (add-hook 'emacs-lisp-mode-hook 'company-mode)

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
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

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package command-log-mode)
