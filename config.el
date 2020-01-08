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
(setq doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-variable-pitch-font (font-spec :family "sans"))

(setq org-directory "~/org/")

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

  (add-hook 'exwm-mode-hook #'doom-mark-buffer-as-real-h) ; Treats EXWM as real buffers

  (exwm-input-set-key (kbd "s-<return>") #'dnl-terminal-huge)
  (exwm-input-set-key (kbd "s-'") #'shell-command)

  ; Browsers
  (exwm-input-set-key (kbd "s-g") (lambda () (interactive) (start-process-shell-command "Google" nil (concat browser " --new-window"))))
  (exwm-input-set-key (kbd "s-G") (lambda () (interactive) (start-process-shell-command "Cacafire" nil "firefox")))

  ; Navigation
  (exwm-input-set-key (kbd "s-<SPC>") 'ivy-switch-buffer)
  (exwm-input-set-key (kbd "s-x") 'counsel-M-x)
  (exwm-input-set-key (kbd "s-/") 'exwm-layout-toggle-fullscreen)
  (exwm-input-set-key (kbd "s-,") 'evil-prev-buffer)
  (exwm-input-set-key (kbd "s-.") 'evil-next-buffer)

  (exwm-input-set-key (kbd "s-<f2>")  (lambda () (interactive) (start-process-shell-command "urxvt" nil "urxvt -e htop")))

  (exwm-input-set-key (kbd "M-SPC") 'dnl-search)

  (exwm-input-set-key (kbd "s-e") 'dnl-urls)

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
  (exwm-input-set-key (kbd "s-m") 'doom/switch-to-scratch-buffer)
  (exwm-input-set-key (kbd "s-c") 'kill-this-buffer)

  (setq exwm-workspace-number 6
        exwm-manage-configurations '((t char-mode t))
        exwm-workspace-show-all-buffers nil)

  ; Workspaces
  (exwm-input-set-key (kbd "s-t") 'exwm-workspace-move-window)
  (exwm-input-set-key (kbd "s-w") 'exwm-workspace-switch)
  (exwm-input-set-key (kbd "s-0") (lambda () (interactive)(exwm-workspace-switch-create 0)))
  (exwm-input-set-key (kbd "s-1") (lambda () (interactive)(exwm-workspace-switch-create 1)))
  (exwm-input-set-key (kbd "s-2") (lambda () (interactive)(exwm-workspace-switch-create 2)))
  (exwm-input-set-key (kbd "s-3") (lambda () (interactive)(exwm-workspace-switch-create 3)))
  (exwm-input-set-key (kbd "s-4") (lambda () (interactive)(exwm-workspace-switch-create 4)))
  (exwm-input-set-key (kbd "s-5") (lambda () (interactive)(exwm-workspace-switch-create 5)))

  (exwm-input-set-key (kbd "s-b") (lambda () (interactive) (start-process-shell-command "Qutebrowser" nil "qutebrowser")))
  (exwm-input-set-key (kbd "s-r") (lambda () (interactive) (start-process-shell-command "Ranger" nil "urxvt -e ranger")))
  (exwm-input-set-key (kbd "<print>") (lambda () (interactive) (start-process-shell-command "scrot" nil "scrot -u ~/'%Y-%m-%d_$wx$h.png'")))
  ;(exwm-input-set-key (kbd "s-e") 'dnl-urls)

  (require 'exwm-randr)
  (setq exwm-randr-workspace-monitor-plist '(0 "HDMI1" 1 "HDMI1" 2 "HDMI1" 3 "HDMI1" 4 "eDP1" 5 "eDP1"))
  ;(add-hook 'exwm-randr-screen-change-hook (lambda () (start-process-shell-command "xrandr" nil "bash ~/bin/xr")))
  (exwm-randr-enable)

  ;; Resize windows
  (exwm-input-set-key (kbd "s-u") 'enlarge-window-horizontally)
  (exwm-input-set-key (kbd "s-i") 'enlarge-window)
  (exwm-input-set-key (kbd "s-;")
                      (lambda() (interactive)
                        (start-process-shell-command "lol" nil "urxvt -e $(rofi -show drun)")))

                                        ;(exwm-input-set-key (kbd "s-y") 'helm-show-kill-ring)
  (exwm-input-set-key (kbd "s-<backspace>") (lambda () (interactive) (dnl--command "/home/daniel/bin/xr")))
                                        ;(exwm-input-set-key (kbd "s-<home>") 'exwm-floating-toggle-floating)
  (exwm-input-set-key (kbd "s-<f5>") (lambda () (interactive) (find-file "~/.doom.d/config.el")))
  (exwm-input-set-key (kbd "s-<f6>") (lambda () (interactive) (find-file "~/org/main.org")))
  (exwm-input-set-key (kbd "s-<f9>") 'dnl-rain)

  (exwm-input-set-key (kbd "s-S") 'dnl-ssh)

  ;;; XF86 Controls
  (exwm-input-set-key (kbd "<XF86MonBrightnessDown>") 'dnl-backlight-down)
  (exwm-input-set-key (kbd "<XF86MonBrightnessUp>")   'dnl-backlight-up)
  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")  'dnl-volume-up)
  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>")  'dnl-volume-down)

  ;;(exwm-input-set-key (kbd "s-]") (lambda () (interactive) (shell-command "rofi -modi \"clipboard:greenclip print\" -show" "*Messages*")))
  ;;(exwm-input-set-key (kbd "s-\\") (lambda () (interactive)(start-process-shell-command "tex" nil "~/bin/texpander.sh")))

  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
  (add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

  (add-hook 'exwm-mode-hook (lambda () (setq mode-line-format nil)))

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (start-process-shell-command "compton" nil "compton")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (start-process-shell-command "keys" nil "/home/daniel/bin/keys")
  (start-process-shell-command "greenclip daemon" nil "greenclip daemon")
  (start-process-shell-command "udiskie" nil "udiskie --tray")
  (start-process-shell-command "blueman" nil "blueman-applet")
  (start-process-shell-command "cbatticon" nil "cbatticon")
  (start-process-shell-command "pasystray" nil "pasystray")
  (start-process-shell-command "redshift" nil "redshift")

  (call-process-shell-command "(sleep 10s && ~/.dropbox-dist/dropboxd) &" nil 0)
  (call-process-shell-command "(sleep 5s && dunst) &" nil 0)
  ;(start-process-shell-command "camera" "camera" "bash ~/Dropbox/Geekery/dogs.sh")

  (add-to-list 'default-frame-alist '(alpha 95))
  (exwm-enable)

  ;; There are two ways to load a theme. Both assume the theme is installed and
  ;; available. You can either set `doom-theme' or manually load a theme with the
  ;; `load-theme' function. These are the defaults.
  (setq doom-theme 'doom-one))

(load! "dnl-functions")

(use-package! lsp-ui
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe nil
        lsp-ui-doc-position 'right
        lsp-ui-doc-include-signature nil
        lsp-ui-sideline-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25
        lsp-enable-file-watchers nil
        lsp-ui-sideline-delay .8
        lsp-ui-sideline-enable t))

(use-package! company-lsp  :commands company-lsp)
(use-package! lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package! lsp-mode
  :hook (web-mode . lsp)
  :commands lsp)

(use-package! ledger-mode :bind ("C-TAB" . ledger-post-align-xact))

;;; MAPS
(map! :leader :desc "Personal Wiki" "d f" (lambda() (interactive) (find-file "~/org/Tech/Emacs.org")))
(map! :leader :desc "Tech Folder" "d t" (lambda() (interactive) (find-file "~/org/Tech/")))
(map! :leader :desc "Goals" "d g" (lambda() (interactive) (find-file "~/org/Tech/Goals.org")))
(map! :leader :desc "Emacs.org" "d e" (lambda() (interactive) (find-file "~/org/Tech/Emacs.org")))
(map! :leader :desc "Main" "d m" (lambda() (interactive) (find-file "~/org/main.org")))
(map! :leader :desc "laravel mode" "d l" 'laravel-menu)

(map! :desc "Emmet, activate!" "M-e" 'emmet-expand-line)
(map! :leader :desc "Emmet Preview" "c a" 'emmet-preview-mode)

;; Remaps
(map! :leader :desc "M-x" "x" 'counsel-M-x)
