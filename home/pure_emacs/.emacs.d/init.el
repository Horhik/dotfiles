(require 'package)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(visual-line-mode t)
(global-visual-line-mode 1)
(global-visual-line-mode)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

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
   '("6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(package-selected-packages
   '(neotree treemacs-persp spaceline-all-the-icons all-the-icons-ivy-rich all-the-icons-ivy treemacs-the-icons dired-icon treemacs-magit treemacs-projectile nlinum linum-mode unicode-fonts ewal-doom-themes ivy-rich which-key counsel org-roam treemacs-evil treemacs-all-the-icons treemacs use-package general gruvbox-theme flycheck-rust cargo linum-relative ac-racer lusty-explorer doom-modeline doom-themes rainbow-delimiters evil-mc rustic lsp-mode avy)))

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

;;(set-fontset-font "fontset-startup" 'unicode
;;		  (font-spec :name "Mononoki Nerd Font" :size 14))

;; Fallback for emojies
(set-fontset-font "fontset-default" 'unicode
		  (font-spec :name "Twemoji" :size 16))
(load-theme 'gruvbox-dark-hard)


(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

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

(use-package emojify
  :hook (after-init . global-emojify-mode)
  :config
  (setq emojify-emoji-set "twemoji-v2")
  (setq emojify-set-emoji-styles 'image)
  (setq emojify-display-style 'image))


;; Evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (global-undo-tree-mode)
  :config
  (evil-set-undo-system 'undo-tree)
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))



(use-package evil-collection
  :after evil
  :init
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
(use-package counsel-projectile
  :config (counsel-projectile-mode))


;; Keybindings

(defun add-to-map(keys func)
  "Add a keybinding in evil mode from keys to func."
  (define-key evil-normal-state-map (kbd keys) func)
  (define-key evil-motion-state-map (kbd keys) func))

;;(add-to-map "<SPC>" nil)
;;(add-to-map "<SPC> <SPC>" 'counsel-M-x)
;; (add-to-map "<SPC> f" 'lusty-file-explorer)
;; (add-to-map "<SPC> b" 'lusty-buffer-explorer)
;;(add-to-map "<SPC> o" 'treemacs)
;;(add-to-map "<SPC> s" 'save-buffer)

(defun open-file (file)
  "just more shortest function for opening the file"
  (interactive)
  ((lambda (file) (interactive)
     (find-file (expand-file-name (format "%s" file)))) file ) )


(general-evil-setup)
(general-nmap
  :prefix "SPC"
  ;; dotfiles editing config
  "SPC" '(counsel-M-x :which-key "M-x")
  "o"   '(treemacs :which-key "treemacs")
  "f f" '(counsel-find-file :which-key "find-file")
  "f r" '(counsel-buffer-or-recentf :which-key "recent files")

  "b b" '(counsel-switch-buffer :which-key "switch buff")

  "f e"  '(lambda() (interactive) (find-file "~/.emacs.d/config.org") :which-key "config.org")
  "f v"  '(lambda() (interactive) (find-file "~/.config/nvim/init.vim" :which-key "neovim config"          ))
  "f d"  '(lambda() (interactive) (find-file "~/dotfiles/home"  :which-key "dotfiles dired"                 ))
  "f a"  '(lambda() (interactive) (find-file "~/.config/alacritty/alacritty.yml" :which-key "alacritty"))
  "f b"  '(lambda() (interactive) (find-file "~/Brain")                           :which-key "my brain")
  )


;; Org roam
(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :general (general-nmap
             :prefix "SPC r"
             ;; Org-roam keymap
             "d" '(org-roam-dailies-find-today :which-key "roam today")
             "t a" '(org-roam-tag-add :which-key "roam add tag")
             "t d" '(org-roam-tag-delete :which-key "roam delete tag")
             "a a" '(org-roam-alias-add :which-key "roam add alias")
             "f f" '(org-roam-find-file :which-key "roam findgfile ")
             "g" '(org-roam-graph-show :which-key "roam graph ")
             "b b" '(org-roam-buffer-toggle-display :which-key "roam buffer toggle ")
             "b s" '(org-roam-buffer-activate :which-key "roam buffer show ")
             "b h" '(org-roam-buffer-deactivate :which-key "roam buffer hide ")
             "s" '(org-roam-server-mode :which-key "roam server "))
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


  (require 'org-roam-protocol))



(require 'org-roam-protocol)
(use-package highlight-parentheses
  :ensure t
  :init
  (global-highlight-parentheses-mode t)
  (show-paren-mode t))			;
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
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
	("C-x t t"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

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


(use-package magit)
(use-package workgroups2)

(set-face-attribute 'variable-pitch nil
                    ;; :font "Cantarell"
                    :font "Mononoki Nerd Font"
                    :height 1.3
                    :weight 'light)

(set-face-attribute 'org-document-title nil :font "ubuntu" :weight 'bold :height 1.3)
(dolist (face '((org-level-1 . 1.3)
		(org-level-2 . 1.2)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)
		(org-level-5 . 1.1)
		(org-level-6 . 1.1)
		(org-level-7 . 1.1)
		(org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "ubuntu" :weight 'bold :height (cdr face)))
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


(defun my/org-mode-setup()
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent 1)
  (variable-pitch-mode t)
  )


(use-package org 
  :hook ((org-mode . my/org-mode-setup)
	 (org-mode . variable-pitch-mode)
	 )
  :config (setq org-agenda-files `("~/Brain" "~/Brain/Tasks/Tasks.org")) 
  (org-bullets-mode) 
  (setq org-ellipsis " ▸" org-hide-emphasis-markers t org-src-fontify-natively t
	org-src-tab-acts-natively t org-edit-src-content-indentation 2 org-hide-block-startup nil
	org-src-preserve-indentation nil org-startup-folded 'content org-cycle-separator-lines 2) 
  (setq org-agenda-start-with-log-mode t) 
  (setq org-log-done 'time) 
  (setq org-log-into-drawer t)
  (setq org-todo-keyword-faces '(("TODO" . org-warning) 
				 ("STARTED" . "yellow") 
				 ("DREAM" . "pink") 
				 ("IDEA" . "gold") 
				 ("ARTICLE" . "lightblue") 
				 ("CANCELED" . 
				  (:foreground "blue" 
					       :weight bold))))

  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)") 
			    (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)"
				      "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)") 
			    (sequence "IDEA(i)" "DREAM(d)" "ARTICLE(a)" "|" "DONE(d!)")))

  (setq org-agenda-custom-commands '(("d" "Dashboard" ((agenda "" ((org-deadline-warning-days 7))) 
						       (todo "NEXT" ((org-agenda-overriding-header
								      "Next Tasks"))) 
						       (tags-todo "agenda/ACTIVE"
								  ((org-agenda-overriding-header
								    "Active Projects")))))
				     ("n" "Next Tasks" ((todo "NEXT" ((org-agenda-overriding-header
								       "Next Tasks")))))
				     ("i" "Ideas" ((todo "IDEA" ((org-agenda-overriding-header
								       "Ideas ")))))
				     ("A" "Articles" ((todo "Article" ((org-agenda-overriding-header
								       "Article")))))
				     ("W" "Work Tasks" tags-todo "+work-email")
				     ("W" "Work Tasks" tags-todo "+work-email")
				     ("I" "ideas" tags-todo "+idea-article")

				     ;; Low-effort next actions
				     ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
				      ((org-agenda-overriding-header "Low Effort Tasks") 
				       (org-agenda-max-todos 20) 
				       (org-agenda-files org-agenda-files)))
				     ("w" "Workflow Status" ((todo "WAIT"
								   ((org-agenda-overriding-header
								     "Waiting on External") 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "REVIEW"
								   ((org-agenda-overriding-header
								     "In Review") 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "PLAN"
								   ((org-agenda-overriding-header
								     "In Planning") 
								    (org-agenda-todo-list-sublevels
								     nil) 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "BACKLOG"
								   ((org-agenda-overriding-header
								     "Project Backlog") 
								    (org-agenda-todo-list-sublevels
								     nil) 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "READY"
								   ((org-agenda-overriding-header
								     "Ready for Work") 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "ACTIVE"
								   ((org-agenda-overriding-header
								     "Active Projects") 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "COMPLETED"
								   ((org-agenda-overriding-header
								     "Completed Projects") 
								    (org-agenda-files
								     org-agenda-files))) 
							     (todo "CANC"
								   ((org-agenda-overriding-header
								     "Cancelled Projects") 
								    (org-agenda-files
								     org-agenda-files)))))))


  :general (general-nmap :prefix "SPC a" 
	     :keymap 'org-agenda-mode-map 
	     "a" 'org-agenda))
(use-package org-bullets
  :after org
  :hook
  ((org-mode . org-bullets-mode)
   )
  )

(defun my/visual-fill ()
  (setq visual-fill-column-width 140
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
(use-package visual-fill-column
  :defer t
  :hook (org-mode . my/visual-fill))
