(custom-set-variables
; '(viper-ESC-moves-cursor-back nil)
 '(viper-ex-style-editing nil)
 '(viper-mode t)
 '(viper-shift-width 2)
 '(viper-vi-style-in-minibuffer nil)
 '(viper-no-multiple-ESC nil))
(custom-set-faces
 '(viper-minibuffer-emacs-face ((((class color)) nil))))
(setq viper-inhibit-startup-message 't)
(setq viper-expert-level '5)
(define-key viper-insert-global-user-map "\C-t" 'transpose-chars)
