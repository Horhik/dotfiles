
;;; Emacs dotfile
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░█░█░█▀█░█▀▄░█░█░▀█▀░█░█░▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░█▀█░█░█░█▀▄░█▀█░░█░░█▀▄░░░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
;; ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
(require 'package)


(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))


(defvar package-list
  '( lsp-mode rustic evil-mc rainbow-delimiters doom-themes doom-modeline lusty-explorer ac-racer auto-complete all-the-icons linum-relative neotree racer cargo flycheck-rust rust-mode gruvbox-theme evil general use-package))

(dolist (p package-list)
  (when (not (package-installed-p p))
         (package-install p)))

;;(mapc
;; (lambda (package)
;;   (or (package-installed-p package)
;;     (package-install package)))
;; '( lsp-mode rustic evil-mc rainbow-delimiters doom-themes doom-modeline lusty-explorer ac-racer auto-complete all-the-icons linum-relative neotree racer cargo flycheck-rust rust-mode gruvbox-theme evil general))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d7684de9abb5a770fbfd72a14506d6b4add9a7d30942c6285f020d41d76e0fa" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" "b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" default))
 '(package-selected-packages
   '(spaceline lsp-mode rustic evil-mc rainbow-delimiters doom-themes doom-modeline lusty-explorer ac-racer auto-complete all-the-icons linum-relative neotree racer cargo flycheck-rust rust-mode gruvbox-theme evil ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'use-package)

;; AutoComplition
(ac-config-default)
(global-auto-complete-mode t)

;; Evil mode
(require 'evil)
(evil-mode 1)
(require 'evil-mc)
(evil-mc-mode  1) ;; enable


;; Appearance
;; Font
(add-to-list 'default-frame-alist '(font . "Mononoki Nerd Font" ))
(set-face-attribute 'default t :font "Mononoki Nerd Font" )
;; theme
(load-theme 'gruvbox-dark-medium)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1) 

(require 'linum-relative)
(setq display-line-numbers 'relative)
;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; mode line
(require 'doom-modeline)
(doom-modeline-mode 1)


;; KeyBindings
(require 'neotree)



(defun add-to-map(keys func)
  "Add a keybinding in evil mode from keys to func."
  (define-key evil-normal-state-map (kbd keys) func)
  (define-key evil-motion-state-map (kbd keys) func))

(add-to-map "<SPC>" nil)

(add-to-map "<SPC> f" 'lusty-file-explorer)
(add-to-map "<SPC> b" 'lusty-buffer-explorer)
(add-to-map "<SPC> o" 'neotree-toggle)
(add-to-map "<SPC> s" 'save-buffer)
(add-to-map "<SPC> <SPC>" 'execute-extended-command)

(defun open-file (file)
  "just more shortest function for opening the file"
  (interactive)
  ((lambda (file) (interactive)
		  (find-file (expand-file-name (format "%s" file)))) file ) )

(general-evil-setup)
(general-nmap
  :prefix "SPC"
  ;; dotfiles editing config
  "e e"  (lambda() (interactive) (find-file "~/.emacs"                          ))
  "e v"  (lambda() (interactive) (find-file "~/.config/nvim/init.vim"           ))
  "e d"  (lambda() (interactive) (find-file "~/dotfiles/home"                   ))
  "e a"  (lambda() (interactive) (find-file "~/.config/alacritty/alacritty.yml" ))
  ;; evil-mc
  "c u" 'evil-mc-undo-all-cursors
  "c j" 'evil-mc-make-and-goto-prev-cursor
  "c k" 'evil-mc-make-and-goto-next-cursor
  "c m" 'evil-mc-make-all-cursors
  )

;; bind in motion state (inherited by the normal, visual, and operator states)
(general-mmap
  "N" 'evil-mc-make-cursor-in-visual-selection-beg 
  )
;; alternatively, for shorter names
(general-evil-setup t)
(mmap)

(setq vc-follow-symlinks t)

;; Syntax
(require 'flycheck)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))



(add-hook 'after-init-hook (lambda() (interactive)))
(find-file "~/.emacs")
(setq inhibit-startup-message t) 
(setq initial-scratch-message ";; Happy Hacking")



;; Rust
(setq lsp-rust-server 'rust-analyzer)
