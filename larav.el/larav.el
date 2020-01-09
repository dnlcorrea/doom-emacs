;;; ~/.doom.d/larav-el.el -*- lexical-binding: t; -*-
;;; Wrapper around artisan for emacs.
;;; TODO: Create a buffer for some of the creation commands,
;;; with flags, e.g., controllers can be resource controllers,
;;; so you can select them


;;; TODO: Is there an artisan file at project root? If not, nag

(defconst laravel-dir (file-name-directory load-file-name))

;; Major mode
(define-derived-mode laravel-mode fundamental-mode "Laravel"
  "Major mode for laravel artisan functionality."
  ; bind c controller or something
  )

(add-to-list 'evil-emacs-state-modes 'laravel-mode)

(defun laravel--buffer(name file)
  "Creates a buffer for interactin'"
  (setq laravel-buffer (get-buffer-create name))
  (if (/= (buffer-size laravel-buffer) 0)
      (pop-to-buffer laravel-buffer)
    (let ((inhibit-read-only t))
      (pop-to-buffer laravel-buffer)
      (laravel-mode)
      (insert-file-contents (expand-file-name file laravel-dir))
      (fit-window-to-buffer)
      (read-only-mode)
      (get-buffer-create name))))

(defun laravel-menu()
  "Creates a popup buffer for laravel-mode."
  (interactive)
  (if (file-exists-p (format "%sartisan" (projectile-project-root)))
   (laravel--buffer "*Laravel*" "laravel-buffer.txt")
   (message "There's no 'artisan' on %s. So...no." (projectile-project-root))
   ))

;; Loads
(load (expand-file-name "controller.el" laravel-dir))

;;; Maps
(define-key laravel-mode-map (kbd "c") 'laravel-create-controller)
(define-key laravel-mode-map (kbd "q") 'kill-this-buffer)

;;; Helpers
;;(exwm-input-set-key (kbd "s-8") (lambda()(interactive)(load "~/.doom.d/larav.el/larav.el")))
