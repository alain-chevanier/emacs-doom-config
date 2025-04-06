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
(setq doom-theme 'doom-opera)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org-docs")

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

;; set default font size to 20 pts
;; (set-face-attribute 'default nil :font "JetBrains Mono" :weight 'light :height 200)
(setq read-process-output-max (* 1024 1024)
      projectile-project-search-path '("~/dev/nu")
      projectile-enable-caching nil)
(set-language-environment "UTF-8")
(setq doom-font (font-spec :family "JetBrains Mono" :size 20 :weight 'light))

;; start default windows size to fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Let the desktop background show through
(set-frame-parameter (selected-frame) 'alpha '(96 . 100))
(add-to-list 'default-frame-alist '(alpha . (96 . 96)))

;; GENERAL PROGRAMMING EDITION FORMATTING
;; user 2 spaces tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

(require 'lsp-java)

                ;; JAVA CONFIG
                ;; support for lombok in java
(setq lsp-java-vmargs `(
                        "-XX:+UseParallelGC"
                        "-XX:GCTimeRatio=4"
                        "-XX:AdaptiveSizePolicyWeight=90"
                        "-Dsun.zip.disableMemoryMapping=true"
                        "-Xmx1G"
                        "-Xms100m"
                        ,(concat "-javaagent:"  "/Users/alain.chevanier/.m2/repository/org/projectlombok/lombok/1.18.26/lombok-1.18.26.jar")))

;; Enable lenses for java
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
(add-hook 'java-mode-hook #'subword-mode)
;;(add-hook 'java-mode-hook #'yas-minor-mode)

;; use smartparens with java and c
(use-package! smartparens
  :hook ((java-mode . smartparens-mode)
         (c-mode . smartparens-mode)))

;; paredit for lisp family
(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

;; code snippets (mainly for java)
(use-package! yasnippet
  :config (yas-global-mode))

;; use rainbow delimiters in all  programming modes
(use-package! rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; ORG MODE Config
(require 'org)
(require 'org-bullets)
(require 'org-present)
(require 'ox-latex)
(require 'visual-fill-column)

(defun my-org-faces ()
  ;; (set-face-attribute 'org-todo nil :height 0.8)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :height 1.1)
  (set-face-attribute 'org-level-3 nil :height 1.05)
  (set-face-attribute 'org-level-4 nil :height 1.0)
  (set-face-attribute 'org-document-title nil :weight 'bold :height 1.4)
  (display-line-numbers-mode 0)
  (visual-fill-column-mode 1)
  (visual-fill-column-toggle-center-text))

(use-package! org
  :hook
  (org-mode . my-org-faces)
  
  :config
  ;; Nice bullet points in org mode
  (setq org-src-fontify-natively t
        org-ellipsis "▾"
        ;; let's personalize org heading bullets with custom characters
        org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
        org-hide-emphasis-markers t)

  ;; org-mode to use visual-fill-column
  (setq visual-fill-column-width 150)

  ;; config for org-mode to work nicely with minted for code syntax highligting
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-src-block-backend 'minted
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

(use-package! org-present
  :after org
  :hook
  ((org-present-mode      .    (lambda ()
                                 ;;(org-present-big)
                                 (setq header-line-format " ")
                                 (org-display-inline-images)
                                 ;;(org-present-hide-cursor)
                                 ;;(org-present-read-only)
                                 ))
   (org-present-mode-quit . (lambda ()
                              ;;(org-present-small)
                              (setq header-line-format nil)
                              (org-remove-inline-images)
                              ;;(org-present-show-cursor)
                              ;;(org-present-read-write)
                              ))))

;; NU CONFIG
(use-package! lsp-mode
  :commands lsp
  :config
  (add-hook 'lsp-after-apply-edits-hook (lambda (&rest _) (save-buffer)))) ;; save buffers after renaming
  (let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)))

(use-package! clojure-mode
  :config
  (setq lsp-semantic-tokens-enable t))

;; PLANTUML CONFIG
;; (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;; (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

;; GITHUB COPILOT CONFIG
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-<tab>"   . 'copilot-accept-completion)
              ("C-TAB"     . 'copilot-accept-completion)
              ("C-M-TAB"   . 'copilot-accept-completion-by-word)
              ("C-M-<tab>" . 'copilot-accept-completion-by-word)
              ;;("C-n"       . 'copilot-next-completion)
              ;;("C-p"       . 'copilot-previous-completion)
              )
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

;; install and configure copilot-chat
(use-package! copilot-chat
  :after (request org)
  :bind  (:map global-map
               ("C-c C-y"   . copilot-chat-yank)
               ;; ("C-c M-y"   . copilot-chat-yank-pop)
               ;; ("C-c C-M-y" . (lambda ()
               ;;                  (interactive)
               ;;                  (copilot-chat-yank-pop -1)))
               )
  )
