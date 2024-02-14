(setq major-mode-remap-alist
			'((yaml-mode . yaml-ts-mode)
				(bash-mode . bash-ts-mode)
				(js2-mode . js-ts-mode)
				(typescript-mode . typescript-ts-mode)
				(json-mode . json-ts-mode)
				(css-mode . css-ts-mode)
				(python-mode . python-ts-mode)))

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :ensure t
	:config
	(add-hook 'prog-mode-hook 'copilot-mode)
	(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
	(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

;; key binding
(use-package emacs
	:general
	(my-leader-def 'normal
		"c" '(:ignore t :which-key "code")
		"cd" '(xref-find-definitions :which-key "definition")
		"cr" '(xref-find-references :which-key "references")
		"ci" '(eglot-find-implementation :which-key "implementations")))

(provide 'init-progn)
