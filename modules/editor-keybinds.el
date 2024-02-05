(use-package emacs
	:general

	;; file
	(my-leader-def 'normal
		"f" '(:ignore t :which-key "file")
		"ff" '(find-file :which-key "find file"))

	;; buffer
	(my-leader-def 'normal
		"b" '(:ignore t :which-key "buffer")
		"bb" '(consult-buffer :which-key "find buffer")
		"bk" '(kill-current-buffer :which-key "kill buffer")
		"b[" '(evil-prev-buffer :which-key "previous buffer")
		"b]" '(evil-next-buffer :which-key "next buffer"))

	;; open
	(my-leader-def 'normal
		"o" '(:ignore t :which-key "open")
		"oe" '(shell-pop :which-key "eshell"))

	;; search
	(my-leader-def 'normal
		"s" '(:ignore t :which-key "search")
		"sl" '(consult-line :which-key "search current")
		"sa" '(consult-ripgrep :which-key "search anywhere")
		"sf" '(consult-find :which-key "search file"))

	;; project
	(my-leader-def 'normal
		"p" '(:ignore t :which-key "project")
		"pp" '(projectile-switch-project :which-key "switch project")
		"pa" '(projectile-add-known-project :which-key "add project"))
	)

(provide 'editor-keybinds)
