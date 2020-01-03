;;; ~/.doom.d/larav.el/controller.el -*- lexical-binding: t; -*-
;;;

(defvar laravel--controller-r nil "Controller is a resource controller.")

(defun laravel--clear-options()
  (setq laravel--controller-r nil))

(defun laravel-controller-toggle-r()
  (interactive)
  (read-only-mode -1)
  (if laravel--controller-r
      (progn
        (setq laravel--controller-r nil)
        (goto-char 0)
        (while (re-search-forward "-->r" nil t)
          (replace-match "r")))
    (progn
      (setq laravel--controller-r "-r ")
      (re-search-forward "^r" nil t)
      (beginning-of-line)
      (insert "-->")))
  (goto-char 0)
  (read-only-mode))

(defun laravel--do-create-controller()
  (interactive)
  (let
      ((controller-name
        (replace-regexp-in-string "Controller$" "" (read-string "Controller Name: "))))
    (async-shell-command
     (concat "php " (projectile-project-root)
             "artisan make:controller "
             laravel--controller-r
             controller-name "Controller"))
    (kill-buffer laravel-buffer)
    (laravel--clear-options)))

(defun laravel-create-controller()
  ;; A local bind goes here...
  (interactive)
  (laravel--buffer "*Laravel-Controller*" "laravel-controller.txt")
  (local-set-key (kbd "r") 'laravel-controller-toggle-r)
  (local-set-key (kbd "RET") 'laravel--do-create-controller))
