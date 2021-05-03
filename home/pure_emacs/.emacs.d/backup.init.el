(require 'package)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(visual-line-mode t)
(visual-line-mode 1)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("org" . "https://orgmode.org/elpa/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


(defvar package-list
  '( lsp-mode rustic evil-mc rainbow-delimiters doom-themes doom-modeline lusty-explorer ac-racer auto-complete all-the-icons linum-relative  racer cargo flycheck-rust rust-mode gruvbox-theme evil general use-package treemacs treemacs-all-the-icons treemacs-evil org-roam org-roam-server interaction-log))

(dolist (p package-list)
  (when (not (package-installed-p p))
	 (package-install p)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(package-selected-packages
   '(rls lsp highlight-parentheses neotree treemacs-persp spaceline-all-the-icons all-the-icons-ivy-rich all-the-icons-ivy treemacs-the-icons dired-icon treemacs-magit treemacs-projectile nlinum linum-mode unicode-fonts ewal-doom-themes ivy-rich which-key counsel org-roam treemacs-evil treemacs-all-the-icons treemacs use-package general gruvbox-theme flycheck-rust cargo linum-relative ac-racer lusty-explorer doom-modeline doom-themes rainbow-delimiters evil-mc rustic lsp-mode avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Setting up use-package
(require 'use-package)
(setq use-package-always-ensure t)

;; Default fonts
  (add-to-list 'default-frame-alist '(font . "Mononoki Nerd Font" ))
  (set-face-attribute 'default t :font "Mononoki Nerd Font" )
  (use-package unicode-fonts
    :init
    (unicode-fonts-setup))

  (set-fontset-font "fontset-startup" 'unicode
      (font-spec :name "Mononoki Nerd Font" :size 14))

;; Fallback for emojies
  (set-fontset-font "fontset-default" 'unicode
      (font-spec :name "Twemoji" :size 14))

(load-theme 'gruvbox)

;; Emojies
(use-package emojify
  :hook (after-init . global-emojify-mode)
  :config
  (setq emojify-emoji-set "twemoji-v2")
  (setq emojify-set-emoji-styles 'unicode)
  (setq emojify-display-style 'unicode))

;; mode line
(require 'doom-modeline)
(doom-modeline-mode 1)

;; Line numbers
(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda ()
	(display-line-numbers-mode 1)
	(setq display-line-numbers 'relative))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package evil
:ensure t
:init
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
:config
 (evil-mode 1)
 (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
 (evil-global-set-key 'motion "j" 'evil-next-visual-line)
 (evil-global-set-key 'motion "k" 'evil-previous-visual-line))
(use-package undo-tree
  :after evil
  :init
   (global-undo-tree-mode)
   (evil-set-undo-system 'undo-tree))
(use-package evil-mc
  :after evil
  :config
  (evil-mc-mode  1) ;; enable
  (global-set-key (kbd "<secape>") 'keyboard-escape-quit)
  :bind (
   :map evil-normal-state-map
   ("SPC m u" . evil-mc-undo-all-cursors)
   :map evil-visual-state-map
    ("SPC m a" . evil-mc-make-cursor-in-visual-selection-beg)))
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package counsel)
(use-package ivy
  :diminish
  :bind (
	 ("M-x" . counsel-M-x)
	 ("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-f" . ivy-alt-done)
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
  :init
  (ivy-mode 1))
 (use-package smex
  :after counsel)

(defun add-to-map(keys func)
  "Add a keybinding in evil mode from keys to func."
  (define-key evil-normal-state-map (kbd keys) func)
  (define-key evil-motion-state-map (kbd keys) func))

(add-to-map "<SPC>" nil)
(add-to-map "<SPC> s" 'save-buffer)

(defun open-file (file)
  "just more shortest function for opening the file"
  (interactive)
  ((lambda (file) (interactive)
		  (find-file (expand-file-name (format "%s" file)))) file ) )


(general-evil-setup)
(general-define-key
  :prefix "SPC"
  :keymaps 'normal
"o" '(treemacs :which-key "treemacs")
"SPC" '(counsel-M-x :which-key "M-x")
;; org-roam

;; dotfiles editing config
"f f" '(counsel-find-file :which-key "find-file")
"f r" '(counsel-buffer-or-recentf :which-key "recent files")
;; switch buffer
"b b" '(counsel-switch-buffer :which-key "switch buff")
;; Theme
"h" '(counsel-load-theme :which-key "switch theme")
;; Bind  keymaps
"p" '(:keymap projectile-command-map :package projectile)
"w" '(:keymap evil-window-map :package evil)
;; Edit common files
"f e"  '(lambda() (interactive) (find-file "~/.emacs.d/config.org") :which-key "config.org")
"f v"  '(lambda() (interactive) (find-file "~/.config/nvim/init.vim" :which-key "neovim config"          ))
"f d"  '(lambda() (interactive) (find-file "~/dotfiles/home"  :which-key "dotfiles dired"                 ))
"f a"  '(lambda() (interactive) (find-file "~/.config/alacritty/alacritty.yml" :which-key "alacritty"))
"f b"  '(lambda() (interactive) (find-file "~/Brain"                           :which-key "my brain")))

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :general (general-nmap
	:prefix "SPC r"
        ;; Org-roam keymap
        "d" '((lambda () (interactive) (org-roam-dailies-find-today)) :which-key "roam today")
        "t a" '(org-roam-tag-add :which-key "roam add tag")
        "t d" '(org-roam-tag-delete :which-key "roam delete tag")
        "a a" '(org-roam-alias-add :which-key "roam add alias")
        "f f" '(org-roam-find-file :which-key "roam findgfile ")
        "g" '(org-roam-graph-show :which-key "roam graph ")
        "b b" '(org-roam-buffer-toggle-display :which-key "roam buffer toggle ")
        "b s" '(org-roam-buffer-activate :which-key "roam buffer show ")
        "b h" '(org-roam-buffer-deactivate :which-key "roam buffer hide ")
        "s" '(org-roam-server-mode :which-key "roam server ")
        )
      :custom
      (org-roam-directory "~/Brain")
      :config
      (setq
	org-roam-server-host "127.0.0.1"
	org-roam-server-port 5034
	org-roam-server-authenticate nil
	org-roam-server-export-inline-images t
	org-roam-server-serve-files nil
	org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
	org-roam-server-network-poll t
	org-roam-server-network-arrows nil
	org-roam-server-network-label-truncate t
	org-roam-server-network-label-truncate-length 60
	org-roam-server-network-label-wrap-length 20)


(require 'org-roam-protocol)
)

(use-package interaction-log
  :ensure t)

(use-package highlight-parentheses
:ensure t
:init
(global-highlight-parentheses-mode t)
(show-paren-mode t))			;
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;Which key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package all-the-icons)
(use-package treemacs-all-the-icons)
(use-package treemacs
  :after all-the-icons
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
	  treemacs-deferred-git-apply-delay      0.5
	  treemacs-directory-name-transformer    #'identity
	  treemacs-display-in-side-window        t
	  treemacs-eldoc-display                 t
	  treemacs-file-event-delay              5000
	  treemacs-file-extension-regex          treemacs-last-period-regex-value
	  treemacs-file-follow-delay             0.2
	  treemacs-file-name-transformer         #'identity
	  treemacs-follow-after-init             t
	  treemacs-git-command-pipe              ""
	  treemacs-goto-tag-strategy             'refetch-index
	  treemacs-indentation                   2
	  treemacs-indentation-string            " "
	  treemacs-is-never-other-window         nil
	  treemacs-max-git-entries               5000
	  treemacs-missing-project-action        'ask
	  treemacs-move-forward-on-expand        nil
	  treemacs-no-png-images                 nil
	  treemacs-no-delete-other-windows       t
	  treemacs-project-follow-cleanup        nil
	  treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
	  treemacs-position                      'left
	  treemacs-read-string-input             'from-child-frame
	  treemacs-recenter-distance             0.1
	  treemacs-recenter-after-file-follow    nil
	  treemacs-recenter-after-tag-follow     nil
	  treemacs-recenter-after-project-jump   'always
	  treemacs-recenter-after-project-expand 'on-distance
	  treemacs-show-cursor                   nil
	  treemacs-show-hidden-files             t
	  treemacs-silent-filewatch              nil
	  treemacs-silent-refresh                nil
	  treemacs-sorting                       'alphabetic-asc
	  treemacs-space-between-root-nodes      t
	  treemacs-tag-follow-cleanup            t
	  treemacs-tag-follow-delay              1.5
	  treemacs-user-mode-line-format         nil
	  treemacs-user-header-line-format       nil
	  treemacs-width                         35
	  treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-load-theme 'all-the-icons)
    (treemacs-fringe-indicator-mode 'always)
    (pcase (cons (not (null (executable-find "git")))
		 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-o"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t

)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :init
  (setq projectile-switch-project-action #'projectile-deired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package workgroups2)

(defun my/org-mode-setup() 
	     (org-indend-mode) 
	     (variable-pitch-mode 1) 
	     (auto-fill-mode 0) 
	     (visual-line-mode 1) 
	     (setq evil-auto indent 1)
	     (my/org-agenda)
	     ) 
     (use-package org 
	  :hook (org-mode . my/org-mode-setup)
	  :config
	  (setq org-agenda-files `("~/Brain" "~/Brain/Tasks/Tasks.org"))
	  (setq org-ellipsis " ▸"
	  org-hide-emphasis-markers t
	  org-src-fontify-natively t
	  org-src-tab-acts-natively t
	  org-edit-src-content-indentation 2
	  org-hide-block-startup nil
	  org-src-preserve-indentation nil
	  org-startup-folded 'content
	  org-cycle-separator-lines 2)
	  (setq org-agenda-start-with-log-mode t)
	  (setq org-log-done 'time)
	  (setq org-log-into-drawer t)
	  :general (general-nmap
		    :prefix "SPC a"
		    :keymap 'org-agenda-mode-map
		    "a" 'org-agenda
		    )
	   )


 

(defun my/org-agenda () (
(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")
      (sequence "IDEA(i)" "DREAM(d)" "ARTICLE(a)" "|" "DONE(d!)")
      ))
(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow") ("DREAM" . "pink") ("IDEA" . "gold") ("ARTICLE" . "lightblue")
        ("CANCELED" . (:foreground "blue" :weight bold))))
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
	((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
	((org-agenda-overriding-header "Next Tasks")))))

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
  ))


(use-package org-bullets 
       :after org
       :hook
	 (org-mode . org-bullets-mode))
       (set-face-attribute 'org-document-title nil :font "hack" :weight 'bold :height 1.3)
       (dolist (face '((org-level-1 . 1.3)
		   (org-level-2 . 1.2)
		   (org-level-3 . 1.05)
		   (org-level-4 . 1.0)
		   (org-level-5 . 1.1)
		   (org-level-6 . 1.1)
		   (org-level-7 . 1.1)
		   (org-level-8 . 1.1)))
     (set-face-attribute (car face) nil :font "hack" :weight 'bold :height (cdr face)))
     (require 'org-indent)
 (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch :font "mononoki" )
 (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
 (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
 (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
 (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

 ;; Get rid of the background on column views
 (set-face-attribute 'org-column nil :background nil)
 (set-face-attribute 'org-column-title nil :background nil)
 (setq org-src-fontify-natively t)
(defun my/visual-fill ()
 (setq visual-fill-column-width 140
     visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
 (use-package visual-fill-column
  :defer t
  :hook (org-mode . my/visual-fill))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json"))

(use-package rustic
 :ensure t
 :init
 (setq rustic-lsp-server 'rls))

(treemacs-create-theme "Material"
  :icon-directory (treemacs-join-path treemacs-dir "/home/horhik/.emacs.d/icons")
  :config
  (progn
    (treemacs-create-icon :file "folder-core-open.png"   :fallback "📁"       :extensions (root-open))
    (treemacs-create-icon :file "folder-core.png"        :fallback "📁"       :extensions (root-closed))
    (treemacs-create-icon :file "folder-node-open.png"   :fallback "📂"       :extensions (dir-open))
    (treemacs-create-icon :file "folder-node.png"        :fallback "📁"       :extensions (dir-closed))
    (treemacs-create-icon :file "folder-test-open.png"   :fallback "📂"       :extensions ("tests"))
    (treemacs-create-icon :file "folder-test.png"        :fallback "📁"       :extensions ("tests"))
    (treemacs-create-icon :file "emacs.png"              :fallback "💜"     :extensions ("el" "elc" ".spacemacs" "doom" ))
    (treemacs-create-icon :file "emacs.png"              :fallback "💜"     :extensions ("el" "elc"))
    (treemacs-create-icon :file "markdown.png"           :fallback "📖"     :extensions ("md"))
    (treemacs-create-icon :file "readme.png"             :fallback "📖"     :extensions ("readme.md" "README.md" "README" "readme"))
    (treemacs-create-icon :file "editorconfig.png"       :fallback "📖"     :extensions ("editorconfig"))
    (treemacs-create-icon :file "org.png"                :fallback "🐴"     :extensions ("org"))
    (treemacs-create-icon :file "rust.png"               :fallback "🐴"     :extensions ("rs"))
    (treemacs-create-icon :file "haskell.png"            :fallback "🐴"     :extensions ("hs" "haskell"))
    (treemacs-create-icon :file "c.png"                  :fallback "🐴"     :extensions ("c"))
    (treemacs-create-icon :file "cpp.png"                :fallback "🐴"     :extensions ("cpp" "c++"))
    (treemacs-create-icon :file "h.png"                  :fallback "🐴"     :extensions ("h"))
    (treemacs-create-icon :file "diff.png"               :fallback "🐴"     :extensions ("diff"))
    (treemacs-create-icon :file "makefile.png"           :fallback "🐴"     :extensions ("mk" "make" "Makefile"))
    (treemacs-create-icon :file "assembly.png"           :fallback "🐴"     :extensions ("bin" "so" "o"))
    (treemacs-create-icon :file "document.png"           :fallback "🐴"     :extensions ("" "txt"))
    (treemacs-create-icon :file "file.png"               :fallback "🐴"     :extensions (fallback))
    (treemacs-create-icon :file "toml.png"               :fallback "🗃️"     :extensions ("toml"))
    (treemacs-create-icon :file "json.png"               :fallback "🗃️"     :extensions ("json"))
    (treemacs-create-icon :file "yaml.png"               :fallback "🗃️"     :extensions ("yml" "yaml"))
    (treemacs-create-icon :file "vim.png"                :fallback "🗃️"     :extensions ("vim" "vi" "nvim"))
    (treemacs-create-icon :file "video.png"              :fallback "🗃️"     :extensions ("mp4" "avi" "gif" "mpv"))
    (treemacs-create-icon :file "audio.png"              :fallback "🗃️"     :extensions ("mp3" "ogg" "wav" ))
    (treemacs-create-icon :file "image.png"              :fallback "🗃️"     :extensions ("png" "jpg"))
    (treemacs-create-icon :file "svg.png"                :fallback "🗃️"     :extensions ("svg"))
    (treemacs-create-icon :file "css.png"                :fallback "🗃️"     :extensions ("css"))
    (treemacs-create-icon :file "console.png"            :fallback "🗃️"     :extensions ("bash" "sh"))
    (treemacs-create-icon :file "certificate.png"        :fallback "🗃️"     :extensions ("cert" "LICENSE" "license" "gpl" "mit" "gpl3" "gplv3" "apache"))
    (treemacs-create-icon :file "database.png"           :fallback "🗃️"     :extensions ("sqlite" "db" "sql"))
    (treemacs-create-icon :file "lua.png"                :fallback "🗃️"     :extensions ("lua"))
    (treemacs-create-icon :file "javascript.png"         :fallback "🗃️"     :extensions ("js" "javascript"))
    (treemacs-create-icon :file "typescript.png"         :fallback "🗃️"     :extensions ("ts" "typescript"))
    (treemacs-create-icon :file "react.png"              :fallback "🗃️"     :extensions ("jsx"))
    (treemacs-create-icon :file "react_ts.png"           :fallback "🗃️"     :extensions ("tsx"))
    (treemacs-create-icon :file "settings.png"           :fallback "🗃️"     :extensions ("config" "conf" "rc" "*rc"))
    (treemacs-create-icon :file "sass.png"               :fallback "🗃️"     :extensions ("sass" "scss"))
    (treemacs-create-icon :file "xml.png"                :fallback "🗃️"     :extensions ("xml"))
    (treemacs-create-icon :file "less.png"               :fallback "🗃️"     :extensions ("less"))
    (treemacs-create-icon :file "pdf.png"                :fallback "🗃️"     :extensions ("pdf"))
    (treemacs-create-icon :file "tex.png"                :fallback "🗃️"     :extensions ("tex" "latex" ))
    (treemacs-create-icon :file "log.png"                :fallback "🗃️"     :extensions ("log" ))
    (treemacs-create-icon :file "word.png"               :fallback "🗃️"     :extensions ("docs" "docx" "word" ))
    (treemacs-create-icon :file "powerpoint.png"         :fallback "🗃️"     :extensions ("ppt" "pptx" ))
    (treemacs-create-icon :file "html.png"               :fallback "🗃️"     :extensions ("html"))
    (treemacs-create-icon :file "zip.png"                :fallback "🗃️"     :extensions ("zip" "tar" "tar.xz" "xz" "xfv" "7z"))
    (treemacs-create-icon :file "todo.png"               :fallback "🗃️"     :extensions ("TODO" "todo" "Tasks" ))
    (treemacs-create-icon :file "webassembly"            :fallback "🗃️"     :extensions ("wasm" "webasm" "webassembly"))
    (treemacs-create-icon :file "python"                 :fallback "🗃️"     :extensions ("py" "python"))))

(treemacs-load-theme 'Material)

(find-file "~/.emacs.d/startup.org")
