;;; ~/.doom.d/larav-el.el -*- lexical-binding: t; -*-
;;; Wrapper around artisan for emacs.


(defconst laravel-dir (file-name-directory load-file-name))

;; Major mode
(define-derived-mode laravel-mode fundamental-mode "Laravel"
  "Major mode for laravel artisan functionality."
  ; bind c controller or something
  )

(add-to-list 'evil-emacs-state-modes 'laravel-mode)

(defun laravel-menu()
  "Creates a popup buffer for laravel-mode."
  (interactive)
  (setq laravel-buffer (get-buffer-create "*Laravel*"))
  (if (/= (buffer-size laravel-buffer) 0)
      (pop-to-buffer laravel-buffer)
    (let ((inhibit-read-only t))
      (pop-to-buffer laravel-buffer)
      (laravel-mode)
      (insert-file-contents (expand-file-name "laravel-buffer.txt" laravel-dir))
      (read-only-mode))))

(defun laravel-create-controller()
  (interactive)
  (let
      ((controller-name
        (replace-regexp-in-string "Controller$" "" (read-string "Controller Name: "))))
    (async-shell-command
     (format "php %sartisan make:controller %sController"
             (projectile-project-root)
             controller-name))))


;;; Maps
(define-key laravel-mode-map (kbd "c") 'laravel-create-controller)

;;; Helpers
                                        ;(exwm-input-set-key (kbd "s-8") (lambda()(interactive)(load "~/.doom.d/larav-el")))
