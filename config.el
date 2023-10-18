(setq user-full-name "xxxxx"
      user-mail-address "xxxxx@gmail.com")

;; Controlling fonts 
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for org-tree-slide presentations.

;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; I don't want my org files in the default location 
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;;Disable exit confirmation.
(setq confirm-kill-emacs nil)

;;Maximize the window upon startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;;Images to constant width
(setq org-image-actual-width 400)

;; Pomodoro timer within emacs
;; Copy of the .el file from play-sound-osc. This is a work around for dbus not being supported by my old mac
;; This  makes org timer set timer work.
(eval-when-compile (require 'cl))
(defun play-sound-internal (sound)
;;  "Internal function for `play-sound' (which see)."
  (or (eq (car-safe sound) 'sound)
      (signal 'wrong-type-argument (list sound)))
  (destructuring-bind (&key file data volume device)
      (cdr sound)
    (and (or data device)
        (error "DATA and DEVICE arg not supported"))
    (apply #'start-process "afplay" nil
           "afplay" (append (and volume (list "-v" volume))
                            (list (expand-file-name file data-directory))))))
(provide 'play-sound)

(setq org-clock-sound "~/.emacs.d/pomodoroTimerSounds/rez_pomo_02.wav")

; org-tree-slide for presentations
;; Changed keybindings to make the presentation smoothly.
(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>") 'org-tree-slide-move-next-tree)
  )

;; Org Roam database 
(setq org-roam-directory "~/roam")
(after! org-roam
(setq org-roam-dailies-capture-templates
    '(("d" "default" entry "* %<%I:%M %p>: %?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
)

  ;; Set up org-mode export LaTeX to pdf
  (setq org-latex-to-mathml-convert-command
        "java -jar %j -unicode -force -df %o %I"
        org-latex-to-mathml-jar-file
        "/home/wouter/Tools/math2web/mathtoweb.jar")

;; Academic doom config for LaTeX
(setq-default
 delete-by-moving-to-trash t)                      ; Delete files to trash)

(setq undo-limit 80000000                          ; Raise undo-limit to 80Mb
      evil-want-fine-undo t)                             ; By default while in insert all changes are one big blob. Be more granular)
(global-subword-mode 1)                           ; Iterate through CamelCase words

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                           ; On laptops it's nice to know how much power you have

;; Latex - Set up org-mode to export LaTeX 
(after! ox-latex
(after! org
  (add-to-list 'org-latex-classes
               '("apa6"
"\\documentclass{apa6}"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)
)

;;ignore whitespace for ediff comparision of old and new files
(setq-default ediff-ignore-similar-regions t)
(setq-default ediff-highlight-all-diffs nil)
