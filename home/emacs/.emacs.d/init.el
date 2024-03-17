(setq max-lisp-eval-depth 10000)
  (print "Adding melpa")

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

  (print "Initializing...")

  (unless package-archive-contents
    (package-refresh-contents))
  (setq package-enable-at-startup nil)
  (setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq visible-bell t)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(visual-line-mode t)
(global-visual-line-mode 1)
(global-visual-line-mode)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;(straight-use-package 'use-package)

(use-package which-key)

(straight-use-package 'gruvbox-theme

)

(load-theme 'gruvbox-dark-medium t nil)
;(loadtheme 'timu-spacegrey t nil)

;(column-number-mode)
(global-display-line-numbers-mode 1)
(menu-bar--display-line-numbers-mode-relative)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                telega-root-mode-hook
                telega-chat-mode-hook
                doc-view-mode-hook
                pdf-mode-hook
                eww-mode-hook
                eshell-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))

(add-hook 'shell-mode-hook       #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'telega-root-mode-hook #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'help-mode-hook #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'telega-chat-mode-hook #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'telega-image-mode-hook #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'telega-mode-hook #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'doc-view-mode-hook    #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'pdf-mode-hook         #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'eww-mode-hook         #'(lambda()(display-line-numbers-mode -1)))
(add-hook 'treemacs-mode-hook         #'(lambda()(display-line-numbers-mode -1)))

(use-package rainbow-delimiters
:ensure t
:hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package all-the-icons
:ensure t)

(use-package evil
    :ensure t
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
  :ensure t
  :config
    (setq evil-undo-system 'undo-redo)
    (setq evil-set-undo-system 'undo-redo)

  (use-package evil-collection
  :ensure t
  :config
  (evil-collection-init)
))

(variable-pitch-mode 0)

;(add-to-list 'default-frame-alist
;                       '((font . "mononoki")
;                       (font . "Mononoki Nerd Font")
;                       (font . "Liberation Sans")
;                       ))
(defun my/buffer-face-mode-variable ()
   "Set font to a variable width (proportional) fonts in current buffer"
   (interactive)
   (setq buffer-face-mode-face '(:family "mononoki" :height 100 :width semi-condensed))
   (buffer-face-mode))
(add-hook 'erc-mode-hook 'my/buffer-face-mode-variable)
(add-hook 'Info-mode-hook 'my/buffer-face-mode-variable)
(add-hook 'org-mode-hook 'my/buffer-face-mode-variable)
(add-hook 'eww-mode-hook 'my/buffer-face-mode-variable)
 

;(add-hook 'org-mode-hook (lambda () (set-frame-font "mononoki" t)))
;(set-face-attribute 'default nil :font "mononoki")
;; Default fonts
;(add-to-list 'default-frame-alist '(font . "mononoki" ))
;(set-face-attribute 'default t :font "mononoki" )
(set-frame-font "mononoki")


;(set-fontset-font "fontset-startup" 'unicode
;		  (font-spec :name "mononoki" :size 14))
;(when (member "Twemoji" (font-family-list))
;  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))
;; ☺️ ☻ 😃 😄 😅 😆 😊 😎 😇 😈 😏 🤣 🤩 🤪 🥳 😁 😀 😂 🤠 🤡 🤑 🤓 🤖 😗 😚 😘 😙 😉 🤗 😍 🥰 🤤 😋 🤔 🤨 🧐 🤭 🤫 😯 🤐 😌 😖 😕 😳 😔 🤥 🥴 😮 😲 🤯 😩 😫 🥱 😪 😴 😵 ☹️ 😦 😞 😥 😟 😢 😭 🤢 🤮 😷 🤒 🤕 🥵 🥶 🥺 😬 😓 😰 😨 ;;😱 😒 😠 😡 😤 😣 😧 🤬 😸 😹 😺 😻 😼 😽 😾 😿 🙀 🙈 🙉 🙊 🤦 🤷 🙅 🙆 🙋 🙌 🙍 🙎 🙇 🙏 👯 💃 🕺 🤳 💇 💈 💆 🧖 🧘 🧍 🧎 👰 🤰 🤱 👶 🧒 👦 👧 👩 👨 🧑 🧔 🧓 👴 👵 👤 👥 👪 👫 👬 👭 👱 👳 👲 🧕 👸 🤴 🎅 🤶 🧏 🦻 🦮 🦯 🦺 🦼 🦽 🦾 🦿 🤵 👮 ;;👷 💁 💂 🕴 🕵️ 🦸 🦹 🧙 🧚 🧜 🧝 🧞 🧛 🧟 👼 👿 👻 👹 👺 👽 👾 🛸 💀 ☠️ 🕱 🧠 🦴 👁 👀 👂 👃 👄 🗢 👅 🦷 🦵 🦶 💭 🗬 🗭 💬 🗨 🗩 💦 💧 💢 💫 💤 💨 💥 💪 🗲 🔥 💡 💩 💯 
;; Fallback for emojies

;(set-frame-font "-UKWN-Mononoki-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")

;; (use-package mixed-pitch
 ;;    :ensure t
 ;;    :hook
;;    (text-mode . mixed-pitch-mode)
;;    :config
;;    (set-face-attribute 'default nil :font "mononoki" :height 130)
;;    (set-face-attribute 'fixed-pitch nil :font "mononoki")
;;    (set-face-attribute 'variable-pitch nil :font "mononoki"))

(defun opt ()
                "open tasks"
                (interactive)
                (find-file "~/GTD/tasks.org"))
          (defun opi ()
                "open inbox"
                (interactive)
                (find-file "~/GTD/inbox.org"))
        (defun opd ()
              "open daily"
              (interactive)
              (find-file "~/GTD/daily.org"))
      (defun opr ()
            "open readlist"
            (interactive)
            (find-file "~/GTD/readlist.org"))
    (defun opc ()
            "open readlist"
            (interactive)
            (find-file "~/.emacs.d/config.org"))
  (defun ops ()
            "open readlist"
            (interactive)
            (find-file "~/.config/sway/config"))
(defun oph ()
          "open readlist"
          (interactive)
          (find-file "~/.config/home-manager/home.nix"))
  (defun open-shoplist ()
          "open shoplist"
          (interactive)
          (find-file "~/GTD/shoplist.org"))
  (defun open-projects ()
          "open projects"
          (interactive)
          (find-file "~/GTD/projects.org"))

(use-package general
    :ensure t
    :config
    (general-evil-setup t)
    (general-define-key
     :keymaps '(normal insert emacs)
     :prefix "SPC"
     :global-prefix "C-SPC"
     :non-normal-prefix "M-SPC"

     "/" 'swiper
     "b" 'counsel-switch-buffer

     "f r" '(counsel-recentf :which-key "recent files")
     "f f" '(counsel-find-file :which-key "find files")
     "f c" '(opc :which-key "open config")
     "f s" '(ops :which-key "open sway")
     "f h" '(oph :which-key "open home-manager")


     "t t" '(opt :which-key "✅Tasks")
     "t i" '(opi :which-key "📥Inbox")
     "t d" '(opd :which-key "🌄Daily")
     "t r" '(opr :which-key "📚Readlist")
     "t s" '(open-shoplist :which-key "🛒Shoplist")
     "t p" '(open-projects :which-key "📁Projects")

     "SPC" 'counsel-M-x


    "TAB" '(treemacs-select-window :which-key "focus on treemacs")

     "a" 'org-agenda


     )) 


(general-create-definer my-leader-def
  :states 'motion
  :prefix "SPC")

(defun my/setup-org-margins()
  (setq visual-fill-column-center-text t)
  ;(visual-fill-column-mode t)
  (visual-line-mode t)
  )

(defun my/org-mode-setup()
           (auto-fill-mode 0)
           (visual-line-mode 1)
           (setq evil-auto-indent 1)
           (variable-pitch-mode 0)
           (prettify-symbols-mode +1)
           (display-line-numbers-mode 1)
           )

         (use-package org
         :ensure t

         :hook ((org-mode . my/org-mode-setup)
                  (org-mode . variable-pitch-mode)
                  (org-mode . org-indent-mode)
                  (org-mode . prettify-symbols-mode)
                  (org-mode . my/setup-org-margins)
         )
         :config
      (require 'org-habit)
      (add-to-list 'org-modules 'org-habit)
      (setq org-habit-graph-column 60)
      (setq org-treat-insert-todo-heading-as-state-change t)
      (setq org-agenda-start-with-log-mode t)
      (setq org-log-done 'time)
      (setq org-log-into-drawer t)
      (setq org-hide-emphasis-markers t)


       ;; Make sure org-indent face is available
         ;; Increase the size of various headings


         (add-hook 'org-agenda-finalize-hook #'hl-line-mode)

      ;(set-face-attribute 'org-document-title nil :font "Liberation Sans" :weight 'bold :height 1.3)

       (dolist (face '((org-level-1 . 1.0)
                       (org-level-2 . 1.0)
                       (org-level-3 . 1.0)
                       (org-level-4 . 1.0) 
                       (org-level-5 . 1.0)
                       (org-level-6 . 1.0)
                       (org-level-7 . 1.0)
                       (org-level-8 . 1.0)))
         (set-face-attribute (car face) nil :font "Liberation Sans" :weight 'bold :height (cdr face)))

      ;  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
      ;  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
      ;  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
      ;  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
      ;  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
      ;  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
      ; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
      ; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
      ; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
      ; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

          (setq org-agenda-files 
                                   '(
                                   "~/GTD/daily.org"
                                   "~/GTD/tasks.org"
                                   "~/GTD/inbox.org"
                                   "~/GTD/done.org"
                                   "~/GTD/projects.org"
                                   "~/GTD/backlog.org"
                                   "~/GTD/calendar.org"
                                   "~/GTD/watchlist.org"
                                   "~/GTD/readlist.org"
                )) 
          (setq org-image-actual-width (list 550))
         ;; Get rid of the background on column views
;         (set-face-attribute 'org-column nil :background nil)
;         (set-face-attribute 'org-column-title nil :background nil)
         ;(setq org-src-fontify-natively t)
         (setq org-agenda-start-with-log-mode t) 
           (setq org-log-done 'time) 
           (setq org-log-into-drawer t)
           (setq org-todo-keyword-faces '(("TODO" . org-warning) 
                                          ("STARTED" . "yellow") 
                                          ("DREAM" . "pink") 
                                          ("PJ" . "pink") 
                                          ("IDEA" . "gold") 
                                          ("MUSIC" . "violet") 
                                          ("READ" . "violet") 
                                          ("NEXT" . "red") 
                                          ("ARTICLE" . "lightblue") 
                                          ("CANCELED" . 
                                           (:foreground "blue" 
                                                        :weight bold))))

           (setq org-todo-keywords '((sequence "INBOX(i)" "PJ(p)" "TODO(t)" "NEXT(n)" "CAL(c)" "WAIT(w@/!)" "|" "DONE(d!)" "CANC(k@)") 
                                     (sequence "IDEA(I)" "DREAM(D)" "READ(R)" "MUSIC(M)" "|" "DONE(d!)" "CANC(k@)")
                                     ))
         (setq org-agenda-custom-commands org-agenda-settings)
  (setq org-refile-targets
    '((("~/GTD/tasks.org") :maxlevel . 2)
      (("~/GTD/projects.org") :maxlevel . 2)
      (("~/GTD/backlog.org") :maxlevel . 1)
      (("~/GTD/done.org") :maxlevel . 1)
      ))


      )

      (defun org-habit-streak-count ()
      (point-min)
      (while (not (eobp))
        (when (get-text-property (point) 'org-habit-p)
          (let ((count (count-matches
                        (char-to-string org-habit-completed-glyph)
                        (line-beginning-position) (line-end-position))))
            (end-of-line)
            (insert (number-to-string count))))
          (forward-line 1)))
    (add-hook 'org-agenda-finalize-hook 'org-habit-streak-count)

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

(use-package org-download
  :ensure t
  :after org
  :bind
     (:map org-mode-map
       (("s-Y" . org-download-screenshot)
        ("s-y" . org-download-yank)))

  :config
      (setq-default org-download-image-dir ".")

  )
(general-define-key
         :keymaps '(normal insert emacs)
         :prefix "SPC"
         :global-prefix "C-SPC"
         :non-normal-prefix "M-SPC"
    "n s Y" '(org-download-screenshot :which-key "Download screenshot")
    "n s y" '(org-download-yank :which-key "Download yank")
    )

(defun air-org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.

  PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))
     (setq org-agenda-settings '(
        ("D" "Daily agenda and all TODOs"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-ndays 1)))
          (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         ((org-agenda-compact-blocks t)))
       ("d" "Dashboard 📜"
        (
         (agenda ""        ((org-deadline-warning-days 14))) 
         (tags "@morning"  ((org-agenda-overriding-header "Eat the Frog 🐸"))) 
         (tags "today/NEXT"  ((org-agenda-overriding-header "Today Tasks 🌅"))) 
         (todo "NEXT"      ((org-agenda-overriding-header "Next Tasks ⏩"))) 
         (todo "WAIT"      ((org-agenda-overriding-header "Waiting tasks ⏰"))) 
         (todo "PJ"   ((org-agenda-overriding-header "Active Projects ")))
         (todo "MUSIC"   ((org-agenda-overriding-header "Music 🎹")))
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
       ("M" "Music 🎹" tags-todo "+music")
       ("P" "petprojects 🐕" tags-todo "+petproject")
       ("B" "Things to buy  🛍" tags-todo "+shoplist")
       ("sd" "Do Today 🌄" tags-todo "+today/NEXT"   ((org-agenda-overriding-header "Today 🌄")))

       ;; My state/contexts
       ("s" . "My State and contexts")
       ("st" "Tired 🥱" tags-todo "+@tired/NEXT"    ((org-agenda-overriding-header "Tired 🥱")))
       ("sh" "At home🏠" tags-todo "+@home/NEXT"     ((org-agenda-overriding-header "At home🏠")))
       ("sc" "By a computer 💻" tags-todo "+@computer/NEXT" ((org-agenda-overriding-header "By a computer 💻")))
       ("ss" "On studies 🏫" tags-todo "+@uni/NEXT"   ((org-agenda-overriding-header "On studies 🏫")))
       ("sK" "In Kwork 🧑 🛋️  " tags-todo "+@kwork/NEXT"   ((org-agenda-overriding-header "In Kwork 🧑‍💻  🛋️   ")))
       ("so" "Online 🌐" tags-todo "+@online/NEXT"   ((org-agenda-overriding-header "Online 🌐")))
       ("sO" "‍Outdoors🚶‍" tags-todo "+@outdoors/NEXT" ((org-agenda-overriding-header "‍Outdoors🚶‍")))
       ("sT" "To takeaway 👝 " tags-todo "+takeaway"  ((org-agenda-overriding-header "To takeaway 👝 ")))

       ("F" "FROGS!" tags-todo "quack"  ((org-agenda-overriding-header "🐸🐸🐸🐸🐸🐸")))
        ("h" "💪 Daily habits 💪" 
            ((agenda ""))
            ((org-agenda-show-log t)
             (org-agenda-ndays 3)
             (org-agenda-log-mode-items '(state))
             (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "Habit")))
             )

         ("H" "💪Habits!💪🏻  " tags-todo "+Habit"  ((org-agenda-overriding-header "Habits 💪")))

     )

          ;; other commands here

   )

(set-face-attribute 'default nil
                    :family "mononoki"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(setq org-startup-with-latex-preview t)
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-preview-latex-process-alist
       '((dvipng :programs
         ("lualatex" "dvipng")
         :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
         (1.0 . 1.0)
         :latex-compiler
         ("lualatex -output-format dvi -interaction nonstopmode -output-directory %o %f")
         :image-converter
         ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
       (dvisvgm :programs
          ("latex" "dvisvgm")
          :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
          (1.7 . 1.5)
          :latex-compiler
          ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
          :image-converter
          ("dvisvgm %f -n -b min -c %S -o %O"))
       (imagemagick :programs
              ("latex" "convert")
              :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
              (1.0 . 1.0)
              :latex-compiler
              ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
              :image-converter
              ("convert -density %D -trim -antialias %f -quality 100 %O"))))

(use-package pdf-tools
  :ensure t
  :defer t
  )
    ;;(:host github :repo "https://git.savannah.gnu.org/cgit/emacs/elpa.git" :branch "main" :files ("*.el" "out"))
  ;:demand t
  ;:load-path "~/.emacs.d/elpa/org-9.5.4/"
  ;(org-bullets-mode t) 
  ;(org-indent-mode t)
  ;(setq org-ellipsis " ▸" org-hide-emphasis-markers t org-src-ontify-natively t
  ;      org-src-tab-acts-natively t org-edit-src-content-indentation 2 org-hide-block-startup nil
  ;      org-src-preserve-indentation nil org-startup-folded 'content org-cycle-separator-lines 2)

;; Enable converting external formats (ie. webp) to internal ones
(setq image-use-external-converter t)

(use-package swiper)

(use-package tempo
  :ensure t)

(general-define-key
       :keymaps '(normal insert emacs)
       :prefix "SPC"
       :global-prefix "C-SPC"
       :non-normal-prefix "M-SPC"

  "o t" '(counsel-org-tag :which-key "insert tag")
  "o l" '(counsel-org-link :which-key "insert tag")
)

(setq-default tab-width 4)

  (straight-use-package 'doom-modeline)


(doom-modeline-mode)

(straight-use-package 'org-ref
  :ensure t
)

(use-package ivy
      :ensure t
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
  (straight-use-package 'amx
  ) 
(amx-mode 1)

(use-package ivy-posframe)
  (use-package counsel
    :ensure t
    :bind (
          ("M-x" . counsel-M-x)
          ("C-x b" . counsel-buffer-or-recentf)
          ("C-x C-b" . counsel-switch-buffer)
          ("C-x C-f" . counsel-find-file)
          :map minibuffer-local-map
          ("C-x r" . 'counsel-minibuffer-history)))
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
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
      :ensure t
      :init (all-the-icons-ivy-rich-mode 1)
      :config
      (setq all-the-icons-ivy-rich-icon t)
      (setq all-the-icons-ivy-rich-color-icon t)
      (setq all-the-icons-ivy-rich-project t)
      (setq all-the-icons-ivy-rich-field-width 80)
      ;(setq inhibit-compacting-font-caches t)
  )

    (use-package ivy-rich
      :ensure t
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
:ensure t
:config
(company-mode 1)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends '((company-capf :with company-yasnippet)))
)

(use-package yasnippet
    :ensure t
    :config
    (yas-reload-all)
    (add-hook 'prog-mode-hook 'yas-minor-mode)
    (add-hook 'text-mode-hook 'yas-minor-mode)
    (add-hook 'org-mode-hook 'yas-minor-mode)


)
    (setq yas-snippet-dirs
          '("~/.emacs.d/snippets"                 ;; personal snippets
            ))

(setq org-roam-directory "~/Notes/pages")
  (setq org-roam-db-location "~/Notes/notes.org")
  (setq org-roam-dailies-directory "~/Notes/journals/")
(use-package org-roam
                                        ;(org-roam-directory (file-truename default-folder))
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
  (setq org-roam-directory "~/Notes/pages")
  (setq org-roam-db-location "~/Notes/notes.org")
  (setq org-roam-dailies-directory "~/Notes/journals/")
  (setq org-roam-mode-sections
        (list #'org-roam-backlinks-section
              #'org-roam-reflinks-section
              #'org-roam-unlinked-references-section
              ))
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-completion-everywhere t)
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (require 'org-roam-export)


  (org-roam-capture-templates
   '(("d" "default" plain
      "%?" :target
      (file+head "pages/${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))


  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (side . right)
                 (window-width . 0.33)
                 (window-parameters . (
                                       (no-delete-other-windows . t)))))
  (org-roam-db-autosync-mode t)



  )

(use-package org-roam-ui
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
  "n s Y" '(org-download-screenshot :which-key "Download screenshot")
  "n s y" '(org-download-yank :which-key "Download yank")
  "n s c" '(org-download-clipboard :which-key "Past from clipboard")

  )

(straight-use-package 'all-the-icons
            )
  (straight-use-package 'treemacs-all-the-icons
          )

(straight-use-package 'treemacs-nerd-icons)
;(treemacs-load-theme "nerd-icons")

(straight-use-package 'treemacs
  :config
  ;(treemacs-load-all-the-icons-with-workaround-font "Hermit")

(general-define-key
   :keymaps 'treemacs-mode-map

    "C-c C-d" '(treemacs-delete-file :which-key "delete file")
    "C-c C-c" '(treemacs-create-dir :which-key "create dir")
    "C-c C-f" '(treemacs-create-file :which-key "create file")
    "C-c SPC" '(treemacs-select-window :which-key "focus on treemacs")
   ;; Add more keybindings as needed
   )
)

(general-define-key
         :keymaps '(treemacs)
         :prefix "t"
         :global-prefix "C-SPC"
         :non-normal-prefix "M-SPC"

    "d" '(treemacs-delete-file :which-key "delete file")
    "c" '(treemacs-create-dir :which-key "create dir")
  )

(use-package projectile
  :ensure t
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
  :ensure t
  :config (counsel-projectile-mode))

;(use-package magit
;  :custom
;  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
;  )

(use-package cdlatex
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'org-cdlatex-mode)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.0))
  (setq org-preview-latex-default-process 'dvisvgm) ;No blur when scaling
  (defun my/text-scale-adjust-latex-previews ()
    "Adjust the size of latex preview fragments when changing the
buffer's text scale."
    (pcase major-mode
      ('latex-mode
       (dolist (ov (overlays-in (point-min) (point-max)))
         (if (eq (overlay-get ov 'category)
                 'preview-overlay)
             (my/text-scale--resize-fragment ov))))
      ('org-mode
       (dolist (ov (overlays-in (point-min) (point-max)))
         (if (eq (overlay-get ov 'org-overlay-type)
                 'org-latex-overlay)
             (my/text-scale--resize-fragment ov))))))

  (defun my/text-scale--resize-fragment (ov)
    (overlay-put
     ov 'display
     (cons 'image
           (plist-put
            (cdr (overlay-get ov 'display))
            :scale (+ 1.2 (* 0.25 text-scale-mode-amount))))))

  (add-hook 'text-scale-mode-hook #'my/text-scale-adjust-latex-previews)
  )

(use-package org-fragtog
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-fragtog-mode)
)

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-latex-title-command "\\begin{titlepage}
   \\begin{center}
       \\vspace*{1cm}

       \\textbf{%t}

       \\vspace{0.5cm}
        %s

       \\vspace{1.5cm}

       \\textbf{%a}

       \\vfill

       Преподователь: Токтамысов Сакен Жаугаштович 

       \\vspace{0.8cm}


       Российский Университет Дружбы народов

       Факультет физико-математических и естественных наук

       Москва,Россия, 2023


   \\end{center}
\\end{titlepage}
")



(use-package lsp-mode
  :ensure t
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
  :ensure t
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
  :ensure t
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

(use-package flycheck :ensure t)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(use-package haskell-mode
  :ensure t
  )

(setq telega-server-libs-prefix "/nix/store/pxgbyi8a3ngxnvn2xpkirrvf41645n58-tdlib-1.8.10")
 (eval-after-load "company"
'(add-to-list 'company-backends '(company-capf)))
(setq debug-on-error t)

(setq blog-path "~/Code/Blog/")
  (setq blog-static-path "~/Code/Blog/html/")
  (setq blog-content-path "~/Code/Blog/pages/")
  (setq kb-static-path "~/Notes/html")
  (setq kb-content-path "~/Notes/pages/")
  (setq kb-static-path "~/Notes/html/daily")
  (setq kb-content-path "~/Notes/journals/")
  (setq blog-templates "~/Code/Blog/assets/templates/")
  (setq org-publish-sitemap-sort-files 'anti-chronologically)
(setq org-export-with-section-numbers nil)

(defvar this-date-format "%b %d, %Y")
(defun blog/html-postamble (plist)
    "PLIST."
    (concat (format
             (with-temp-buffer
               (insert-file-contents (concat blog-templates "postamble.html")) (buffer-string))
             (format-time-string this-date-format (plist-get plist :time)) (plist-get plist :creator))))

  (defun blog/html-preamble (plist)
  "PLIST: An entry."
  (if (org-export-get-date plist this-date-format)
      (plist-put plist
                 :subtitle (format "Published on %s by %s."
                                   (org-export-get-date plist this-date-format)
                                   (car (plist-get plist :author)))))
  ;; Preamble
  (with-temp-buffer
    (insert-file-contents (concat blog-templates "preamble.html")) (buffer-string)))

(defun blog/html-index-preamble (plist)
  "PLIST: An entry."
  (if (org-export-get-date plist this-date-format)
      (plist-put plist
                 :subtitle (format "Published on %s by %s."
                                   (org-export-get-date plist this-date-format)
                                   (car (plist-get plist :author)))))
  ;; Preamble
  (with-temp-buffer
    (insert-file-contents (concat blog-templates "index-preamble.html")) (buffer-string)))

(defun me/org-sitemap-format-entry (entry style project)
    "Format posts with author and published data in the index page.

ENTRY: file-name
STYLE:
PROJECT: `posts in this case."
    (cond ((not (directory-name-p entry))
           (format "*[[file:%s][%s]]*
                 #+HTML: <p class='pubdate'>by %s on %s.</p>"
                   entry
                   (org-publish-find-title entry project)
                   (car (org-publish-find-property entry :author project))
                   (format-time-string this-date-format
                                       (org-publish-find-date entry project))))
          ((eq style 'tree) (file-name-nondirectory (directory-file-name entry)))
          (t entry)))

(setq me/music-preamble-path "./.music-preamble.org")
(defun me/org-sitemap-music-function (title list)
  "Takes path of other file to include into index.org before an index"
  "Generate the sitemap (Blog Music Page)"
  (concat "#+TITLE: " title "\n" 
          "#+INCLUDE:" me/music-preamble-path "\n" 
          (string-join (mapcar #'car (cdr list)) "\n\n"))

  )

(require 'ox-publish)


  (setq org-publish-project-alist
        `(
          ("blogposts"
           :base-directory ,(concat blog-content-path "posts")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path "posts")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :auto-sitemap t
           :sitemap-format-entry me/org-sitemap-format-entry
           :sitemap-filename "index.org"
           :sitemap-title "Blog Index"         
           :with-tags t
           :with-toc t
           :section-numbers: nil
           :table-of-contents t
           :html-head-include-default-style nil
           )
          ("portfolio"
           :base-directory ,(concat blog-content-path "portfolio")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path "portfolio")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :auto-sitemap t
           :sitemap-format-entry me/org-sitemap-format-entry
           :sitemap-filename "index.org"
           :sitemap-title "Portfolio"         
           :sitemap-style list
           :with-tags t
           :with-toc t
           :section-numbers: nil
           :table-of-contents nil
           :html-head-include-default-style nil
           )
          ("about"
           :base-directory ,(concat blog-content-path  "about")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path  "about")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :validation-link nil

           :section-numbers: nil
           :table-of-contents nil
           :with-toc nil
           :html-head-include-default-style nil
           )
          ("donate"
           :base-directory ,(concat blog-content-path  "donate")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path  "donate")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :validation-link nil
           :with-toc nil
           :table-of-contents nil
           :html-head-include-default-style nil
           :section-numbers: nil
           )
          ("projects"
           :base-directory ,(concat blog-content-path  "projects")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path  "projects")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :validation-link nil
           :table-of-contents nil
           :html-head-include-default-style nil
           :section-numbers: nil
           )


          ("blogstatic"
           :base-directory "~/Blog/pages/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "/home/horhik/Code/Blog/html/"
           :recursive t
           :publishing-function org-publish-attachment
           :section-numbers: nil
           )
          ("index"
           :base-directory ,(concat blog-content-path "")
           :base-extension "org"
           :publishing-directory ,(concat blog-static-path "")
           :publishing-function org-html-publish-to-html
           :site-toc nil

           :section-numbers: nil
           :table-of-contents: nil
           :auto-sitemap: t
           :sitemap-format-entry me/org-sitemap-format-entry
           :headline-levels 8             
           :html-preamble blog/html-index-preamble
           :html-postamble blog/html-postamble
           )
          ("music"
             :base-directory ,(concat blog-content-path "music")
             :base-extension "org"
             :publishing-directory ,(concat blog-static-path "music")
             :publishing-function org-html-publish-to-html
             :recursive t
             :headline-levels 8             
             :html-preamble blog/html-preamble
             :html-postamble blog/html-postamble
             :auto-sitemap t
             :sitemap-format-entry me/org-sitemap-format-entry
             :sitemap-filename "index.org"
             :sitemap-function me/org-sitemap-music-function
             :sitemap-title "Music"         
             :sitemap-style list
             :with-tags t
             :with-toc t
             :section-numbers: nil
             :table-of-contents nil
             :with-toc nil
             :html-head-include-default-style nil
             )
          ("Blog" :components ("blogposts" "blogstatic"   "about"  "index" "donate" "projects" "portfolio"))

          ("kb"
           :base-directory ,(concat kb-content-path  "")
           :base-extension "org"
           :publishing-directory ,(concat kb-static-path  "")
           :publishing-function org-html-publish-to-html
           :recursive t
           :headline-levels 8             
           :html-preamble blog/html-preamble
           :html-postamble blog/html-postamble
           :validation-link nil
           :table-of-contents nil
           :html-head-include-default-style nil
           )

          ("kb-static"
           :base-directory "~/Notes/pages/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "~/Notes/html/"
           :recursive t
           :publishing-function org-publish-attachment
           )
          ("KB" :components ("kb" "kb-static"))
;; ("daily"
;;            :base-directory ,(concat daily-content-path  "")
;;            :base-extension "org"
;;            :publishing-directory ,(concat daily-static-path  "")
;;            :publishing-function org-html-publish-to-html
;;            :recursive t
;;            :headline-levels 8             
;;            :html-preamble blog/html-preamble
;;            :html-postamble blog/html-postamble
;;            :validation-link nil
;;            :table-of-contents nil
;;            :html-head-include-default-style nil
;;            )

          ("daily-static"
           :base-directory "~/Notes/journals/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
           :publishing-directory "~/Notes/html/daily/"
           :recursive t
           :publishing-function org-publish-attachment
           )
          ("DAILY" :components ("daily" "daily-static"))

          )
        )

(defun roam-sitemap (title list)
  (concat "#+OPTIONS: ^:nil author:nil html-postamble:nil\n"
          "#+SETUPFILE: ./simple_inline.theme\n"
          "#+TITLE: " title "\n\n"
          (org-list-to-org list) "\nfile:sitemap.svg"))

(setq my-publish-time 0)   ; see the next section for context
(defun roam-publication-wrapper (plist filename pubdir)
  (org-roam-graph)
  (org-html-publish-to-html plist filename pubdir)
  (setq my-publish-time (cadr (current-time))))

(add-to-list 'org-publish-project-alist
  '("diary"
     :base-directory "~/Notes/journals"
     :auto-sitemap t
     :sitemap-title "Diary"
     :publishing-directory "~/Notes/html/journals"
      :validation-link nil
      :with-toc nil
      :table-of-contents nil
      :html-head-include-default-style nil
     :style "<link rel=\"stylesheet\" href=\"/home/horhik/Blog/assets/site.css\" type=\"text/css\">"))

(use-package direnv)
(use-package ox-reveal)
(use-package nerd-icons)
