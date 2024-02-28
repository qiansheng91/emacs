(use-package sqlformat
	:ensure t)

(use-package sql-indent
	:ensure t
	:config
	(add-hook 'sql-mode-hook 'sqlind-minor-mode))


(use-package sqlup-mode
	:ensure t)

(provide 'init-sql)


