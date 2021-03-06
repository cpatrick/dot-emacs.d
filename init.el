; TABS ARE BAD
(setq-default indent-tabs-mode nil)

; frames
(setq frame-title-format "%b")		; use buffer name for title
(setq display-buffer-reuse-frames t)    ; no new frame if already open

; map some keys
(global-set-key [f1] 'compile)
(global-set-key [f2] 'recompile)
(global-set-key [f3] 'next-error)

; maximize screen real estate
(setq tool-bar-mode nil)
(setq menu-bar-mode nil)
(setq scroll-bar-mode nil)

; Alt-G should be goto-line
(global-unset-key "\M-g")
(global-set-key "\M-g" 'goto-line)

; plugin loading
(add-to-list 'load-path "~/.emacs.d/plugins")

; highlight marked region
(transient-mark-mode t)

; use aspell for spellchecking
(setq-default ispell-program-name "aspell")

; make searches case-insensitive
;(setq case-fold-search t)

; parenthesis matching
(show-paren-mode 1)

; show line and column number in modline
(line-number-mode t)

; Get proper env... OS X Fix?
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (and window-system (eq system-type 'darwin))
  ;; When started from Emacs.app or similar, ensure $PATH
  ;; is the same the user would see in Terminal.app
  (set-exec-path-from-shell-PATH))


(column-number-mode t)

; font lock in all major modes
;(global-font-lock-mode t)
;(setq font-lock-maximum-decoration t)

; indent by 2, no tabs, syntax hilighting
(add-hook 'c-mode-common-hook '(lambda ()
                                 (setq indent-tabs-mode nil)))

; scroll line by line
(setq scroll-step 1)

;; set up cmake mode
(require 'cmake-mode)

;; automatically set mode for these file extensions 
(setq auto-mode-alist
      (append 
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'"         . cmake-mode))
       auto-mode-alist))

; VTK style
(defun c-set-indent-vtk ()
  (interactive)
  (setq c-basic-offset 2)
  (setq c-comment-only-line-offset 0)
  (setq c-indent-comments-syntactically-p t)
  (setq c-electric-pound-behavior '(alignleft))
  (setq indent-tabs-mode nil)
  (c-set-offset 'case-label 0)
  (c-set-offset 'label 0)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open '+)
  (c-set-offset 'block-close 0)
  (c-set-offset 'substatement '+)
  (c-set-offset 'substatement-open '+)
  (c-set-offset 'statement-block-intro 0)
  (c-set-offset 'access-label '-)
  (c-set-offset 'string 'c-lineup-dont-change)
  (c-set-offset 'c 'c-lineup-C-comments)
  (c-set-offset 'defun-open 0)
  (c-set-offset 'defun-close 0)
  (c-set-offset 'defun-block-intro '+)
  (c-set-offset 'class-open 0)
  (c-set-offset 'class-close 0)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'inline-close 0)
  (c-set-offset 'func-decl-cont '+)
  (c-set-offset 'knr-argdecl-intro 5)
  (c-set-offset 'knr-argdecl 0)
  (c-set-offset 'topmost-intro 0)
  (c-set-offset 'member-init-intro '+)
  (c-set-offset 'member-init-cont 0)
  (c-set-offset 'inher-intro '+)
  (c-set-offset 'inher-cont 'c-lineup-multi-inher)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'brace-list-close 0)
  (c-set-offset 'brace-list-intro '+)
  (c-set-offset 'brace-list-entry 0)
  (c-set-offset 'brace-entry-open 0)
  (c-set-offset 'statement 0)
  (c-set-offset 'statement-cont '+)
  (c-set-offset 'statement-case-intro '+)
  (c-set-offset 'statement-case-open '+)
  (c-set-offset 'do-while-closure 0)
  (c-set-offset 'else-clause 0)
  (c-set-offset 'catch-clause 0)
  (c-set-offset 'comment-intro 'c-lineup-comment)
  (c-set-offset 'arglist-intro 'c-lineup-arglist-intro-after-paren)
  (c-set-offset 'arglist-cont 'c-lineup-operator-arglist)
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-operator-arglist)
  (c-set-offset 'arglist-close 'c-lineup-arglist)
  (c-set-offset 'stream-op 'c-lineup-streamop)
  (c-set-offset 'inclass '+)
  (c-set-offset 'cpp-macro -1000)
  (c-set-offset 'cpp-macro-cont 'c-lineup-dont-change)
  (c-set-offset 'friend 0)
  (c-set-offset 'objc-method-intro -1000)
  (c-set-offset 'objc-method-args-cont 'c-lineup-ObjC-method-args)
  (c-set-offset 'objc-method-call-cont 'c-lineup-ObjC-method-call)
  (c-set-offset 'extern-lang-open 0)
  (c-set-offset 'extern-lang-close 0)
  (c-set-offset 'inextern-lang '+)
  (c-set-offset 'namespace-open 0)
  (c-set-offset 'namespace-close 0)
  (c-set-offset 'innamespace '+)
  (c-set-offset 'template-args-cont '+)
  (c-set-offset 'inlambda 'c-lineup-inexpr-block)
  (c-set-offset 'lambda-intro-cont '+)
  (c-set-offset 'inexpr-statement 0)
  (c-set-offset 'inexpr-class '+)
  (message "VTK indentation."))
(add-hook 'c-mode-common-hook 'c-set-indent-vtk)

; Adding txx files to the c++ mode
(add-to-list 'auto-mode-alist '("\\.txx\\'" . c++-mode)) 
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

; Get rid of those files that end in ~. I hate them. I'm not a child.
(setq make-backup-files nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "apple" :family "Monaco")))))

; require flyspell
(require 'flyspell-mode nil t)

; spellcheck text
(add-hook 'text-mode-hook '(lambda ()
                             (flyspell-mode t)
                             (auto-fill-mode t)))


; php
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.thtml$" . php-mode))

; yasnippet
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

; Use fill-mode when editing git commit messages
(setq auto-mode-alist (cons '("COMMIT_EDITMSG$" . auto-fill-mode) auto-mode-alist))

; Function for cleaning up xml
(load "~/.emacs.d/plugins/nxml-mode-20041004/rng-auto.el")
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))

; Not sure
(setq tab-always-indent 'complete)

(require 'pymacs)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
		    (set-variable 'py-indent-offset 4)
		    (set-variable 'py-smart-indentation nil)
		    (set-variable 'indent-tabs-mode nil) 
		    ;;(highlight-beyond-fill-column)
                    (define-key python-mode-map "\C-m" 'newline-and-indent)
		    )
      )
)

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

; flymake for pylint
(require 'flymake)
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; JSLoad
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; JSLint flymake
(when (load "flymake" t)
  (defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "jslint" (list local-file))))

  (setq flymake-err-line-patterns
	(cons '("Error:\\([[:digit:]]+\\):\\([[:digit:]]+\\):\\(.*\\)$"
		nil 1 2 3)
	      flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\'" flymake-jslint-init))

  (require 'flymake-cursor)
)

(add-hook 'js2-mode-hook
	  (lambda ()
      (flymake-mode 1)
      (define-key js2-mode-map "\C-c\C-n" 'flymake-goto-next-error)))

;; Global flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)
