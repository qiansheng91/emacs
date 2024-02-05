(use-package eglot
	:ensure t
	:defer t
	:hook
	(python-mode . eglot-ensure)
	(java-mode . eglot-ensure)
	(go-mode . eglot-ensure))



;; key binding
(use-package emacs
	:general
	(my-leader-def
		"c" '(:ignore t :which-key "code")))

(provide 'init-progn)
