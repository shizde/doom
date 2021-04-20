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
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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
