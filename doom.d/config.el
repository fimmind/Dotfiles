;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Serafim Vinogrondskiy"
      user-mail-address "fimmind@mail.ru"
      doom-theme 'doom-nord
      doom-font (font-spec :family "Source Code Pro" :size 13)
      org-directory "~/org/"
      projectile-project-search-path '("~/Code/" "~/Code/New/")
      display-line-numbers-type 'relative
      sh-shell 'fish
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      company-show-numbers t
      default-input-method "japanese-skk")

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

(after! vterm
  (map! :map vterm-mode-map
        :ni "C-j" 'vterm-send-return))

(after! lsp-mode
  (setq lsp-rust-analyzer-import-merge-behaviour "last"))

(map! :nv [remap evil-next-line] 'evil-next-visual-line
      :nv [remap evil-previous-line] 'evil-previous-visual-line)

(add-hook! 'doom-load-theme-hook :append
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font
     t charset (font-spec :family "Source Han Serif JP"))))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode))

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
