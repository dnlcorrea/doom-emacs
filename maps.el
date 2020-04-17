;;; ~/.doom.d/maps.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DNL-MODE, MO'FO'
(map! :leader :desc "Small Term"      "d ." 'dnl-commander-window)
(map! :leader :desc "Toggle Floating" "d a" 'exwm-floating-toggle-floating)
(map! :leader :desc "Invert Boolean"  "d b" 'dnl-invert-boolean)
;; c
;; d
(map! :leader :desc "Emmet PHP"       "d e" 'dnl-php-emmet)
;; f
;; g
;; h
;; i
;; j
;; k
(map! :leader :desc "laravel mode"    "d l" 'laravel-menu)
(map! :leader :desc "Main"            "d m" (lambda() (interactive) (find-file "~/org/main.org")))
(map! :leader :desc "Create new map"  "d n" 'dnl-new-map)
;; o
;; p
;; q
;; r
(map! :leader :desc "SSH Config"      "d s" (lambda() (interactive) (find-file "~/.ssh/config")))
(map! :leader :desc "Tech Folder"     "d t" (lambda() (interactive) (find-file "~/org/Tech/")))
;; u
;; v
;; x
;; y
;; w
;;z


(map! :leader :desc "Format Code"   "c f" 'lsp-format-buffer)


(map! :leader :desc "Finance" "d f"
      (lambda()
        (interactive)
        (find-file (format "~/finance/%s/%s/%s-main.ledger"
                           (format-time-string "%Y")
                           (format-time-string "%m-%b")
                           (format-time-string "%m-%b")))))

(map! :desc "Emmet, activate!" "M-e" 'emmet-expand-line)

(map! :map web-mode-map
      :i "C-e" 'emmet-preview-mode
      :desc "Emmet Preview"
      :leader "c p" 'emmet-preview-mode)

;; Remaps
(map! :leader :desc "M-x" "x" 'helm-M-x)

(map! :leader :desc "Kill Ring" "y" 'helm-show-kill-ring)

(map! :leader :desc "Eval last sexp" "m e j" 'eval-print-last-sexp)

;; YAS
(map! "C-l" 'yas-expand)
(map! "C-j" 'yas-next-field)


(map! :leader :desc "New Snippet" "a n" 'yas-new-snippet)
(map! :leader :desc "Edit Snippet" "a e" 'yas-visit-snippet-file)

(map! :leader "s m" 'helm-mark-ring)

(map! :leader :desc "Ace Window" "w w" 'ace-window)

(map! :leader :desc "evilem down" "j" 'evilem-motion-next-line)
(map! :leader :desc "evilem up" "k" 'evilem-motion-previous-line)


(map! :leader :desc "Treemacs Symbols" "o s" 'lsp-treemacs-symbols)

(map! :leader "\\" 'dnl-commander-window)

(defun go-fuck-yourself()
  (interactive)
  (save-buffer)
  (message "formatting")
  (start-process-shell-command
   "lol" nil (format "npx prettier --write %s" (buffer-file-name)))
  (revert-buffer))


(map! :map web-mode-map :leader "m p" 'go-fuck-yourself)

;; Dired
(evil-define-key 'normal dired-mode-map (kbd "o") 'dired-find-file-other-window)

(map! :leader "d i" 'string-inflection-cycle)

(map! :desc "Locate" "C-SPC" 'company-complete)

(map! :ni "M-y" 'yas-insert-snippet)
(map!  "C-<backspace>" 'evil-change-whole-line)

(map! :leader "c a" 'lsp-execute-code-action)

(map! :map org-mode-map "<f12>" 'tomatinho)

(map! :leader :desc "Increment Number" "+" 'evil-numbers/inc-at-pt)
(map! :leader :desc "Decrement Number" "-" 'evil-numbers/dec-at-pt)
