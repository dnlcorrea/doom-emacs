(setq browser "google-chrome-stable")

(defun dnl-terminal()
  (interactive)
  (mapc (lambda (foo)
    (if (string-match-p "URxvt" (format "%s" foo))
	(switch-to-buffer foo)
        (message "No URxvt buffers found")
      ))
    (buffer-list)))

;; (defun dnl-floating-term()
;;   (interactive)
;;   (start-process-shell-command "URxvt" "floater" "urxvt")
;;   (exwm-floating--set-floating )
;;   (exwm-floating-toggle-floating))

(defun dnl-terminal-huge(a)
    "Open a Urxvt terminal.  With argument as A, open with huge font."
    (interactive "P")
    (if a (setq comm "urxvt -fn 'xft:Iosevka Term:size=32'") (setq comm "urxvt"))
    (start-process-shell-command "URxvt" nil (concat comm " -cd ~")))

(defun dnl-white-terminal()
    (interactive)
    (start-process-shell-command "URxvt" nil "terminator -e zsh"))

(defun er-switch-to-previous-buffer ()
"Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun dnl-urls()
"Choose some common sites."
(interactive)
(start-process-shell-command "Google" nil
    (format "%s --new-window https://%s" browser 
	(assoc-default (completing-read "URL: " urls) urls))))

(defun dnl-run()
  (interactive)
  (setq cmds (split-string (shell-command-to-string "whence -pm '*'") "\n"))
  (setq run (ivy-read "RUN: " (mapcar (lambda (cmd) (file-name-nondirectory cmd)) cmds)))
  (start-process-shell-command "RUN" nil run))

(defun exwm-rename-buffer ()
  (interactive)
  (exwm-workspace-rename-buffer
   (concat exwm-class-name ":"
           (if (<= (length exwm-title) 50) exwm-title
             (concat (substring exwm-title 0 49) "...")))))

(defun dnl-bank()
    (interactive)
    (delete-other-windows)
    (start-process-shell-command "inter" nil "firefox https://contadigitalpro.bancointer.com.br/")
    (split-go-to-right)
    (start-process-shell-command "messages" nil "google-chrome-stable --new-window https://messages.google.com"))

(defun dnl-search() 
    (interactive)
    (setq search (read-string "Search: "))
    (start-process-shell-command "search" nil (format "%s 'https://google.com/search?q=%s'" "/usr/bin/qutebrowser --target window" search)))


(defun dnl-insert-date()
  (interactive)
  (insert (org-read-date)))

(defun split-go-to-right()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun dnl-ssh()
  (interactive)
  (start-process-shell-command "ssh" "foo" "urxvt -e sshdnl"))



;; (defun reload-emacs ()
;;   "Reload Emacs init file."
;;   (interactive)
;;   (load-file "~/.emacs"))

(provide 'dnl-functions)
