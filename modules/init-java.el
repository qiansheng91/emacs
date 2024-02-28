;;; init-java.el --- Java support -*- lexical-binding: t -*-

;;; Commentary:
;; Java support
;;; Code:

(defvar eglot-java-server-jar-path
  "~/Programs/java-debug/com.microsoft.java.debug.plugin.jar"
  "The path to the JAR file of the eglot java server.")

(use-package emacs
  :defer eglot
  :config
  (add-to-list 'eglot-server-programs
               `((java-mode java-ts-mode) .
				 ("jdtls"
                  :initializationOptions
                  (:bundles ["/Users/qiansheng/Programs/java-debug/com.microsoft.java.debug.plugin.jar"])))))

(provide 'init-java)
