;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Rafael Perez"
      user-mail-address "rafaelsperez@vivaldi.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "Fira Code" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-vibrant)
;;(setq doom-theme 'doom-acario-dark)
;;(setq doom-theme 'doom-dark+)
;;(setq doom-theme 'doom-ephemeral)
;;(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'doom-Iosvken)
;;(setq doom-theme 'doom-nord)
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-palenight)
;;(setq doom-theme 'doom-sourcerer)
;;(setq doom-theme 'doom-mono-dark)
;;(setq doom-theme 'spacemacs-light)
;;(setq doom-theme 'doom-monokai-pro)
;;(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/Dropbox/Org/")
  (setq org-agenda-files '("~/Dropbox/Org/agenda.org"))
  (setq org-log-done 'time)
  ;;(setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJECT(p)" "STUDY(s)" "|" "DONE(d)" "CANCELLED(c)")))
)

(after! org-roam
  (setq org-roam-graph-viewer (executable-find "vimb"))
  (setq org-roam-graph-executable "/usr/bin/neato")
  (setq org-roam-directory "~/Dropbox/Org")
  (setq org-roam-graph-extra-config '(("overleap" . "false")))
  (setq org-roamgraph-exclude-matcher '("private" "ledger" "elfeed" "readinglist"))

  (setq bibtex-completion-bibliography '("~/bibliography.bib")
        bibtex-completion-library-path '("~/bibliography")
        bibtex-completion-find-note-functions '(orb-find-note-file))

  (setq org-roam-dailies-capture-templates
        '(("d" "daily" plain (function org-roam-capture--get-point)
           ""
           :imediate-finish t
           :file-name "private-%<%Y-%m-%d>"
           :head "#+TITLE: %<%Y-%m-%d>")))
  )

(setq org-re-reveal-klipsify-src t)

(after! org-kanban
  :config
  (defun org-kanban//link-for-heeading (heading file description)
    "Create link for a HEADING optionally a FILE and DESCRIPTION."
    (if heading
        (format "[[%s][%s][%s]]" heading file description)
      (error "Illegal state")))
  )

(use-package! org-ref)
  (after! org-ref
  (setq org-ref-default-bibliography '("~/bibliography.bib")
        org-ref-pdf-directory "~/bibliography"
        org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n :Custom_ID:%k\n :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n :AUTHOR: %9a\n :JOURNAL: %j\n :YEAR: %y\n :VOLUME: %v\n :PAGES: %p\n :DOI: %D\n :URL: %U\n :END:\n\n"
        org-red-notes-directory "~/Dropbox/Org"
        org-red-note-functions 'orb-edit-notes)
  )

(use-package! org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  ;;(setq org-roam-server-host "192.0.0.1")
  (setq orb-preformat-keywords
        '("=key" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${=key=}"
           :head "#+TITLE: ${=key=}: ${title}
#+ROAM_KEY: ${ref}
#+ROAM_TAGS: article

- tags ::
- keywords :: ${keywords}

* ${title}
:PROPERTIES:
:Custom_ID: ${=key=}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(file-relative-name (orb-process-file-field \"${=key=}\") (print org-directory))
:NOTER_PAGE:
:END:

** CATALOG

*** Motivation :springGreen:
*** Model :lightSkyblue:
*** Remarks
*** Applications
*** Expressions
*** References :violet:

** NOTES
"
           :unnarrowed t)))
  )

(org-roam-bibtex-mode)
(use-package! org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-lenght 60
        org-roam-server-network-label-wrap-length 20))

(use-package! org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  ("C-c n y" . org-journal-today)
  :config
  (setq orj-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-file-format "private-%Y-%m-%d.org"
        org-journal-dir "~/Dropbox/Org"
        org-journal-carryover-items nil
        org-journal-date-format "%Y-%m-%d")
  (set-file-template! "/private-.*\\.org$" :trigger "" :mode 'org-mode)
  (print +file-templates-alist)
  (defun org-journal-today ()
    (interactive)
    (org-journal-new-entry t)))

(use-package! org-noter
  :config
  (setq
   org-noter-pdftools-markup-pointer-color "yellow"
   org-noter-notes-search-path '("~/Dropbox/Org")
   ;; org-noter-insert-note-no-questions t
   org-noter-doc-split-fraction '(0.7 . 03)
   org-noter-always-create-frame nil
   org-noter-hide-other nil
   org-noter-pdftools-free-pointer-icon "Note"
   org-noter-pdftools-free-pointer-color "red"
   org-noter-kill-frame-at-session-end nil
   )
  (map! :map (pdf-view-mode)
        :leader
        (:prefix-map ("n" . "notes")
         :desc "Write notes"                    "w" #'org-noter)
        )
  )

(use-package! org-pdftools
  :hook (org-load . org-pdftools-setup-link))

(use-package! org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))




;;(def-package! org-super-agenda
;;  :after org-agenda
;;  :init
;;  (setq org-super-agenda-group '((:name "Today"
;;                                  :time-grid t
;;                                  :scheduled today)
;;                                 (:name "Due today"
;;                                  :deadline today)
;;                                 (:name "Important"
;;                                  :priority "A")
;;                                 (:name "Overdue"
;;                                 :deadline past)
;;                               (:name "Due soon"
;;                                  :deadline future)
;;                                 (:name "Big Outcomes"
;;                                  :tag "bo"))
;;        )
;;  :config
;;  (org-super-agenda-mode)
;;  )


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;;(defvar hexcolour-keywords
;;  '(("#[abcdef[:digit:]]\\{6\\}"
;;     (0 (put-text-property (match-beginning 0)
;;                           (match-end 0)
;;                           'face (list :background
;;                                       (match-string-no-properties 0)))))))

;;(defun hexcolour-add-to-font-lock ()
;;  (font-lock-add-keywords nil hexcolour-keywords))

;;(add-hook run-mode-hook 'hexcolour-add-to-font-lock)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(setq user-email-address "rafaelsperez@vivaldi.net"
      user-full-name "Rafael Perez"
      mu4e-get-email-command "mbsync -c ~/.config/mbsyncrc -a"
      mu4e-update-interval 300
      mu4e-main-buffer-hide-personal-addresses t
      message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.vivaldi.net" 587 nil nil))
      mu4e-sent-folder "account-1/Sent"
      mu4e-drafts-foler "account-1/Drafts"
      mu4e-trash-folder "account-1/Trash"
      mu4e-maildir-shortcuts
      '(("/account-1/Inbox"             . ?i)
        ("/account-1/Sent Items"        . ?s)
        ("/account-1/Drafts"            . ?d)
        ("/account-1/Trash"             . ?t)))
