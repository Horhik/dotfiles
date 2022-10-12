(setq max-lisp-eval-depth 10000)
      (require 'package)
      (add-to-list 'package-archives
		   '("melpa" . "http://melpa.org/packages/") t)
      (add-to-list 'package-archives
		   '("melpa" . "http://melpa.org/packages/") t)


      (package-initialize)

      (unless package-archive-contents
	(package-refresh-contents))



      (defvar bootstrap-version)
(let ((bootstrap-file
     (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
    (bootstrap-version 5))
(unless (file-exists-p bootstrap-file)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
(load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(setq package-enable-at-startup nil)

(straight-use-package 'doom-themes
   :init
     (require 'doom-themes)
   )


   (custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
'(custom-enabled-themes '(doom-gruvbox))
'(custom-safe-themes
  '("e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "969a67341a68becdccc9101dc87f5071b2767b75c0b199e0ded35bd8359ecd69" default)))
 (custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

   (setq inhibit-startup-message t)
   (setq visible-bell t)
   (menu-bar-mode -1)
   (toggle-scroll-bar -1)
   (tool-bar-mode -1)
   (tooltip-mode -1)
   (set-fringe-mode 10)
   (visual-line-mode t)
   (global-visual-line-mode 1)
   (global-visual-line-mode)
   (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
   (straight-use-package 'use-package)

   (use-package which-key
   :straight t)

(column-number-mode)
(global-display-line-numbers-mode)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
:straight t
:hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package all-the-icons
:straight t)

(use-package evil
    :straight t
    :init

      (setq evil-want-keybinding nil)
      (setq evil-want-integration t)
      (setq evil-want-C-u-scroll t)
      (setq evil-want-C-i-jump nil)
      (setq evil-search-module 'evil-search)
      (setq evil-ex-complete-emacs-commands nil)
      (setq evil-vsplit-window-right t)
      (setq evil-split-window-below t)
      (setq evil-want-fine-undo 'fine)
      (setq evil-undo-system 'undo-redo)
      (setq evil-set-undo-system 'undo-redo)
    :config
      (evil-mode 1)
      (evil-set-undo-system 'undo-redo)
      (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
      (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-chair-and-join)

      (evil-global-set-key 'motion "j" 'evil-next-visual-line)
      (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

      (evil-set-initial-state 'messages-buffer-mode 'normal)
      (evil-set-initial-state 'dashboard-mode 'normal)

    )
   (use-package undo-tree
  :straight t
  :config
    (setq evil-undo-system 'undo-redo)
    (setq evil-set-undo-system 'undo-redo)

  (use-package evil-collection
  :straight t
  :config
  (evil-collection-init)
))

(use-package general
    :straight t
    :config
    (general-evil-setup t)
    (general-define-key
     :keymaps '(normal insert emacs)
     :prefix "SPC"
     :global-prefix "C-SPC"
     :non-normal-prefix "M-SPC"

     "/" 'swiper
     "b" 'counsel-switch-buffer

     "f r" 'counsel-recentf
     "f f" 'counsel-find-file
     "SPC" 'counsel-M-x

     "a" 'org-agenda


     ))


(general-create-definer my-leader-def
  :states 'motion
  :prefix "SPC")

(defun my/org-mode-setup()
     (auto-fill-mode 0)
     (visual-line-mode 1)
     (setq evil-auto-indent 1)
     (variable-pitch-mode t)
     (prettify-symbols-mode +1)
     (display-line-numbers-mode 0)
     )

   (use-package org
   :straight t

   :hook ((org-mode . my/org-mode-setup)
            (org-mode . variable-pitch-mode)
            (org-mode . org-indent-mode)
            (org-mode . prettify-symbols-mode)
   )
   :config
 ;; Make sure org-indent face is available
   ;; Increase the size of various headings
   (set-face-attribute 'org-document-title nil :font "Vollkorn" :weight 'bold :height 1.3)

   (dolist (face '((org-level-1 . 1.1)
                   (org-level-2 . 1.0)
                   (org-level-3 . 1.0)
                   (org-level-4 . 1.0)
                   (org-level-5 . 1.0)
                   (org-level-6 . 1.0)
                   (org-level-7 . 1.0)
                   (org-level-8 . 1.0)))
     (set-face-attribute (car face) nil :font "Vollkorn" :weight 'bold :height (cdr face)))

   ;; Ensure that anything that should be fixed-pitch in Org files appears that way
   (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
   (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
   (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
   (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
   ;(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
   (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
   (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
   (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
   (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

    (setq org-agenda-files `("~/GTD")) 
    (setq org-image-actual-width (list 550))
   ;; Get rid of the background on column views
   (set-face-attribute 'org-column nil :background nil)
   (set-face-attribute 'org-column-title nil :background nil)
   (setq org-src-fontify-natively t)
   (setq org-agenda-start-with-log-mode t) 
     (setq org-log-done 'time) 
     (setq org-log-into-drawer t)
     (setq org-todo-keyword-faces '(("TODO" . org-warning) 
                                    ("STARTED" . "yellow") 
                                    ("DREAM" . "pink") 
                                    ("PJ" . "pink") 
                                    ("IDEA" . "gold") 
                                    ("READ" . "violet") 
                                    ("NEXT" . "red") 
                                    ("ARTICLE" . "lightblue") 
                                    ("CANCELED" . 
                                     (:foreground "blue" 
                                                  :weight bold))))

     (setq org-todo-keywords '((sequence "INBOX(i)" "PJ(p)" "TODO(t)" "NEXT(n)" "CAL(c)" "WAIT(w@/!)" "|" "DONE(d!)" "CANC(k@)") 
                               ))
   (setq org-agenda-custom-commands org-agenda-settings)



)

   (use-package org-bullets
   :after (org)
   :hook (
      (org-mode . org-bullets-mode )
      (org-mode . org-indent-mode )

    )

   )
 (require 'general)
 (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)
 (general-def org-mode-map
     "TAB" 'org-cycle
 )

(setq org-agenda-settings '(
   ("d" "Dashboard 📜"
    (
     (agenda ""        ((org-deadline-warning-days 14))) 
     (tags "@morning"  ((org-agenda-overriding-header "Eat the Frog 🐸"))) 
     (tags "today"  ((org-agenda-overriding-header "Today Tasks 🌅"))) 
     (todo "NEXT"      ((org-agenda-overriding-header "Next Tasks ⏩"))) 
     (todo "WAIT"      ((org-agenda-overriding-header "Waiting tasks ⏰"))) 
     (todo "PJ"   ((org-agenda-overriding-header "Active Projects ")))
     (todo "INBOX"     ((org-agenda-overriding-header "Inbox 📥"))) 
    ))


   ("w" "Wait Tasks ⏰"
    (todo "WAIT"      ((org-agenda-overriding-header "Wait Tasks")))
    (todo "NEXT"      ((org-agenda-overriding-header "Wait Tasks")))
   )
   ("c" "Dated Tasks   📅" ((todo "CAL" ((org-agenda-overriding-header "Dated Tasks")))))

   ("S" "Somewhen ⌛" ((todo "TODO" ((org-agenda-overriding-header "Somewhen ")))))
   ("R" "Read list  📚" tags-todo "+readlist")
   ("W" "Watch list   🎦" tags-todo "+watchlist")
   ("I" "Ideas 💡" tags-todo "+idea")
   ("P" "petprojects 🐕" tags-todo "+petproject")
   ("B" "Things to buy  🛍" tags-todo "+shoplist")

   ;; My state/contexts
   ("s" . "My State and contexts")
   ("st" "Tired 🥱" tags-todo "+@tired/NEXT"    ((org-agenda-overriding-header "Tired 🥱")))
   ("sh" "At home🏠" tags-todo "+@home/NEXT"     ((org-agenda-overriding-header "At home🏠")))
   ("sc" "By a computer 💻" tags-todo "+@computer/NEXT" ((org-agenda-overriding-header "By a computer 💻")))
   ("ss" "On studies 🏫" tags-todo "+@uni/NEXT"   ((org-agenda-overriding-header "On studies 🏫")))
   ("so" "Online 🌐" tags-todo "+@online/NEXT"   ((org-agenda-overriding-header "Online 🌐")))
   ("st" "Do Today 🌄" tags-todo "+today/NEXT"   ((org-agenda-overriding-header "Today 🌄")))
   ("sO" "‍Outdoors🚶‍" tags-todo "+@outdoors/NEXT" ((org-agenda-overriding-header "‍Outdoors🚶‍")))
   ("sT" "To takeaway 👝 " tags-todo "+takeaway"  ((org-agenda-overriding-header "To takeaway 👝 ")))

   ("h" "💪 Daily habits 💪" 
       ((agenda ""))
       ((org-agenda-show-log t)
        (org-agenda-ndays 7)
        (org-agenda-log-mode-items '(state))
        (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":Habbit:"))))

 )
      ;; other commands here

)

(use-package pdf-tools
  :straight t
  :defer t
  )
    ;;(:host github :repo "https://git.savannah.gnu.org/cgit/emacs/elpa.git" :branch "main" :files ("*.el" "out"))
  ;:demand t
  ;:load-path "~/.emacs.d/elpa/org-9.5.4/"
  ;(org-bullets-mode t) 
  ;(org-indent-mode t)
  ;(setq org-ellipsis " ▸" org-hide-emphasis-markers t org-src-fontify-natively t
  ;      org-src-tab-acts-natively t org-edit-src-content-indentation 2 org-hide-block-startup nil
  ;      org-src-preserve-indentation nil org-startup-folded 'content org-cycle-separator-lines 2)

;; Enable converting external formats (ie. webp) to internal ones
(setq image-use-external-converter t)

(use-package tempo
  :straight t)

(general-define-key
       :keymaps '(normal insert emacs)
       :prefix "SPC"
       :global-prefix "C-SPC"
       :non-normal-prefix "M-SPC"

  "o t" '(counsel-org-tag :which-key "insert tag")
  "o l" '(counsel-org-link :which-key "insert tag")
)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package ivy
    :straight t
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
    (ivy-mode 1)

)
(use-package amx
:straight t
:init (amx-mode 1))

(straight-use-package 'ivy-posframe)
  (use-package counsel
    :straight t
    :bind (
          ("M-x" . counsel-M-x)
          ("C-x b" . counsel-buffer-or-recentf)
          ("C-x C-b" . counsel-switch-buffer)
          ("C-x C-f" . counsel-find-file)
          :map minibuffer-local-map
          ("C-x r" . 'counsel-minibuffer-history)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
  ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))

  ;;:after (ivy)
  ;;:config
(require 'ivy-posframe)
;; Different command can use different display function.
(setq ivy-posframe-display-functions-alist
      '((swiper          . ivy-posframe-display-at-point)
        (complete-symbol . ivy-posframe-display-at-point)
        (counsel-M-x     . ivy-posframe-display)
        (org-roam-node-find     . ivy-posframe-display)
        (org-roam-tag-add     . ivy-posframe-display)
        (org-roam-tag-remove     . ivy-posframe-display)
        (org-roam-node-insert     . ivy-posframe-display)
        (org-roam-node-insert     . ivy-posframe-display)
        (org-roam-tag-add     . ivy-posframe-display)
        (org-roam-tag-remove     . ivy-posframe-display)
        (t               . ivy-posframe-display)))
(ivy-posframe-mode 1)

(use-package all-the-icons-ivy-rich
      :straight t
      :init (all-the-icons-ivy-rich-mode 1)
      :config
      (setq all-the-icons-ivy-rich-icon t)
      (setq all-the-icons-ivy-rich-color-icon t)
      (setq all-the-icons-ivy-rich-project t)
      (setq all-the-icons-ivy-rich-field-width 80)
      (setq inhibit-compacting-font-caches t)
  )

    (use-package ivy-rich
      :straight t
      :init (ivy-rich-mode 1)
      :config
      (defun ivy-rich-counsel-find-file-truename (candidate)
      (let ((type (car (file-attributes (directory-file-name (expand-file-name candidate ivy--directory))))))
        (if (stringp type)
            (concat "-> " (expand-file-name type ivy--directory))
          "")))
(setq ivy-rich-display-transformers-list
      '(ivy-switch-buffer
        (:columns
         ((ivy-rich-switch-buffer-icon (:width 2))
          (ivy-rich-candidate (:width 30))
          (ivy-rich-switch-buffer-size (:width 7))
          (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
          (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
          (ivy-rich-switch-buffer-project (:width 15 :face success))
          (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
         :predicate
         (lambda (cand) (get-buffer cand)))))

      )

(use-package company
    :straight t
    :config
    (company-mode 1)
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-backends '((company-capf :with company-yasnippet)))
    )
    (use-package company-org-roam
    :straight t
    :hook (org-roam-mode . company-org-roam)
  )
(use-package yasnippet
  :straight t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package org-roam
      :straight t
      :custom
      (org-roam-directory (file-truename "/home/horhik/Notes/"))
      :bind (("C-c n l" . org-roam-buffer-toggle)
             ("C-c n f" . org-roam-node-find)
             ("C-c n g" . org-roam-graph)
             ("C-c n i" . org-roam-node-insert)
             ("C-c n c" . org-roam-capture)
             ;; Dailies
             ("C-c n j" . org-roam-dailies-capture-today)

             ;; Tags
             ("C-c t a" . org-roam-tag-add)
             ("C-c t r" . org-roam-tag-remove)

  )

      :config
      ;; If you're using a vertical completion framework, you might want a more informative completion interface
      (setq org-roam-completion-everywhere t)
      (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
      (org-roam-db-autosync-mode)
      ;; If using org-roam-protocol
      (require 'org-roam-protocol)
      :custom
        (setq org-roam-db-location  (concat org-roam-directory  "/home/horhik/Notes/org-roam.db"))
       (org-roam-directory "~/Notes/")
       (org-roam-dailies-directory "~/Notes/journals/")
       (org-roam-capture-templates
        '(("d" "default" plain
           "%?" :target
           (file+head "pages/${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)))

)

(use-package org-roam-ui
  :straight
    (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
    :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(general-define-key
       :keymaps '(normal insert emacs)
       :prefix "SPC"
       :global-prefix "C-SPC"
       :non-normal-prefix "M-SPC"

  "n f" '(org-roam-node-find :which-key "Find Node")
  "n i" '(org-roam-node-insert :which-key "Insert Node")
  "n b" '(org-roam-buffer-toggle :which-key "Toggle buffer")
  "n c" '(org-roam-capture :which-key "Capture")
  "n d t" '(org-roam-dailies-goto-today :which-key "Today")
  "n d T" '(org-roam-dailies-goto-tomorrow :which-key "Tomorrow")
  "n d y" '(org-roam-dailies-goto-yesterday :which-key "Yesterday")
  "l b" '(list-bookmarks :which-key "List bookmarks")
  "n t a" '(org-roam-tag-add :which-key "Add tag")
  "n t r" '(org-roam-tag-remove :which-key "Remove tag")

  )

(use-package projectile
  :straight t
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :straight t
  :config (counsel-projectile-mode))

(use-package magit
  :straight t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

(use-package lsp-mode
  :straight t
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 1.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode
  :custom
  ;(lsp-ui-peek-always-show t)
  ;(lsp-ui-sideline-show-hover t)

  (lsp-ui-doc-enable nil)
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable t)
  )

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to/
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

(use-package rustic
  :straight t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  ;(setq lsp-rust-analyzer-server-display-inlay-hints t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(use-package flycheck :straight t)

(use-package cdlatex
  :straight t
  :after org
  :config
  (add-hook 'org-mode-hook 'org-cdlatex-mode)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))

(use-package org-fragtog
  :straight t
  :config
  (add-hook 'org-mode-hook 'org-fragtog-mode)
)

(modify-coding-system-alist 'file "\\.tex\\'" 'cp1252)
