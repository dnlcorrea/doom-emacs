;;; package --- DNL's PHP config
;;; Commentary:
;;; Check out tinker and guard.  Cool

;;; Code:

;;(require 'cl)

(use-package! transient
  :config
  (define-transient-command php-transient-menu ()
    "Php"
    [["Class"
      ("cc" "Copy" phpactor-copy-class)
      ("cn" "New" phpactor-create-new-class)
      ("cr" "Move" phpactor-move-class)
      ("ci" "Inflect" phpactor-inflect-class)
      ("n"  "Namespace" phpactor-fix-namespace)]
     ["Properties"
      ("a"  "Accessor" phpactor-generate-accessors)
      ("pc" "Constructor" phpactor-complete-constructor)
      ("pm" "Add missing props" phpactor-complete-properties)
      ("r" "Rename var locally" phpactor-rename-variable-local)
      ("R" "Rename var in file" phpactor-rename-variable-file)]
     ["Extract"
      ("ec" "constant" phpactor-extract-constant)
      ("ee" "expression" phpactor-extract-expression)
      ("em"  "method" phpactor-extract-method)]
     ["Methods"
      ("i" "Implement Contracts" phpactor-implement-contracts)
      ("m"  "Generate method" phpactor-generate-method)]
     ["Navigate"
      ("x" "List refs" phpactor-list-references)
      ("X" "Replace refs" phpactor-replace-references)
      ("."  "Goto def" phpactor-goto-definition)]
     ["Phpactor"
      ("s" "Status" phpactor-status)
      ("u" "Install" phpactor-install-or-update)]])
  (map! :leader "c p" 'php-transient-menu))


;; Check if some class is being used in current file
(defun php-class-is-being-used ()
  (save-excursion
    (save-match-data
      (goto-char (point-min))
      (search-forward (thing-at-point 'symbol t) nil t))))

;; Check if there are other instances of some class
;; and edit ir apropriately
(defun php-create-use-statement ()
  "Create a use statement with class on point."
  (interactive)
  (save-excursion
    (skip-chars-backward "a-zA-Z\\\\")
    (setq p1 (point))
    (skip-chars-forward "a-zA-Z\\\\")
    (setq p2 (point))
    (goto-char (point-min))
    (search-forward "class")
    (forward-line -1)
    (insert (concat "use " (buffer-substring-no-properties p1 p2) ";"))
    (move-end-of-line 1)
    (newline))
  (skip-chars-forward "a-zA-Z\\\\")
  (skip-chars-backward "a-zA-Z")
  (setq p1 (point))
  (skip-chars-backward "a-zA-Z\\\\")
  (setq p2 (point))
  (delete-region p1 p2))

(defun dnl-tinker ()
  "Open a PsyShell buffer."
  (interactive)
  (projectile-run-shell)
  (insert "php artisan tinker")
  (comint-send-input)
  (rename-buffer "**tinker**"))

(defun dnl-watch ()
  "Run npm watch."
  (interactive)
  (start-process-shell-command
   "Watch" "**watch**" (format "urxvt -cd '%s' -e npm run watch" (projectile-project-root)))
  (message "Running Watch script."))

(defun dnl-serve ()
  "Run artisan serve."
  (interactive)
  (projectile-run-shell)
  (rename-buffer "**Serve**")
  (insert "art serve")
  (comint-send-input)
  (message "Running Serve"))

(defun dnl-dump-autoload ()
  "Run composer dump-autoload."
  (interactive)
  (projectile-run-async-shell-command-in-root)
  (insert "composer dump-autoload")
  (comint-send-input))

(defun dnl-chromedriver ()
  "Run Chrome-driver."
  (interactive)
  (start-process-shell-command "chromedriver" "**chromedriver**" (concat "cd " (projectile-project-root) "; vendor/laravel/dusk/bin/chromedriver-linux --port=8888"))
  (message "Running Watch script.")
  )

(add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode))

(provide 'dnl-php)
