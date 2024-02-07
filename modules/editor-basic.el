(use-package emacs
	:init
	(setq inhibit-startup-screen t
				initial-scratch-message nil
				sentence-end-double-space nil
				ring-bell-function 'ignore
				frame-resize-pixelwise t)

	(add-to-list 'initial-frame-alist '(fullscreen . maximized))
	(add-hook 'window-setup-hook #'toggle-frame-maximized)

	(setq read-process-output-max (* 1024 1024))
	(defalias 'yes-or-no-p 'y-or-n-p)

	(set-charset-priority 'unicode)
	(setq locale-coding-system 'utf-8
				coding-system-for-read 'utf-8
				coding-system-for-write 'utf-8)
	(set-terminal-coding-system 'utf-8)
	(set-keyboard-coding-system 'utf-8)
	(set-selection-coding-system 'utf-8)
	(prefer-coding-system 'utf-8)
	(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
	(delete-selection-mode t)

	(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
	(setq custom-file (make-temp-file ""))
	(setq custom-safe-themes t)
	(setq enable-local-variables :all)

	(setq make-backup-files nil
				auto-save-default nil
				create-lockfiles nil)

	(setq vc-follow-symlinks t)

	(tool-bar-mode -1)
	(toggle-scroll-bar -1)
	(when (eq system-type 'gnu/linux)
		(menu-bar-mode -1))
	(winner-mode t)
	(show-paren-mode t)

	(setq byte-compile-warnings '(not fRee-vars unresolved noruntime lexical make-local))
	(setq native-comp-async-report-warNings-errors nil)
	(setq load-prefer-newer t)

	(display-time-mode -1)
	(setq column-number-mode t)

	(setq-default indent-tabs-mode t)
	(setq-default tab-width 2)

	(setq tab-always-indent 'complete))


(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package format-all
	:commands format-all-mode
	:hook ((prog-mode . format-all-mode)
				 (before-save . format-all-buffer)))

(use-package gcmh
	:demand
	:config
	(gcmh-mode 1))

(use-package recentf
	:config
	(recentf-mode 1)
	(add-hook 'after-init-hook 'recentf-load-list)
	(setq recentf-exclude `(,(expand-file-name ".local/" user-emacs-directory)
													,(expand-file-name "eln-cache/" user-emacs-directory)
													,(expand-file-name "etc/" user-emacs-directory)
													,(expand-file-name "var/" user-emacs-directory)))
	(setq recentf-max-saved-items 100)
	(run-at-time nil (* 5 60) 'recentf-save-list))

(use-package no-littering
  :init
	:ensure t
	:config
	(with-eval-after-load 'recentf
		(add-to-list 'recentf-exclude no-littering-var-directory)
		(add-to-list 'recentf-exclude no-littering-etc-directory)))

(use-package savehist
	:ensure t
  :init
  (savehist-mode))

(use-package general
	:ensure t
	:config
	(general-create-definer my-leader-def
		:prefix "SPC"))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package company
	:ensure t
	:config
	(global-company-mode)
	(setq company-idle-delay 0.1)
	(setq company-selection-wrap-around t))

(use-package which-key
	:ensure t
	:init
	(setq which-key-separator " ")
	(setq which-key-prefix-prefix "+")
	:config
	(which-key-mode))

(use-package marginalia
	:after vertico
	:init
	(setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
	(marginalia-mode)
	(with-eval-after-load 'projectile
		(add-to-list 'marginalia-command-categories '(projectile-find-file . file))))
(use-package embark
	:ensure t
	:after vertico
	:init
	(setq prefix-help-command #'embark-prefix-help-command)
	:config
	(add-to-list 'display-buffer-alist
							 '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
								 nil
								 (window-parameters (mode-line-format . none))))
	(add-hook 'embark-setup-hook 'selectrum-set-selected-candidate))

(use-package vertico
	:straight (vertico :files (:defaults "extensions/*")
										 :includes (vertico-indexed
																vertico-flat
																vertico-grid
																vertico-mouse
																vertico-quick
																vertico-buffer
																vertico-repeat
																vertico-reverse
																vertico-directory
																vertico-multiform
																vertico-unobtrusive))
	:ensure t
	:config
	(vertico-mode))

(use-package emacs
	:init
	(defun crm-indicator (args)
		(cons (format "[CRM%s] %s"
									(replace-regexp-in-string
									 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
									 crm-separator)
									(car args))
					(cdr args)))
	(advice-add #'completing-read-multiple :filter-args #'crm-indicator)
	(setq minibuffer-prompt-properties
				'(read-only t cursor-intangible t face minibuffer-prompt))
	(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
	(setq enable-recursive-minibuffers t))

(use-package orderless
	:init
	(setq completion-styles '(orderless basic)
				completion-category-defaults nil
				completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico-directory
	:after vertico
	:ensure t
	:bind (:map vertico-map
							("RET" . vertico-directory-enter)
							("DEL" . vertico-directory-delete-char)
							("M-DEL" . vertico-directory-delete-word))
	:hook (rfn-eshadow-update-overlay . vertico-directory-tidy))


(use-package consult
	:init
	(defvar consult-fd-exclude-dirs
		'(".git" "node_modules" "build" "__pycache__" "straight")
		"List of directory names to be excluded by consult-fd.")
	(defun consult-fd-exclude-dirs-args ()
		(mapconcat (lambda (dir) (concat "--exclude " dir))
							 consult-fd-exclude-dirs " "))
	:hook (completion-list-mode . consult-preview-at-point-mode)
	:init
	(setq register-preview-delay 0.5
				register-preview-function #'consult-register-format)
	(advice-add #'register-preview :override #'consult-register-window)
	(setq xref-show-xrefs-function #'consult-xref
				xref-show-definitions-function #'consult-xref)
	:config
	(consult-customize
	 consult-theme :preview-key '(:debounce 0.2 any)
	 consult-ripgrep consult-git-grep consult-grep
	 consult-bookmark consult-recent-file consult-xref
	 consult--source-bookmark consult--source-file-register
	 consult--source-recent-file consult--source-project-recent-file
	 :preview-key '(:debounce 0.4 any))
	(setq consult-narrow-key "<") ;; "C-+"
	(setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
	(autoload 'projectile-project-root "projectile")
	(setq consult-fd-args (concat "fd --color=never --full-path --hidden "
																(consult-fd-exclude-dirs-args)))

	(setq consult-project-function (lambda (_) (projectile-project-root))))

(use-package embark-consult
	:ensure t)

(use-package avy
	:ensure t
	:bind
	("C-:" . avy-goto-char)
	("C-'" . avy-goto-char-2))

(use-package expand-region
	:ensure t
	:bind ("C-=" . er/expand-region))

(use-package shell-pop
	:ensure t
	:custom
	(shell-pop-shell-type '("eshell" "*eshell*" (lambda ()
																								(eshell))))
	:config
	(setq shell-pop-window-size 30)
	(setq shell-pop-full-span t)
	(setq shell-pop-window-position "bottom")
	(add-to-list 'eshell-visual-commands "ssh")
	(add-to-list 'eshell-visual-commands "nano")
	(add-to-list 'eshell-visual-commands "tail")
	(add-to-list 'eshell-visual-commands "top")
	(add-to-list 'eshell-visual-commands "htop")
	(add-to-list 'eshell-visual-commands "prettyping")
	(add-to-list 'eshell-visual-commands "ncdu")
	(add-to-list 'eshell-visual-subcommands '("hg" "log" "diff")))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
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
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(provide 'editor-basic)
