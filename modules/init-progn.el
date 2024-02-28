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


(use-package jsonrpc
  :ensure t
  :straight (jsonrpc :type git :host github :repo "svaante/jsonrpc"))

;; key binding
(use-package emacs
	:general
	(my-leader-def 'normal
		"c" '(:ignore t :which-key "code")
		"ca" '(eglot-code-actions :which-key "action")
		"cd" '(xref-find-definitions :which-key "definition")
		"cr" '(xref-find-references :which-key "references")
		"ci" '(eglot-find-implementation :which-key "implementations")))

(provide 'init-progn)
