(use-package go-mode
  :ensure t)

(use-package emacs
  :config
  (add-to-list 'dape-configs
               `(utest
				 modes (go-mode go-ts-mode)
				 ensure dape-ensure-command
				 fn dape-config-autoport
				 command "dlv"
				 command-args ("dap" "--listen" "127.0.0.1::autoport")
				 command-cwd dape-cwd-fn
				 port :autoport
				 :type "debug"
				 :request "launch"
				 :mode (lambda () (if (string-suffix-p "_test.go"   (buffer-name)) "test" "debug"))
				 :cwd dape-cwd-fn
				 :program (lambda () (if (string-suffix-p "_test.go"   (buffer-name))
										 (concat "./" (file-relative-name default-directory (funcall dape-cwd-fn)))
                                       (funcall dape-cwd-fn)))
				 :args (lambda ()
						 (require 'which-func)
						 (if (string-suffix-p "_test.go"   (buffer-name))
							 (when-let* ((test-name (which-function))
										 (test-regexp (concat "^" test-name "$")))
                               (if test-name `["-test.run" ,test-regexp]
								 (error "No test selected")))
                           [])))))

(provide 'init-golang)
