;;; ~/.doom.d/maps.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DNL-MODE, MO'FO'
(map! :leader :desc "Toggle Floating" "d a" 'exwm-floating-toggle-floating)
(map! :leader :desc "Invert Boolean"  "d b" 'dnl-invert-boolean)
(map! :leader :desc "Emmet PHP"       "d e" 'dnl-php-emmet)
(map! :leader :desc "Goals"           "d g" (lambda() (interactive) (find-file "~/org/Tech/Goals.org")))
(map! :leader :desc "laravel mode"    "d l" 'laravel-menu)
(map! :leader :desc "Main"            "d m" (lambda() (interactive) (find-file "~/org/main.org")))
(map! :leader :desc "Tech Folder"     "d t" (lambda() (interactive) (find-file "~/org/Tech/")))
(map! :leader :desc "SSH Config"      "d s" (lambda() (interactive) (find-file "~/.ssh/config")))
(map! :leader :desc "Wiki"            "d w" (lambda() (interactive) (find-file "~/org/Life Wiki.org")))

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
      :leader "c a" 'emmet-preview-mode)

;; Remaps
(map! :leader :desc "M-x" "x" 'counsel-M-x)

(map! :desc "Locate" "C-SPC" 'counsel-locate)

(map! :leader :desc "Kill Ring" "y" 'counsel-yank-pop)

(map! :leader :desc "Eval last sexp" "m e j" 'eval-print-last-sexp)

;; YAS
(map! "C-l" 'yas-expand)
(map! "C-j" 'yas-next-field)


(map! :leader :desc "New Snippet" "a n" 'yas-new-snippet)
(map! :leader :desc "Edit Snippet" "a e" 'yas-visit-snippet-file)

(map! :leader "s m" 'counsel-evil-marks)

(map! :leader :desc "Ace Window" "w w" 'ace-window)

(map! :leader :desc "evilem down" "j" 'evilem-motion-next-line)
(map! :leader :desc "evilem up" "k" 'evilem-motion-previous-line)


(map! :leader :desc "Treemacs Symbols" "o s" 'lsp-treemacs-symbols)

(map! :leader "\\" 'dnl-commander-window)
