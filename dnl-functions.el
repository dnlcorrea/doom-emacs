(setq browser "google-chrome-stable")
(setq ssh_config "~/.ssh/config")

(setq urls `(
             ("WhatsApp" . "web.whatsapp.com")
             ("Telegram" . "web.telegram.org")
             ("Inter" . "contadigitalpro.bancointer.com.br")
             ("Meditative Mind" . "youtube.com/channel/UCM0YvsRfYfsniGAhjvYFOSA")
             ("Drive" . "drive.google.com/drive/u/1/")
             ("Mail 31" . "mail.google.com/mail/u/1/#inbox")
             ("Moosti" . "moosti.com")))

(defun dnl-terminal()
  (interactive)
  (mapc (lambda (foo)
          (if (string-match-p "URxvt" (format "%s" foo))
              (switch-to-buffer
               (catch 'tag
                 (mapc
                  (lambda (foo)
                    (when (string-match (regexp-quote "URxvt") (format "%s" foo)) (throw 'tag foo))) (buffer-list))))
            (dnl-terminal-huge nil)))
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
  (start-process-shell-command "URxvt" nil comm))

(defun dnl-white-terminal()
  (interactive)
  (start-process-shell-command "URxvt" nil "terminator -e zsh"))

(defun dnl-urls()
  "Choose some common sites."
  (interactive)
  (start-process-shell-command
   "Google" nil
   (format "%s --new-window https://%s" browser
           (assoc-default (ivy-read "URL: " urls) urls))))


;; (defun dnl-run()
;;   (interactive)
;;   (setq cmds (split-string (shell-command-to-string "whence -pm '*'") "\n"))
;;   (setq run (ivy-read "RUN: " (mapcar (lambda (cmd) (file-name-nondirectory cmd)) cmds)))
;;   (start-process-shell-command "RUN" nil run))

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


;;; SSH
(defun dnl--get-ssh-hosts()
  "Return a list of ssh hosts of current user."
  (with-temp-buffer
    (insert-file-contents ssh_config)
    (keep-lines "^Host ")
    (split-string (buffer-string) "\n" t)))

(defun dnl-ssh()
  "Ssh's into your ssh servers."
  (interactive)
  (start-process-shell-command
   "SSH" nil
   (format
    "urxvt -e ssh %s"
    (nth 1
         (split-string
          (ivy-read "SSH Host: " (dnl--get-ssh-hosts)) " " t)))))

(defun dnl-rain()
  (interactive)
  (message "Raining...")
  (start-process-shell-command "rain" nil "cvlc ~/meditation/0.m4a"))

(defun dnl-semicolon (p)
  (interactive "P")
  (when (not (string-match-p ";$" (thing-at-point 'line t)))
    (end-of-line)
    (insert ";"))
  (when p (newline-and-indent)))

(global-set-key (kbd "C-;") 'dnl-semicolon)

;; Utils

(global-set-key
 (kbd "C-,")
 (lambda ()
   (interactive)
   (end-of-line)
   (insert ",")))


;; (start-process-shell-command
;;  "volumeup" nil
;;  "pactl set-sink-volume 0 +5%") (message "Volume Up")))

(defun dnl--command(@com)
  (start-process-shell-command "whatevs" nil @com))

(defun dnl-volume-up()
  (interactive)
  (dnl--volume t))

(defun dnl-volume-down()
  (interactive)
  (dnl--volume))

(defun dnl--volume(&optional p)
  (setq pactl "pactl set-sink-volume 0 %s")
  (dnl--command (format pactl (if p "+15%" "-15%")))
  (message "Volume %s" (if p "+15%" "-15%"))
  (dnl--command "cvlc ~/Dropbox/vol.mp3"))


(defun dnl-backlight-up(p)
  "Increases backlight by ARG amount."
  (interactive "p")
  (dnl--command
   (format "xbacklight -inc %s" (* p 10)))
  (message "Backlight up"))

(defun dnl-backlight-down(p)
  "Decreases backlight by ARG amount."
  (interactive "p")
  (dnl--command
   (format "xbacklight -dec %s" (* p 10)))
  (message "Backlight down"))

(defun dnl-invert-boolean ()
  ;; TODO: Don't change others; if spelled wrong or word is not a boolean, don't
  ;; do shit
  "Inverts a boolean at point."
  (interactive)
  (if (string-match-p "true" (thing-at-point 'word t))
      (save-excursion
        (beginning-of-line)
        (search-forward "true")
        (replace-match "false"))
      (save-excursion
        (beginning-of-line)
        (search-forward "false")
        (replace-match "true"))))
