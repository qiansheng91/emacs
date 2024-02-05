(use-package eglot-java
	:ensure t
	:config
	(add-hook 'java-mode-hook 'eglot-java-mode))


(use-package emacs
	:general
	(my-leader-def
		:keymaps 'eglot-java-mode-map
		"cn" '(eglot-java-file-new :which-key "new file")))

(provide 'init-java)
