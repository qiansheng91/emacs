(use-package emacs
	:general

	;; file
	(my-leader-def 'normal
		"f" '(:ignore t :which-key "file")
		"ff" '(find-file :which-key "find file")
		"f." '(consult-mark :which-key "travel"))

	;;
	(my-leader-def 'normal
		"SPC" '(consult-recent-file :which-key "recent file"))

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
		"oe" '(shell-pop :which-key "eshell")
		"oo" '(consult-buffer-other-window :which-key "other window"))

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

	;; window
	(my-leader-def 'normal
		"w" '(:ignore t :which-key "window")
		"wh" '(evil-window-left :which-key "left")
		"wj" '(evil-window-down :which-key "down")
		"wl" '(evil-window-right :which-key "right")
		"wk" '(evil-window-up :which-key "up")
		"wq" '(kill-buffer-and-window :which-key "kill current window")
		"wM" '(maximize-window :which-key "maximize")
		"wm" '(minimize-window :which-key "minimize")
		"wn" '(evil-window-new :which-key "new")
		"wv" '(evil-window-vnew :which-key "new(v)"))

	;; yank pop
	(my-leader-def 'normal
		"y" '(consult-yank-pop :which-key "yank pop"))

	(my-leader-def 'normal
		"." '(consult-global-mark :which-key "time travel"))

	(my-leader-def 'normal
		"g" '(:ignore t :which-key "travel")
		"gb" '(consult-bookmark :which-key "bookmark"))


	(my-leader-def 'normal
		"G" '(magit :which-key "magit"))
	
	)

(provide 'editor-keybinds)
