;; (use-package eglot
;; 	:hook
;; 	((python-mode . eglot-ensure)
;; 	 (typescript-mode . eglot-ensure)
;; 	 (js2-mode . eglot-ensure)
;; 	 (json-mode . eglot-ensure)
;; 	 (java-mode . eglot-ensure)
;; 	 (css-mode . eglot-ensure)
;; 	 (yaml-mode . eglot-ensure)
;; 	 (bash-mode . eglot-ensure)))
	
(use-package treesit-auto
  :demand t
  :config
  (global-treesit-auto-mode))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :ensure t
	:config
	(add-hook 'prog-mode-hook 'copilot-mode)
	(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
	(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

(use-package dape
  :ensure t
  :init
  ;; To use window configuration like gud (gdb-mi)
  (setq dape-buffer-window-arrangement 'gud)
  ;; To save breakpoints and exceptions with `savehist-mode'
  (setq dape-use-savehist t)
  :config
  (setq dape-buffer-window-arrangement 'right)
  ;; To not display info and/or buffers on startup
  ;; (remove-hook 'dape-on-start-hooks 'dape-info)
  ;; (remove-hook 'dape-on-start-hooks 'dape-repl)

  ;; To display info and/or repl buffers on stopped
  ;; (add-hook 'dape-on-stopped-hooks 'dape-info)
  ;; (add-hook 'dape-on-stopped-hooks 'dape-repl)

  ;; Kill compile buffer on build success
  ;; (add-hook 'dape-compile-compile-hooks 'kill-buffer)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-on-start-hooks
  ;;           (defun dape--save-on-start ()
  ;;             (save-some-buffers t t)))

  ;; Projectile users
  (setq dape-cwd-fn 'projectile-project-root))


;; key binding
(use-package emacs
	:general

  ;; for code
	(my-leader-def 'normal prog-mode-map
		"c" '(:ignore t :which-key "code")
		"ca" '(eglot-code-actions :which-key "action")
		"cd" '(xref-find-definitions :which-key "definition")
		"cr" '(xref-find-references :which-key "references")
		"ci" '(eglot-find-implementation :which-key "implementations"))

	;; for debug
	(my-leader-def 'normal prog-mode-map
	  "d" '(:ignore t :which-key "debug")
	  "dd" '(dape :which-key "debug")
	  "db" '(:ignore t :which-key "breakpoint")
	  "dbt" '(dape-toggle-breakpoint :which-key "toggle")
	  "dbd" '(dape-delete-breakpoint :which-key "delete")
	  "dbn" '(dape-next-breakpoint :which-key "next")
	  "dbp" '(dape-previous-breakpoint :which-key "previous")
	  "dbf" '(dape-first-breakpoint :which-key "first")
	  "dbl" '(dape-last-breakpoint :which-key "last")
	  "de" '(:ignore t :which-key "exception")
	  "det" '(dape-toggle-exception :which-key "toggle")
	  "del" '(dape-list-exceptions :which-key "list")
	  "den" '(dape-next-exception :which-key "next")
	  "dep" '(dape-previous-exception :which-key "previous")
	  "def" '(dape-first-exception :which-key "first")
	  "del" '(dape-last-exception :which-key "last")
	  "dr" '(:ignore t :which-key "repl")
	  "dre" '(dape-repl :which-key "start")
	  "drk" '(dape-kill-repl :which-key "kill")
	  "drl" '(dape-repl-send-line :which-key "send line")
	  "drb" '(dape-repl-send-buffer :which-key "send buffer")
	  ))


(provide 'init-progn)
