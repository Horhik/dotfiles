(setq max-lisp-eval-depth 10000)
      (require 'package)
      (add-to-list 'package-archives
                   '("melpa" . "http://melpa.org/packages/") t)
      (add-to-list 'package-archives
                   '("melpa" . "http://melpa.org/packages/") t)


      (package-initialize)

      (unless package-archive-contents
        (package-refresh-contents))


      (defvar package-list
        '(gruvbox-theme))

      (dolist (p package-list)
        (when (not (package-installed-p p))
          (package-install p)))


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
  (setq package-enable-at-startup nil)
  (setq straight-use-package-by-default t)
(straight-use-package 'org) 

(straight-use-package 'use-package)

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

(require 'use-package)
    ;;     (custom-set-variables
    ;;    ;; custom-set-variables was added by Custom.
    ;;    ;; If you edit it by hand, you could mess it up, so be careful.
    ;;    ;; Your init file should contain only one such instance.
    ;;    ;; If there is more than one, they won't work right.
    ;;    '(custom-safe-themes
    ;;      '("75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
    ;;    '(package-selected-packages
    ;;      '(neotree treemacs-persp spaceline-all-the-icons all-the-icons-ivy-rich all-the-icons-ivy treemacs-the-icons dired-icon treemacs-magit treemacs-projectile nlinum linum-mode unicode-fonts ewal-doom-themes ivy-rich which-key counsel org-roam treemacs-evil treemacs-all-the-icons treemacs use-package general gruvbox-theme flycheck-rust cargo linum-relative ac-racer lusty-explorer doom-modeline doom-themes rainbow-delimiters evil-mc rustic lsp-mode avy)))
(use-package gruvbox-theme
      :ensure t
      )
  (load-theme 'gruvbox-dark-hard t)

      ;; (use-package gruvbox-theme
      ;;   :ensure t
      ;;   :config
      ;;   (load-theme 'doom-gruvbox)
      ;;   )
      (setq use-package-always-ensure t)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

;; Line numbers
(column-number-mode)

;; Default fonts
(add-to-list 'default-frame-alist '(font . "Mononoki Nerd Font" ))
(set-face-attribute 'default t :font "Mononoki Nerd Font" )

;;(set-fontset-font "fontset-startup" 'unicode
;;		  (font-spec :name "Mononoki Nerd Font" :size 14))
(when (member "Twitter Color Emoji" (font-family-list))
  (set-fontset-font t 'unicode "Twitter Color Emoji" nil 'prepend))

(when (member "Twemoji" (font-family-list))
  (set-fontset-font t 'unicode "Twemoji" nil 'prepend))
;; ☺️ ☻ 😃 😄 😅 😆 😊 😎 😇 😈 😏 🤣 🤩 🤪 🥳 😁 😀 😂 🤠 🤡 🤑 🤓 🤖 😗 😚 😘 😙 😉 🤗 😍 🥰 🤤 😋 🤔 🤨 🧐 🤭 🤫 😯 🤐 😌 😖 😕 😳 😔 🤥 🥴 😮 😲 🤯 😩 😫 🥱 😪 😴 😵 ☹️ 😦 😞 😥 😟 😢 😭 🤢 🤮 😷 🤒 🤕 🥵 🥶 🥺 😬 😓 😰 😨 😱 😒 😠 😡 😤 😣 😧 🤬 😸 😹 😺 😻 😼 😽 😾 😿 🙀 🙈 🙉 🙊 🤦 🤷 🙅 🙆 🙋 🙌 🙍 🙎 🙇 🙏 👯 💃 🕺 🤳 💇 💈 💆 🧖 🧘 🧍 🧎 👰 🤰 🤱 👶 🧒 👦 👧 👩 👨 🧑 🧔 🧓 👴 👵 👤 👥 👪 👫 👬 👭 👱 👳 👲 🧕 👸 🤴 🎅 🤶 🧏 🦻 🦮 🦯 🦺 🦼 🦽 🦾 🦿 🤵 👮 👷 💁 💂 🕴 🕵️ 🦸 🦹 🧙 🧚 🧜 🧝 🧞 🧛 🧟 👼 👿 👻 👹 👺 👽 👾 🛸 💀 ☠️ 🕱 🧠 🦴 👁 👀 👂 👃 👄 🗢 👅 🦷 🦵 🦶 💭 🗬 🗭 💬 🗨 🗩 💦 💧 💢 💫 💤 💨 💥 💪 🗲 🔥 💡 💩 💯 
;; Fallback for emojies

(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda ()
                   (display-line-numbers-mode 1)
                   (setq display-line-numbers 'relative))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))
  '(lambda ()
       (setq org-file-apps
         '((auto-mode . emacs)
           ("\\.mm\\'" . default)
           ("\\.x?html?\\'" . default)
           ("\\.pdf\\'" . "evince %s"))))
  )

(use-package highlight-parentheses
  :ensure t
  :init
  (global-highlight-parentheses-mode t)
  (show-paren-mode t))			;
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(global-prettify-symbols-mode +1)

(use-package all-the-icons)
(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
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
  (ivy-mode 1)
  )

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



(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


(use-package magit)

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
    (treemacs-create-icon :file "emacs.png"              :fallback "💜"     :extensions ("el" "elc" ".spacemacs" "doom" "spacemacs.env" ))
    (treemacs-create-icon :file "emacs.png"              :fallback "💜"     :extensions ("el" "elc"))
    (treemacs-create-icon :file "markdown.png"           :fallback "📖"     :extensions ("md"))
    (treemacs-create-icon :file "readme.png"             :fallback "📖"     :extensions ("readme.md" "README.md" "README" "readme"))
    (treemacs-create-icon :file "editorconfig.png"       :fallback "📖"     :extensions ("editorconfig"))
    (treemacs-create-icon :file "org.png"                :fallback "🐴"     :extensions ("org"))
    (treemacs-create-icon :file "rust.png"               :fallback "🐴"     :extensions ("rs"))
    (treemacs-create-icon :file "dart.png"               :fallback "🐴"     :extensions ("dart"))
    (treemacs-create-icon :file "dart.png"               :fallback "🐴"     :extensions ("dt"))
    (treemacs-create-icon :file "haskell.png"            :fallback "🐴"     :extensions ("hs" "haskell"))
    (treemacs-create-icon :file "c.png"                  :fallback "🐴"     :extensions ("c"))
    (treemacs-create-icon :file "cpp.png"                :fallback "🐴"     :extensions ("cpp" "c++" "C" "cxx" "cc"))
    (treemacs-create-icon :file "nix.png"                :fallback "🐴"     :extensions ("nix"))
    (treemacs-create-icon :file "lock.png"                :fallback "🐴"     :extensions ("lock" "lck"))
    (treemacs-create-icon :file "ocaml.png"                :fallback "🐴"     :extensions ("ocaml" "ml"))
    (treemacs-create-icon :file "h.png"                  :fallback "🐴"     :extensions ("h"))
    (treemacs-create-icon :file "diff.png"               :fallback "🐴"     :extensions ("diff"))
    (treemacs-create-icon :file "makefile.png"           :fallback "🐴"     :extensions ("mk" "make" "Makefile"))
    (treemacs-create-icon :file "assembly.png"           :fallback "🐴"     :extensions ("bin" "so" "o"))
    (treemacs-create-icon :file "document.png"           :fallback "🐴"     :extensions ("" "txt"))
    (treemacs-create-icon :file "file.png"               :fallback "🐴"     :extensions (fallback))
    (treemacs-create-icon :file "toml.png"               :fallback "🗃️"     :extensions ("toml"))
    (treemacs-create-icon :file "json.png"               :fallback "🗃️"     :extensions ("json"))
    (treemacs-create-icon :file "yaml.png"               :fallback "🗃️"     :extensions ("yml" "yaml"))
    (treemacs-create-icon :file "vim.png"                :fallback "🗃️"     :extensions ("vim" "vi" "nvim" ".viminfo" ".vimrc" ))
    (treemacs-create-icon :file "video.png"              :fallback "🗃️"     :extensions ("mp4" "avi" "gif" "mpv"))
    (treemacs-create-icon :file "audio.png"              :fallback "🗃️"     :extensions ("mp3" "ogg" "wav" ))
    (treemacs-create-icon :file "image.png"              :fallback "🗃️"     :extensions ("png" "jpg"))
    (treemacs-create-icon :file "svg.png"                :fallback "🗃️"     :extensions ("svg"))
    (treemacs-create-icon :file "css.png"                :fallback "🗃️"     :extensions ("css"))
    (treemacs-create-icon :file "console.png"            :fallback "🗃️"     :extensions ("bash" "sh" "install" "setup"))
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
    (treemacs-create-icon :file "python.png"                 :fallback "🗃️"     :extensions ("py" "python"))))

(treemacs-load-theme 'Material)

(use-package undo-tree
:init
(global-undo-tree-mode)
  )
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
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

(use-package which-key
      :init (which-key-mode)
      :diminish which-key-mode
      :config
      (setq which-key-idle-delay 0.3))



;;    (use-package ivy-rich
;;      :init
;;      (ivy-rich-mode 1))
;;

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;;(use-package company-box
 ;; :hook (company-mode . company-box-mode))

;;     (use-package ivy-postframe
;;     :init
;;   (ivy-posframe-mode 1)
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;;   ;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;; )

(use-package general)
  (general-evil-setup)

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
  (use-package counsel
    :general
    ("C-x b" '(counsel-switch-buffer :which-key "switch buff"))
    :bind (("C-M-j" . 'counsel-switch-buffer)
           ("C-x b" . 'counsel-switch-buffer)
           ("C-x C-b" . 'counsel-switch-buffer)
           :map minibuffer-local-map
           ("C-r" . 'counsel-minibuffer-history))
    :config
    (counsel-mode 1))
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
  ;;(add-to-map "TAB" 'company-indent-or-complete-common)
  (defun open-file (file)
    "just more shortest function for opening the file"
    (interactive)
    ((lambda (file) (interactive)
       (find-file (expand-file-name (format "%s" file)))) file ) )


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
    "f b"  '(lambda() (interactive) (find-file "~/Notes")                           :which-key "my brain")
    )

(general-nmap "C-x b" (general-simulate-key "SPC b b"))

;;  (lambda ()
  ;;    (push '("TODO" . ?📥) prettify-symbols-alist)
  ;;    (push '("DONE" . ?☑) prettify-symbols-alist)
  ;;    (push '("NEXT" . ?⏭) prettify-symbols-alist)
  ;;    (push '("IDEA" . ?💡) prettify-symbols-alist)
  ;;    (push '("DREAM" . ?✨) prettify-symbols-alist)
  ;;  )

(setq-default prettify-symbols-alist
                '(("#+BEGIN_SRC"     . "λ")
                  ("#+END_SRC"       . "λ")
                  ("#+end_src"       . "λ")
                  ("#+begin_src"     . "λ")
                  ("TODO"." 🕤 ")
                  ("DONE"." ✅ ")
                  ("INBOX"." 📥 ")
                  ("IDEA"." 💡 ")
                  ("READ"." 🔖 ")
                  ("DREAM"." ✨ ")
                  (":LOGBOOK:"." LOG ")
                  ))

(defun my/org-toggle-todo-and-fold ()
  (interactive)
  (save-excursion
    (org-back-to-heading t) ;; Make sure command works even if point is
                            ;; below target heading
    (cond ((looking-at "\*+ TODO")
           (org-todo "DONE")
	        (sleep-for 0.5)
           (org-archive-subtree-default-with-confirmation)
           )
          ((looking-at "\*+ DONE")
           (org-todo "TODO")
           (hide-subtree))
          (t (message "Can only toggle between TODO and DONE.")))))

(set-face-attribute 'variable-pitch nil
                    ;; :font "Cantarell"
                    :font "Hack"
                    :height 1.3
                    :weight 'light)

(set-face-attribute 'org-document-title nil :font "ubuntu" :weight 'bold :height 1.3)
(dolist (face '((org-level-1 . 1.1)
		(org-level-2 . 0.9)
		(org-level-3 . 0.8)
		(org-level-4 . 0.8)
		(org-level-5 . 0.8)
		(org-level-6 . 0.8)
		(org-level-7 . 0.8)
		(org-level-8 . 0.8)))
  (set-face-attribute (car face) nil :font "ubuntu" :weight 'bold :height (cdr face) ))
(require 'org-indent)
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch :font "Hack" )
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

(use-package org-roam
:straight
:ensure t
:custom
(org-roam-directory (file-truename "~/Documents/KB/"))
:bind (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n g" . org-roam-graph)
       ("C-c n i" . org-roam-node-insert)
       ("C-c n c" . org-roam-capture)
       ;; Dailies
       ("C-c n j" . org-roam-dailies-capture-today))
:config
;; If you're using a vertical completion framework, you might want a more informative completion interface
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
(org-roam-db-autosync-mode)
;; If using org-roam-protocol
(require 'org-roam-protocol))

 ; (setq org-roam-v2-ack t)

(setq org-roam-directory (file-truename "~/Documents/KB"))

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

(setq org-agenda-settings '(
   ("d" "Dashboard 📜"
    (
     (tags "@morning"  ((org-agenda-overriding-header "Eat the Frog 🐸"))) 
     (todo "NEXT"      ((org-agenda-overriding-header "Next Tasks ⏩"))) 
     (todo "WAIT"      ((org-agenda-overriding-header "Waiting tasks ⏰"))) 
     (agenda ""        ((org-deadline-warning-days 14))) 
     (todo "PROJECT"   ((org-agenda-overriding-header "Active Projects ")))
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
   ("ss" "On studies 🏫" tags-todo "+@school/NEXT"   ((org-agenda-overriding-header "On studies 🏫")))
   ("so" "Online 🌐" tags-todo "+@online/NEXT"   ((org-agenda-overriding-header "Online 🌐")))
   ("sO" "‍Outdoors🚶‍" tags-todo "+@outdoors/NEXT" ((org-agenda-overriding-header "‍Outdoors🚶‍")))
   ("sT" "To takeaway 👝 " tags-todo "+takeaway"  ((org-agenda-overriding-header "To takeaway 👝 ")))
 )
)

(defun my/org-mode-setup()
    (auto-fill-mode 0)
    (visual-line-mode 1)
    (setq evil-auto-indent 1)
    (variable-pitch-mode t)
    (prettify-symbols-mode +1)
    (display-line-numbers-mode 0)
    )

  (use-package pdf-tools
    :defer t
    )
  (use-package org  :demand t
    :load-path "~/.emacs.d/elpa/org-9.5.4/"
    :hook ((org-mode . my/org-mode-setup)
           (org-mode . variable-pitch-mode)
           (org-mode . org-indent-mode)
           (org-mode . prettify-symbols-mode)
           )
    :config (setq org-agenda-files `("~/Documents/GTD")) 
    (display-line-numbers-mode 0)
    ;(org-bullets-mode t) 
    ;(org-indent-mode t)
    ;(setq org-ellipsis " ▸" org-hide-emphasis-markers t org-src-fontify-natively t
    ;      org-src-tab-acts-natively t org-edit-src-content-indentation 2 org-hide-block-startup nil
    ;      org-src-preserve-indentation nil org-startup-folded 'content org-cycle-separator-lines 2) 
    (setq org-agenda-start-with-log-mode t) 
    (setq org-log-done 'time) 
    (setq org-log-into-drawer t)
    (setq org-todo-keyword-faces '(("TODO" . org-warning) 
                                   ("STARTED" . "yellow") 
                                   ("DREAM" . "pink") 
                                   ("PROJECT" . "pink") 
                                   ("IDEA" . "gold") 
                                   ("READ" . "violet") 
                                   ("ARTICLE" . "lightblue") 
                                   ("CANCELED" . 
                                    (:foreground "blue" 
                                                 :weight bold))))

    (setq org-todo-keywords '((sequence "INBOX(i)" "PROJECT(p)" "TODO(t)" "NEXT(n)" "CAL(c)" "WAIT(w@/!)" "|" "DONE(d!)" "CANC(k@)") 
                              ))
  (setq org-agenda-custom-commands org-agenda-settings)


  :general (general-nmap :prefix "SPC a" 
             :keymap 'org-agenda-mode-map 
             "a" 'org-agenda
             "d" 'my/org-toggle-todo-and-fold
             ))
(use-package org-bullets
  :after org
  :hook
  ((org-mode . org-bullets-mode)
   )
  )

(defun my/visual-fill ()
  (setq visual-fill-column-width 300
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
(use-package visual-fill-column
  :defer t
  :hook (org-mode . my/visual-fill))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json"))

(use-package flycheck
  :init
  ;;(flycheck-c/c++-clang-executable "c/c++-clang" "~/code/competitive/clang++")

)
(use-package flycheck-irony
  :after flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
)

(use-package lsp-mode
      :init 
      (setq lsp-keymap-prefix "C-SPC c")
;;      (setq lsp-clients-clangd-args " --header-insertion-decorators=0 ")
      ;;(setq lsp-client-packages nil)
      :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c++-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
      :config
           (add-hook 'c\+\+-mode-hook #'lsp-mode)
           (add-hook 'rust-mode-hook #'lsp-mode)
           (add-hook 'c-mode-hook #'lsp-mode)

      ;;(setq lsp-clients-clangd-executable "/home/horhik/code/competitive/clangd")
      ;;(setq lsp-clients-clangd-default-executable "/home/horhik/code/competitive/clangd")
      ;;(lsp-mode . lsp-enable-which-key-integration)
      :commands (lsp lsp-deferred)
      )
    (use-package lsp-treemacs
      :after lsp-mode
      )
  (use-package lsp-ivy)
  (use-package lsp-ui
  :after lsp)
  ;;(use-package company-lsp
  ;;:ensure t
  ;;:commands company-lsp
  ;;:config (push 'company-lsp company-backends))

(use-package irony
                 :init
                 (add-hook 'c++-mode-hook 'irony-mode)
                 (add-hook 'c-mode-hook 'irony-mode)
                 (add-hook 'objc-mode-hook 'irony-mode)
                 (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
                 (setq irony-additional-clang-options
                (append '("-std=c++17") irony-additional-clang-options))
                 )


     (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
     (add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))
     (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
     (add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))
;use-package ccls
; :ensure t
; :config
; (setq ccls-executable "ccls")
; (setq lsp-prefer-flymake nil)
; (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
; :hook ((c-mode c++-mode objc-mode) .
;        (lambda () (require 'ccls) (lsp))))

(use-package markdown-mode)

(use-package tuareg)

;;     (use-package direnv
  ;;      :config
  ;;      (direnv-mode))
  ;;   (add-hook 'lsp-mode-hook #'direnv-update-environment)
(use-package nix-mode)

(use-package mastodon
:config
  (setq mastodon-instance-url "https://mastodon.ml")
)

;(org-agenda)
