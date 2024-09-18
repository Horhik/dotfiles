;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/GTD")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; Org Roam - Personal
;;(setq org-roam-directory "~/Notes/pages")
;;(setq org-roam-db-location "~/Notes/notes.org")
;;(setq org-roam-dailies-directory "~/Notes/journals/")

;; Org Roam - DND
(setq org-roam-directory "~/Documents/CandleKeep/pages")
(setq org-roam-db-location "~/Documents/CandleKeep/database.db")
(setq org-roam-dailies-directory "~/Documents/CandleKeep/sessions")


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

(use-package! org
  :config
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

  )


(after! org (setq org-startup-with-latex-preview t))


(use-package! org-fragtog
:after org
:hook (org-mode . org-fragtog-mode) ; this auto-enables it when you enter an org-buffer, remove if you do not want this
;:config
;; whatever you want
)

(setq org-preview-latex-default-process 'dvisvgm)
(setq org-latex-create-formula-image-program 'dvisvgm)

(after! org
  (setq org-preview-latex-process-alist
        '((dvisvgm :programs ("latex" "dvisvgm")
                   :description "dvi > svg"
                   :message "you need to install the programs: latex and dvisvgm"
                   :image-input-type "dvi"
                   :image-output-type "svg"
                   :image-size-adjust (1.7 . 1.5)
                   :latex-compiler
                   ("/usr/bin/latex -interaction nonstopmode -output-directory %o %f")
                   :image-converter
                   ("/usr/bin/dvisvgm %f -n -b min -c %S -o %O")))))

(setq org-latex-create-formula-image-program 'dvisvgm
      org-preview-latex-default-process 'dvisvgm
      org-latex-preview-ltxpng-directory "/tmp/org-preview/"
      )
(setq org-latex-preview-ltxpng-standalone t)
;;(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.7))

(map! :leader
      :desc "Open GTD inbox"
      "t t i" #'(lambda () (interactive) (find-file "~/GTD/inbox.org"))
      :desc "Open GTD tasks"
      "t t t" #'(lambda () (interactive) (find-file "~/GTD/tasks.org"))
      :desc "Open GTD project list"
      "t t p" #'(lambda () (interactive) (find-file "~/GTD/projects.org"))
      :desc "Open Listen list"
      "t t l" #'(lambda () (interactive) (find-file "~/GTD/listen.org"))
      :desc "Open Watch list"
      "t t w" #'(lambda () (interactive) (find-file "~/GTD/watchlist.org"))
      :desc "Open Read list"
      "t t r" #'(lambda () (interactive) (find-file "~/GTD/readlist.org"))
      )


(map! :leader
      :desc "Open Sway config"
      "f o s" #'(lambda () (interactive) (find-file "~/.config/sway/config"))
            )

(use-package company
    :defer 0.1
    :config
    (global-company-mode t)
    (setq-default
        company-idle-delay 0.05
        company-require-match nil
        company-minimum-prefix-length 0

        ;; get only preview
        company-frontends '(company-preview-frontend)
        ;; also get a drop down
        ;; company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
        ))


(use-package codeium
    ;; if you use straight
    ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
    ;; otherwise, make sure that the codeium.el file is on load-path

    :init
    ;; use globally
    (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
    ;; or on a hook
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

    ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions
    ;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
    ;; an async company-backend is coming soon!

    ;; codeium-completion-at-point is autoloaded, but you can
    ;; optionally set a timer, which might speed up things as the
    ;; codeium local language server takes ~0.2s to start up
    ;; (add-hook 'emacs-startup-hook
    ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

    ;; :defer t ;; lazy loading, if you want
    :config
    (setq use-dialog-box nil) ;; do not use popup boxes

    ;; if you don't want to use customize to save the api-key
    ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

    ;; get codeium status in the modeline
    (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
    (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t))

(after! rtags
  (setq rtags-autostart-diagnostics t
        rtags-completions-enabled t
        rtags-use-helm t)
  (add-hook 'c-mode-common-hook #'rtags-start-process-unless-running)
  (add-hook 'c++-mode-common-hook #'rtags-start-process-unless-running))
