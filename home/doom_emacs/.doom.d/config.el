;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "Mononoki" :size 12)
       doom-variable-pitch-font (font-spec :family "Mononoki" :size 13)
       doom-unicode-font (font-spec :family "Joypixels" :size 13)
       )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


(custom-set-variables
 '(org-directory "~/Nextcloud")
 '(org-agenda-files (list org-directory))

 )
;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq emojify-display-style 'image)
(setq emojify-emoji-set "twemoji-v2")
(use-package emojify
  :hook (after-init . global-emojify-mode))

(add-to-list 'load-path "~/.emacs.d/manual-addons")

;; !!! это надо делать в конце файла, иначе модули перетирают настройки метода ввода
(if (eq system-type 'darwin)
    (setq russian-input-method "russian-no-windows")
  (setq russian-input-method "russian-computer"))
(setq-default default-input-method russian-input-method)
(setq default-input-method russian-input-method)
(set-input-method russian-input-method)

(global-set-key (kbd "M-SPC") 'toggle-input-method)
(define-key isearch-mode-map (kbd "M-SPC") 'toggle-input-method)
