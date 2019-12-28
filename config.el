;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Daniel Correa"
      user-mail-address "dnlcorrea@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Source Code Pro" :size 14)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(use-package exwm
	     :config
       (setq doom-leader-alt-key "M-SPC"
             doom-localleader-alt-key "s-SPC m")
       (exwm-input-set-key (kbd "s-<return>") #'dnl-terminal-huge)
       (exwm-input-set-key (kbd "s-'") #'shell-command)
       (exwm-input-set-key (kbd "s-g") (lambda () (interactive) (start-process-shell-command "Google" nil (concat browser " --new-window"))))
       (exwm-input-set-key (kbd "s-G") (lambda () (interactive) (start-process-shell-command "Cacafire" nil "firefox")))
       (exwm-input-set-key (kbd "s-<SPC>") 'ivy-switch-buffer)
       (exwm-input-set-key (kbd "s-x") 'counsel-M-x)
       (exwm-input-set-key (kbd "s-/") 'exwm-layout-toggle-fullscreen)
       (exwm-input-set-key (kbd "s-,") 'evil-prev-buffer)
       (exwm-input-set-key (kbd "s-.") 'evil-next-buffer)
       (exwm-input-set-key (kbd "s-<f2>")  (lambda () (interactive) (start-process-shell-command "urxvt" nil "urxvt -e htop")))
       (exwm-input-set-key (kbd "s-a") 'delete-other-windows)
       (exwm-input-set-key (kbd "s-s") 'split-window-below)
       (exwm-input-set-key (kbd "s-d") 'split-go-to-right)
       (exwm-input-set-key (kbd "s-v") 'delete-window)
       (exwm-input-set-key (kbd "s-6") (lambda () (interactive)(start-process-shell-command "pavucontrol" nil "pavucontrol")))
       (exwm-input-set-key (kbd "s-L") 'evil-window-move-far-right)
       (exwm-input-set-key (kbd "s-H") 'evil-window-move-far-left)
       (exwm-input-set-key (kbd "s-J") 'evil-window-move-very-bottom)
       (exwm-input-set-key (kbd "s-K") 'evil-window-move-very-top)
       (exwm-input-set-key (kbd "s-h") 'evil-window-left)
       (exwm-input-set-key (kbd "s-l") 'evil-window-right)
       (exwm-input-set-key (kbd "s-k") 'evil-window-up)
       (exwm-input-set-key (kbd "s-j") 'evil-window-down)
       (exwm-input-set-key (kbd "s-o") 'other-frame)
       (exwm-input-set-key (kbd "s-=") 'balance-windows)
       (exwm-input-set-key (kbd "s-m") (lambda () (interactive)(switch-to-buffer "*scratch*")))
       (exwm-input-set-key (kbd "s-p") (lambda () (interactive) (start-process-shell-command "rofi" nil "xdg-open \"$(locate pdf ods php | rofi -dmenu)\"")))
       (exwm-input-set-key (kbd "s-c") 'kill-this-buffer)
       (exwm-input-set-key (kbd "s-w") '+workspace/switch-to)
       (exwm-input-set-key (kbd "s-0") '+workspace/switch-to-0)
       (exwm-input-set-key (kbd "s-1") '+workspace/switch-to-1)
       (exwm-input-set-key (kbd "s-2") '+workspace/switch-to-2)
       (exwm-input-set-key (kbd "s-3") '+workspace/switch-to-3)
       (exwm-input-set-key (kbd "s-4") '+workspace/switch-to-4)
       ;(exwm-input-set-key (kbd "s-f") 'counsel-find-file)
       (exwm-input-set-key (kbd "s-b") (lambda () (interactive) (start-process-shell-command "Qutebrowser" nil "qutebrowser")))
       (exwm-input-set-key (kbd "s-t") (lambda () (interactive) (start-process-shell-command "Ranger" nil "urxvt -e ranger")))
       (exwm-input-set-key (kbd "<print>") (lambda () (interactive) (start-process-shell-command "scrot" nil "scrot -u ~/'%Y-%m-%d_$wx$h.png'")))
       ;(exwm-input-set-key (kbd "s-e") 'dnl-urls)
                                        ;
       ;; (require 'exwm-randr)
       ;; (setq exwm-randr-workspace-monitor-plist '(0 "HDMI1" 1 "HDMI1" 2 "HDMI1" 3 "HDMI1" 4 "eDP1" 5 "eDP1"))
       ;;                                  ;(add-hook 'exwm-randr-screen-change-hook (lambda () (start-process-shell-command "xrandr" nil "bash ~/bin/xr")))
       ;; (exwm-randr-enable)
                                        ;
       ;; Resize windows
       (exwm-input-set-key (kbd "s-u") 'enlarge-window-horizontally)
       (exwm-input-set-key (kbd "s-i") 'enlarge-window)
       (exwm-input-set-key (kbd "s-;") 'dnl-run)
       ;(exwm-input-set-key (kbd "s-y") 'helm-show-kill-ring)
       ;(exwm-input-set-key (kbd "s-<delete>") (lambda () (interactive) (start-process-shell-command "xr" nil "/home/daniel/bin/xr")))
       ;(exwm-input-set-key (kbd "s-<home>") 'exwm-floating-toggle-floating)

       ;;; XF86 Controls
       (exwm-input-set-key (kbd "s-<f11>") (lambda () (interactive) (start-process-shell-command "backlight" nil "xbacklight -dec 10") (message "Backlight down")))
       (exwm-input-set-key (kbd "s-<f12>")   (lambda () (interactive) (start-process-shell-command "backlight" nil "xbacklight -inc 10") (message "Backlight up")))
       (exwm-input-set-key (kbd "s-<prior>")  (lambda () (interactive) (start-process-shell-command "volumeup" nil "pactl set-sink-volume 0 +5%") (message "Volume Up")))
       (exwm-input-set-key (kbd "s-<next>")  (lambda () (interactive) (start-process-shell-command "volumedown" nil "pactl set-sink-volume 0 -5%") (message "Volume Down")))
       ;(exwm-input-set-key (kbd "s-]") (lambda () (interactive) (shell-command "rofi -modi \"clipboard:greenclip print\" -show" "*Messages*")))
       ;(exwm-input-set-key (kbd "s-\\") (lambda () (interactive)(start-process-shell-command "tex" nil "~/bin/texpander.sh")))

       (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
       (exwm-input-set-key (kbd "s-S") 'dnl-ssh)
;;; Add these hooks in a suitable place (e.g., as done in exwm-config-default)
       (add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
       (add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

       (add-hook 'exwm-mode-hook (lambda ()
                                   (setq mode-line-format nil)))

       (require 'exwm-systemtray)
       (exwm-systemtray-enable)

       ;; (start-process-shell-command "compton" nil "compton")
       ;; (start-process-shell-command "nm-applet" nil "nm-applet")
       ;; (start-process-shell-command "keys" nil "/home/daniel/bin/keys")
       ;; (start-process-shell-command "greenclip daemon" nil "greenclip daemon")
       ;; (start-process-shell-command "udiskie" nil "udiskie --tray")
       ;; (start-process-shell-command "blueman" nil "blueman-applet")
       ;; (start-process-shell-command "cbatticon" nil "cbatticon")
       ;; (start-process-shell-command "pasystray" nil "pasystray")
       ;; (start-process-shell-command "redshift" nil "redshift")

       ;(call-process-shell-command "(sleep 10s && ~/.dropbox-dist/dropboxd) &" nil 0)
       ;(call-process-shell-command "(sleep 5s && dunst) &" nil 0)

       ;(start-process-shell-command "camera" "camera" "bash ~/Dropbox/Geekery/dogs.sh")

       (exwm-enable))

(use-package lsp-ui-mode
  :hook
  'lsp-mode-hook)

;; Other
(set-popup-rule! "^\\*EXWM*" :ignore t)
(set-popup-rule! "PHP" :ignore t)

(load! "dnl-functions")

(start-process-shell-command "compton" nil "compton")
