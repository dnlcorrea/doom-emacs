;;; ~/.doom.d/larav-el.el -*- lexical-binding: t; -*-
;;; Wrapper around artisan for emacs.

;; Major mode
(define-derived-mode laravel-mode fundamental-mode "Laravel"
  "Major mode for laravel artisan functionality."
  ; bind c controller or something
  )

;TODO
;;Menu with popup.
(defun laravel-menu()
  "Creates a popup buffer for laravel-mode."
  ; TODO: Set buffer read only
  ; NOTE: is major-mode workin'?
  (let ((inhibit-read-only t))
    (setq laravel-buffer (get-buffer-create "*Laravel*"))
    (pop-to-buffer laravel-buffer)
    (insert-file-contents "laravel-buffer.txt")
    (read-only-mode)))
