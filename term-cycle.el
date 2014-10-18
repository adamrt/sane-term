;;; term-cycle.el --- Multi Term is crazy. This is not.

;; Copyright (C) 2014 Adam Patterson

;; Author: Adam Patterson <adam@adamrt.com>
;; Maintainer: Adam Patterson <adam@adamrt.com>
;; URL: http://github.com/adamrt/term-cycle
;; Created: 2014-10-18
;; Version: 0.1
;; Keywords: term, multi, ansi-term
;; Package-Requires: ((emacs "24.1"))

;;; Commentary:

;; You can set it up like this:

;;     (require 'term-cycle)
;;     (global-set-key (kbd "C-x t") 'term-cycle)
;;     (global-set-key (kbd "C-x T") 'term-cycle-create)

;;; Code:

(defconst term-cycle-version "0.1"
  "Currently running version of term-cycle.")

(defgroup term-cycle nil
  "Multi Term is crazy. This is not."
  :group 'term)

(defcustom term-cycle-initial-create t
  "Creates a term if one doesn't exist."

  :type 'boolean
  :group 'term-cycle)


(defcustom term-cycle-kill-on-exit t
  "Kill term buffer on exit (C-d or `exit`)."
  :type 'boolean
  :group 'term-cycle)

(defcustom term-cycle-cycle-on-kill t
  "Cycle to another term when one is killed.
Depends on term-cycle-kill-on-exit."

  :type 'boolean
  :group 'term-cycle)

(defun term-mode-buffers-exist-p ()
  "Boolean if term-mode buffers exist."
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (if (string= "term-mode" major-mode)
          (return t)))))


(defun term-cycle-next ()
  "Cycle through term buffers."
  (interactive)
  (if (string= "term-mode" major-mode)
      (bury-buffer))
  (dolist (buf (buffer-list))
    (when (with-current-buffer buf (string= "term-mode" major-mode))
      (switch-to-buffer buf)
      (return t))))


(defun term-cycle-create ()
  "Create new term buffer."
  (interactive)
  (ansi-term "/bin/bash"))


(defun term-cycle ()
  "Cycle through term buffers, creating if necessary."
  (interactive)
  (if term-cycle-initial-create
      (unless (term-mode-buffers-exist-p)
        (term-cycle-create)))
  (term-cycle-next))


(defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
  "Kill term buffers on exiting term (C-d or `exit`).
Optionally cycle to next term buffer."

  (if term-cycle-kill-on-exit
      (kill-buffer)
    (if term-cycle-cycle-on-kill
        (term-cycle-next))))

(provide 'term-cycle)

;;; term-cycle.el ends here
