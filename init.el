(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(markdown-command "pandoc")
 '(package-selected-packages
   (quote
    (elixir-mode rainbow-delimiters clojure-mode kotlin-mode company-erlang erlang paredit glsl-mode markdown-mode arduino-mode php-mode nasm-mode csharp-mode dotnet racer intero company-irony irony yaml-mode magit rust-mode crystal-mode haskell-mode fsharp-mode idris-mode elm-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier 10 Pitch" :foundry "bitstream" :slant normal :weight normal :height 128 :width normal)))))
(add-to-list 'load-path "/home/ole/.opam/system/share/emacs/site-lisp/")

(setq-default indent-tabs-mode nil)


(if (file-exists-p "/home/ole/.opam/system/share/emacs/site-lisp/tuareg-site-file") (load "/home/ole/.opam/system/share/emacs/site-lisp/tuareg-site-file"))


(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "M-RET") 'company-complete)


(defun my-irony-mode-on ()
  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))


(add-hook 'c++-mode-hook 'my-irony-mode-on)
(add-hook 'c-mode-hook 'my-irony-mode-on)
(add-hook 'objc-mode-hook 'my-irony-mode-on)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)

(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'erlang-mode-hook #'company-erlang-init)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))


(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq erlang-indent-level 2)
