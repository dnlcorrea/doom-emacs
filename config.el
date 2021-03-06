;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


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
(setq doom-font (font-spec :family "Liberation Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "sans"))

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

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
(use-package! exwm
  :config

  (add-hook 'exwm-mode-hook #'doom-mark-buffer-as-real-h) ; Treats EXWM as real buffers

  (evil-define-key 'normal dired-mode-map (kbd "o") 'dired-find-file-other-window)

  (exwm-input-set-key (kbd "s-<return>") (lambda() (interactive) (start-process-shell-command "Term" nil "alacritty")))
  ;;(exwm-input-set-key (kbd "s-'") #'shell-command)

                                        ; Browsers
  (exwm-input-set-key
   (kbd "s-g")
   (lambda (a) (interactive "p")
     (when (= 4 a) (split-go-to-right))
     (start-process-shell-command "Chrome" nil "google-chrome-stable --new-window")))


                                        ; Navigation
  (exwm-input-set-key (kbd "s-x") 'helm-M-x)
  (exwm-input-set-key (kbd "s-/") 'exwm-layout-toggle-fullscreen)
  (exwm-input-set-key (kbd "s-,") 'evil-prev-buffer)
  (exwm-input-set-key (kbd "s-.") 'evil-next-buffer)

  (exwm-input-set-key (kbd "s-<f2>")  (lambda () (interactive) (start-process-shell-command "urxvt" nil "urxvt -e htop")))

  (exwm-input-set-key (kbd "s-e") 'dnl-urls)

  (exwm-input-set-key (kbd "s-a") 'delete-other-windows)
  (exwm-input-set-key (kbd "s-s") 'split-window-below)
  (exwm-input-set-key (kbd "s-d") 'split-go-to-right)
  (exwm-input-set-key (kbd "s-v") 'delete-window)
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
  (exwm-input-set-key (kbd "s-n") 'helm-mini)
  (exwm-input-set-key (kbd "s-c") 'kill-this-buffer)

  ;; Clock

  (exwm-input-set-key (kbd "s-'") (lambda () (interactive)(start-process-shell-command "pavucontrol" nil "pavucontrol")))

  ;;; EXWM Window Configuration
  (setq exwm-manage-configurations
        '(((string-match-p "Volume Control" exwm-title) floating t)
          ((string-match-p "dnl-terminal" exwm-class-name) floating t)
          (t char-mode t)))


  (setq exwm-workspace-number 10
        exwm-workspace-show-all-buffers t
        doom-scratch-buffer-major-mode 'emacs-lisp-mode
        exwm-randr-workspace-monitor-plist
        '(0 "HDMI1" 1 "HDMI1" 2 "HDMI1" 3 "HDMI1" 4 "HDMI1" 5 "HDMI1"
            6 "HDMI1" 7 "HDMI1" 8 "eDP1" 9 "eDP1"))


                                        ; Workspaces
  (exwm-input-set-key (kbd "s-t") 'exwm-workspace-move-window)
  (exwm-input-set-key (kbd "s-w") 'exwm-workspace-switch)
  (exwm-input-set-key (kbd "s-0") (lambda () (interactive)(exwm-workspace-switch-create 0)))
  (exwm-input-set-key (kbd "s-1") (lambda () (interactive)(exwm-workspace-switch-create 1)))
  (exwm-input-set-key (kbd "s-2") (lambda () (interactive)(exwm-workspace-switch-create 2)))
  (exwm-input-set-key (kbd "s-3") (lambda () (interactive)(exwm-workspace-switch-create 3)))
  (exwm-input-set-key (kbd "s-4") (lambda () (interactive)(exwm-workspace-switch-create 4)))
  (exwm-input-set-key (kbd "s-5") (lambda () (interactive)(exwm-workspace-switch-create 5)))
  (exwm-input-set-key (kbd "s-6") (lambda () (interactive)(exwm-workspace-switch-create 6)))
  (exwm-input-set-key (kbd "s-7") (lambda () (interactive)(exwm-workspace-switch-create 7)))
  (exwm-input-set-key (kbd "s-8") (lambda () (interactive)(exwm-workspace-switch-create 8)))
  (exwm-input-set-key (kbd "s-9") (lambda () (interactive)(exwm-workspace-switch-create 9)))

  (defun dnl-switch-exwm()
    (interactive)
    (exwm-workspace-switch-to-buffer(helm-exwm)))

  (exwm-input-set-key (kbd "<s-tab>") 'dnl-switch-exwm)

  (exwm-input-set-key (kbd "<M-s-return>") 'dnl-terminator)


  (exwm-input-set-key (kbd "s-b") (lambda () (interactive) (start-process-shell-command "Qutebrowser" nil "qutebrowser")))
  (exwm-input-set-key
   (kbd "s-r")
   (lambda (a) (interactive "p")
     (when (= 4 a) (split-go-to-right))
     (start-process-shell-command "Ranger" nil "urxvt -e ranger")))

  ;;; Screenshots
  (exwm-input-set-key (kbd "<print>") (lambda () (interactive) (start-process-shell-command "deepin" nil "deepin-screenshot")))

  ;;; xrandr
  (require 'exwm-randr)
  ;;(add-hook 'exwm-randr-screen-change-hook (lambda () (start-process-shell-command "xrandr" nil "bash ~/bin/xr")))
  (exwm-randr-enable)

  ;; Frame opacity
  (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

  (exwm-input-set-key (kbd "s-u") 'universal-argument)

  (setq flycheck-mode-hook nil)

  ;; Resize windows
  (exwm-input-set-key (kbd "s-p") 'enlarge-window-horizontally)
  (exwm-input-set-key (kbd "s-i") 'enlarge-window)
  (exwm-input-set-key
   (kbd "s-;")
   (lambda() (interactive)
     (start-process-shell-command "lol" nil "rofi -show drun | bash")))

  (exwm-input-set-key (kbd "s-y") 'helm-kill-new)
  (exwm-input-set-key (kbd "s-<backspace>") 'dnl-clipboard)

  ;;; Options for screen resolution

  (exwm-input-set-key (kbd "s-<delete>") (lambda () (interactive) (dnl--command "/home/daniel/bin/xr"))) ; Menu
  (exwm-input-set-key (kbd "s-C-1") (lambda () (interactive) (dnl--command "/home/daniel/bin/xr -m fodao"))) ; Fodao
  (exwm-input-set-key (kbd "s-C-2") (lambda () (interactive) (dnl--command "/home/daniel/bin/xr -m tv"))) ; TV
  (exwm-input-set-key (kbd "s-C-3") (lambda () (interactive) (dnl--command "pactl set-card-profile 0 output:hdmi-stereo+input:analog-stereo"))) ; Fonao

  (exwm-input-set-key (kbd "s-<f1>") (lambda () (interactive) (find-file "~/.doom.d/reference.el")))
  (exwm-input-set-key (kbd "s-<f3>") (lambda () (interactive) (start-process-shell-command "dia" nil "dia ~/Desktop/MAIN.dia")))
  (exwm-input-set-key (kbd "s-<f4>") (lambda () (interactive) (find-file "~/.config/fish/config.fish")))
  (exwm-input-set-key (kbd "s-<f5>") (lambda () (interactive) (find-file "~/.doom.d/config.el")))
  (exwm-input-set-key (kbd "s-<f6>") (lambda () (interactive) (find-file "~/org/main.org")))
  (exwm-input-set-key (kbd "s-<f9>") 'dnl-rain)
  (exwm-input-set-key (kbd "s-<f10>") (lambda () (interactive)(start-process-shell-command "timer" nil "urxvt -e termdown 5m2s")))
  (exwm-input-set-key (kbd "s-<f11>") (lambda () (interactive)(start-process-shell-command "timer" nil "urxvt -e tty-clock")))

  (exwm-input-set-key (kbd "s-S") 'dnl-ssh)

  ;;; XF86 Controls
  (exwm-input-set-key (kbd "<XF86MonBrightnessDown>") 'dnl-backlight-down)
  (exwm-input-set-key (kbd "<XF86MonBrightnessUp>")   'dnl-backlight-up)
  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")  'dnl-volume-up)
  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>")  'dnl-volume-down)

  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp))

  (exwm-input-set-key (kbd "s-\\") (lambda () (interactive)(start-process-shell-command "tex" nil "~/bin/texpander.sh")))

  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
  (add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

  ;; GOLD!
  (exwm-input-set-key (kbd "s-SPC") #'doom/leader)

  (add-hook 'exwm-mode-hook (lambda () (setq mode-line-format nil)))

  ;; (require 'exwm-systemtray)
  ;; (exwm-systemtray-enable)

  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode) '("\\.fish\\'" . sh-mode))

  (start-process-shell-command "picom" nil "picom")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (start-process-shell-command "keys" nil "/home/daniel/bin/keys")
  (start-process-shell-command "greenclip daemon" nil "greenclip daemon")
  (start-process-shell-command "udiskie" nil "udiskie --tray")
  (start-process-shell-command "blueman" nil "blueman-applet")
                                        ;(start-process-shell-command "cbatticon" nil "cbatticon")
  (start-process-shell-command "pasystray" nil "pasystray")
  ;;(start-process-shell-command "redshift" nil "redshift-gtk")

  (call-process-shell-command "(sleep 10s && ~/.dropbox-dist/dropboxd) &" nil 0)
  (call-process-shell-command "(sleep 5s && dunst) &" nil 0)
  (call-process-shell-command "(sleep 5s && polybar) &" nil 0)
  ;;(start-process-shell-command "camera" "camera" "bash ~/Dropbox/Geekery/dogs.sh")
  ;;

  (add-to-list 'default-frame-alist '(alpha 90))
  (display-time-mode 1)
  (exwm-enable)


  ;; Plantuml
  (setq org-plantuml-jar-path (expand-file-name "~/bin/plantuml")
        plantuml-jar-path (expand-file-name "~/bin/plantuml"))

  (defun dw/send-polybar-hook (name number)
    (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" name number)))

  (defun dw/update-polybar-exwm ()
    (dw/send-polybar-hook "exwm" 1))

  (add-hook 'exwm-workspace-switch-hook #'dw/update-polybar-exwm)

  (defun dw/polybar-exwm-workspace ()
    (format "[ %s ]" exwm-workspace-current-index)))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-fairy-floss)


(use-package! lsp-ui
  :config
  (setq
   lsp-enable-file-watchers nil

   lsp-ui-doc-enable t
   lsp-ui-doc-position 'top
   lsp-ui-doc-include-signature t
   lsp-ui-doc-use-childframe nil
   lsp-ui-doc-header t

   lsp-ui-flycheck-enable t
   lsp-ui-flycheck-list-position 'left
   lsp-flycheck-live-reporting t

   lsp-ui-peek-enable t
   lsp-ui-peek-list-width 60
   lsp-ui-peek-peek-height 25

   lsp-ui-sideline-delay 1.2
   lsp-ui-sideline-enable t
   lsp-ui-sideline-enable t
   lsp-ui-sideline-show-diagnostics t
   lsp-ui-sideline-show-hover t
   lsp-ui-sideline-show-symbol t)

  (map! :n "M-." 'lsp-ui-peek-find-definitions)
  (map! :n "M-/" 'lsp-ui-peek-find-references))

(use-package! web
  :hook
  (prettier-js))


;; (use-package! company-lsp
;;   :hook (java-mode . company-mode)
;;   :hook (web-mode . company-mode)
;;   :hook (php-mode . company-mode)
;;   :config
;;   (push 'company-lsp company-backends))

                                        ;(use-package! company-box
                                        ;:hook (company-mode . company-box-mode))

(use-package! treemacs
  :config
  (setq treemacs-position 'left))

(use-package! lsp-mode
  :config
  (define-key lsp-mode-map (kbd "s-l") nil))

(use-package! evil-numbers
  :commands 'evil-numbers
  :config
  (map! :leader :desc "Increment Number" "+" 'evil-numbers/inc-at-pt)
  (map! :leader :desc "Decrement Number" "-" 'evil-numbers/dec-at-pt))

;; (use-package! lsp-java
;;   :config
;;   (require 'lsp-java-boot)
;;   )

(use-package! ledger-mode :bind ("C-TAB" . ledger-post-align-xact))

(use-package! string-inflection)

(use-package! helm
  :config
  (setq helm-split-window-default-side 'right
        helm-ff-auto-update-initial-value t))

;;; lsp java
(use-package! lsp-java
  :config
  (add-hook 'java-mode-hook 'lsp)
  (setq lsp-java-vmargs
        '("-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/home/daniel/java/libs/lombok.jar")))

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! dap-java :after (lsp-java))
;;; lsp java

(use-package! keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))


;;; Popups
;; https://github.com/hlissner/doom-emacs/issues/1086#issuecomment-463511339
(set-popup-rule! "\\*compilation\\*" :ignore t)
(set-popup-rule! "\\*PLANTUML Preview\\*" :ignore t)
(set-popup-rule! "\\*Ledger Report\\*" :ignore t)
;(set-popup-rule! "\\*[hH]elm\\*" :ignore t)


(use-package! helm-swoop
  :config
  (map! :leader "/" 'helm-swoop)
  (map! :leader :desc "Helm Swoop"      "d W" 'helm-swoop-back-to-last-point)

  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

  (define-key helm-swoop-map (kbd "C-p") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-n") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-p") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-n") 'helm-next-line)

  (setq helm-multi-swoop-edit-save t) ; Save buffer when helm-multi-swoop-edit complete
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-move-to-line-cycle t)
  (setq helm-swoop-use-line-number-face t)

  (setq helm-swoop-use-fuzzy-match t))

(use-package! org-journal
  :config
  (setq org-journal-dir "~/Dropbox/Org/diary"
        org-journal-file-type 'weekly
        org-journal-file-format "%Y%m%d.org"))

(use-package! flycheck
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enable)))


(use-package! org-pomodoro
  :config
  (setq org-pomodoro-play-sounds nil))

(use-package! helm-ag
  :config
  (setq helm-ag-base-command "rg --no-heading"))

(use-package! helm-rg
  :config
  (setq helm-rg-default-extra-args "--ignore=public"))

(use-package! prettier-js
  :config
  (setq prettier-js-args '("--trailing-comma" "all" "--vue-indent-script-and-style" "true" "--print-width" "90")))

(load! "maps.el")
(load! "dnl-functions")
(load! "dnl-php")
