(setq dnl-browser "/usr/bin/qutebrowser --target window"
      ssh_config "~/.ssh/config"
      urls `(("WhatsApp" . "web.whatsapp.com")
             ("Telegram" . "web.telegram.org")
             ("Meditative Mind" . "youtube.com/channel/UCM0YvsRfYfsniGAhjvYFOSA")
             ("Drive" . "drive.google.com/drive/u/1/")
             ("Mail 31" . "mail.google.com/mail/u/2/#inbox")
             ("NFS nota" . "nfse.pmfi.pr.gov.br/nfseweb/Login")
             ("Pomodoro" . "pomofocus.io")
             ("Trello" . "trello.com")))

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

(defun dnl-theme-terminal()
  (interactive)
  (let
      ((theme (shell-command-to-string
              "ls -1 /home/daniel/.oh-my-zsh/themes | cut -d . -f 1 | rofi -dmenu 2> /dev/null | xargs echo -n")))
    (start-process-shell-command "huahua" nil (format "ZSH_THEME='%s' urxvt" theme))))


(defun dnl-floating-term()
  (interactive)
  (start-process-shell-command "xterm" "floater" "xterm -class dnl-terminal"))

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
   (format "%s --new-window https://%s" "google-chrome-stable"
           (helm-comp-read "URL: " urls))))


;; (defun dnl-run()
;;   (interactive)
;;   (setq cmds (split-string (shell-command-to-string "whence -pm '*'") "\n"))
;;   (setq run (helm-comp-read "RUN: " (mapcar (lambda (cmd) (file-name-nondirectory cmd)) cmds)))
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
  "Search string in Google."
  (interactive)
  (let ((search-string (read-string "Search: ")))
    (message "Searching [%s]" search-string)
    (start-process-shell-command
     "dnl-search" nil
     (format "%s 'https://google.com/search?q=%s'"
             dnl-browser
             search-string))))


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
          (helm-comp-read "SSH Host: " (dnl--get-ssh-hosts)) " " t)))))

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


(defun dnl-php-emmet()
  (interactive)
  (setq dnl-php-emmet-string (thing-at-point 'line t))
  (setq dnl--emmet-prog "dnl-php")
  (kill-whole-line)
  (if (member major-mode '(php-mode))
      (setq dnl--emmet-prog "zen-php")
      (setq dnl--emmet-prog "dnl-java"))
  (insert
   (shell-command-to-string
    (concat dnl--emmet-prog " " (shell-quote-argument dnl-php-emmet-string))))
  (indent-region (point-min) (point-max)))

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

(defun word-or-region-to-lcc ()
  "Convert word at point (or selected region) to lower camel case."
  (interactive)
  (let* ((bounds (if (use-region-p)
                     (cons (region-beginning) (region-end))
                   (bounds-of-thing-at-point 'symbol)))
         (text   (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (s-lower-camel-case text)))))


(defun dnl-invert-boolean ()
  "Inverts a boolean at point (true, false, 0, 1)."
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (text   (buffer-substring-no-properties (car bounds) (cdr bounds)))
         (str    (cond ((string-match-p "true" text) "false")
                       ((string-match-p "false" text) "true")
                       ((string-match-p "1" text) "0")
                       ((string-match-p "0" text) "1"))))
    (if str
        (progn
          (delete-region (car bounds) (cdr bounds))
          (insert str))
      (message "Not a boolean"))))

(defun dnl-clipboard()
  (interactive)
  (kill-new
   (helm-comp-read
    "String: "
    (split-string
     (shell-command-to-string "greenclip print")
     "\n")))
  (message "Put in kill ring."))

(defun dnl-today()
  (interactive)
  (insert (format-time-string "%Y/%m/%d")))

(defun awk-sort(&optional b e)
  (interactive "r")
  (shell-command-on-region
   b e
   "awk '{ print length(), $0 | \"sort -n | cut -d\\\\  -f2-\" }'"
   :replace t))
   ;;


(defun dnl-commander-window()
  (interactive)
  (split-window nil 6 'above)
  (start-process-shell-command
   "dnl-commander"
   "dnl-commander"
   "urxvt -fn 'xft:Input Mono:size=18' -e bash --rcfile ~/.dnlbashrc"))

(defun dnl-project ()
  (interactive)
  (helm-projectile-switch-project)
  (split-window nil 50 'right)
  (start-process-shell-command "lol" nil "urxvt -fn 'xft:Iosevka Term:size=12'")
  (+treemacs/toggle))

(defun dnl-new-map()
  (interactive)
  (find-file "~/.doom.d/maps.el")
  (goto-char (point-max))
  (open-line 2)
  (yas-expand-snippet (yas-lookup-snippet "map")))
