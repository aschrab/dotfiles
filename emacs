(global-set-key "\C-x?" 'help-command)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-m" 'newline-and-indent)
(if (featurep 'toolbar)
    (progn (set-default-toolbar-position 'left)
	   (add-spec-list-to-specifier default-toolbar-visible-p 'nil)
	   (add-spec-list-to-specifier toolbar-buttons-captioned-p 'nil)))
(setq diff-switches "-ur")
(setq require-final-newline nil)
(setq make-backup-files nil)
(setq line-number-mode t)
(setq auto-mode-alist (mapcar 'purecopy
			      '(("\\.c$" . c-mode)
				("\\.h$" . c-mode)
				("\\.tex$" . TeX-mode)
				("\\.txi$" . Texinfo-mode)
				("\\.el$" . emacs-lisp-mode)
                                ("^/tmp/mutt" . message-mode)
                                ("\\.article$" . message-mode)
                                ("^/tmp/snd\\." . message-mode)
                                ("\\.a$" . c-mode))))

(setq text-mode-hook 'turn-on-auto-fill)
;; (setq cvs-program "/home/aarons/bin/cvs")

;; Options Menu Settings
;; =====================
(cond
 ((and (string-match "XEmacs" emacs-version)
       (boundp 'emacs-major-version)
       (or (and
            (= emacs-major-version 19)
            (>= emacs-minor-version 14))
           (= emacs-major-version 20))
       (fboundp 'load-options-file))
  (load-options-file "/home/aarons/.xemacs-options")))
;; ============================
;; End of Options Menu Settings
(setq-default abbrev-mode t)
(read-abbrev-file "~/.abbrev-defs")
(setq save-abbrevs t)

(setq-default indent-tabs-mode nil)
(setq viper-mode t)
(require `viper)
(custom-set-variables
 '(cperl-electric-parens t)
 '(backup-by-copying t)
 '(cperl-electric-keywords t)
 '(toolbar-news-use-separate-frame nil)
 '(enable-recursive-minibuffers t)
 '(viper-emacs-state-mode-list (quote (custom-mode dired-mode efs-mode tar-mode mh-folder-mode gnus-group-mode gnus-summary-mode Info-mode Buffer-menu-mode compilation-mode view-mode vm-mode apropos-mode vm-summary-mode)))
 '(objc-mode-hook (quote (viper-mode)))
 '(browse-url-browser-function (quote browse-url-netscape))
 '(viper-ex-style-editing nil)
 '(viper-mode t)
 '(viper-shift-width 2)
 '(viper-vi-style-in-minibuffer nil)
 '(cperl-hairy nil)
 '(file-precious-flag t)
 '(cperl-indent-left-aligned-comments nil)
 '(user-mail-address "aaron@schrab.com" t)
 '(viper-no-multiple-ESC nil)
 '(cperl-noscan-files-regexp "/\\(\\.\\.?\\|SCCS\\|RCS\\|CVS\\|blib\\)$")
 '(query-user-mail-address nil)
 '(ssh-directory-tracking-mode t)
 '(viper-case-fold-search t))
(gnuserv-start)
(setq C-x7-map (make-keymap))
(global-set-key "\C-x7" C-x7-map)

(defalias 'signature-work
  (read-kbd-macro "M-x viper-change-state-to-emacs RET M-x viper-change-state-to-emacs RET RET C-a  - - SPC RET C-x i ~/.sigs/work RET C-p C-p M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "w" 'signature-work)
(defalias 'signature-lsm
  (read-kbd-macro "M-x viper-change-state-to-emacs RET RET C-a  - - SPC RET C-x i ~/.sigs/lsm RET C-p C-p M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "l" 'signature-lsm)
(defalias 'signature-mega
  (read-kbd-macro "M-x viper-change-state-to-emacs RET RET C-a  - - SPC RET C-x i ~/.sigs/mega RET C-p C-p M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "m" 'signature-mega)
(defalias 'spam-reply
  (read-kbd-macro "M-x viper-change-state-to-emacs RET M-> C-x i ~/.sigs/spamreply RET C-x C-s M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "a" 'spam-reply)
(defalias 'signature-personal (read-kbd-macro
"M-x viper-change-state-to-emacs RET RET C-a  - - SPC RET C-x i ~/.sigs/personal RET C-n C-SPC C-u M-x shell-command-on-region RET ~/bin/fortune RET M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "p" 'signature-personal)
(defalias 'signature-schrab (read-kbd-macro
"M-x viper-change-state-to-emacs RET RET C-a  - - SPC RET C-x i ~/.sigs/schrab RET C-n C-SPC C-u M-x shell-command-on-region RET ~/bin/fortune RET M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "s" 'signature-schrab)
(defalias 'signature-fortune (read-kbd-macro
"M-x viper-change-state-to-emacs RET C-u M-x shell-command-on-region RET ~/bin/fortune RET M-x viper-change-state-to-vi RET"))
(define-key C-x7-map "f" 'signature-fortune)
(custom-set-faces
 '(default ((t nil)) t)
 '(viper-minibuffer-emacs-face ((((class color)) nil))))
(setq make-backup-files nil)

(setq auto-mode-alist
  (append '(("tmp/mutt.*[0-9]*" . message-mode))
   auto-mode-alist))

(add-hook 'message-mode-hook
           (function
            (lambda ()
             (search-forward "\n\n" nil t))))

(defun my-c-mode-common-hook ()
  ;; use Ellemtel style for all C like languages
  (c-set-style "ellemtel")
  ;; other customizations can go here
  (setq c-basic-offset 2)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
