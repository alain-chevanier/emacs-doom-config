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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

(setq doom-localleader-key ",")

 ;; save buffers after renaming

 ;; set default font size to 22 pts
(set-face-attribute 'default nil :height 200)

 ;; start default windows size to fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

 ;; user 2 spaces tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

 ;; support for lombok in java
(setq lsp-java-vmargs `(
                        "-XX:+UseParallelGC"
                        "-XX:GCTimeRatio=4"
                        "-XX:AdaptiveSizePolicyWeight=90"
                        "-Dsun.zip.disableMemoryMapping=true"
                        "-Xmx1G"
                        "-Xms100m"
                        ,(concat "-javaagent:"  "/Users/ricchyalainperezchevanier/.m2/repository/org/projectlombok/lombok/1.18.26/lombok-1.18.26.jar")))

;; code snippets (mainly for java)
(use-package! yasnippet
  :config (yas-global-mode))

;; Enable lenses for java
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;; paredit for common lisp
(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

 ;; use rainbow delimiters in all  programming modes
(use-package! rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))



;; Org mode config

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))


(use-package! org
  ; :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))



(use-package lsp-mode
  :ensure nil
  :hook
  (('clojure-mode-hook . lsp-semantic-tokens-mode)))
