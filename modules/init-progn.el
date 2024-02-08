(use-package eglot
	:ensure t
	:defer t
	:hook
	(python-mode . eglot-ensure)
	(java-mode . eglot-ensure)
	(go-mode . eglot-ensure))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :ensure t
	:config
	(add-hook 'prog-mode-hook 'copilot-mode))

;; key binding
(use-package emacs
	:general
	(my-leader-def 'normal
		"c" '(:ignore t :which-key "code")
		"cd" '(xref-find-definitions :which-key "definition")
		"cr" '(xref-find-references :which-key "references")
		"ci" '(eglot-find-implementation :which-key "implementations")))

(provide 'init-progn)
