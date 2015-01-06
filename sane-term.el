;;; sane-term.el --- Multi Term is crazy. This is not.

;; Copyright (C) 2014 Adam Patterson

;; Author: Adam Patterson <adam@adamrt.com>
;; URL: http://github.com/adamrt/sane-term
;; Version: 0.1
;; Package-Requires: ((emacs "24.1"))

;;; Commentary:

;; You can set it up like this:

;;     (require 'sane-term)
;;     (global-set-key (kbd "C-x t") 'sane-term)
;;     (global-set-key (kbd "C-x T") 'sane-term-create)

;;; Code:

(defgroup sane-term nil
  "Multi Term is crazy. This is not."
  :group 'term)

(defcustom sane-term-shell-command "/bin/bash"
  "Specify which shell to use."
  :type 'string
  :group 'sane-term)

(defcustom sane-term-initial-create t
  "Creates a term if one doesn't exist."
  :type 'boolean
  :group 'sane-term)

(defcustom sane-term-kill-on-exit t
  "Kill term buffer on exit (C-d or `exit`)."
  :type 'boolean
  :group 'sane-term)

(defcustom sane-term-next-on-kill t
  "When killing a term buffer, go to the next one.
Depends on sane-term-kill-on-exit."
  :type 'boolean
  :group 'sane-term)

(defun sane-term-buffer-exists-p ()
  "Boolean if term-mode buffers exist."
  (catch 'loop
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'term-mode)
          (throw 'loop t))))))

(defun sane-term-next ()
  "Cycle through term buffers."
  (when (derived-mode-p 'term-mode)
    (bury-buffer))
  (catch 'loop
    (dolist (buf (buffer-list))
      (when (with-current-buffer buf (derived-mode-p 'term-mode))
        (switch-to-buffer buf)
        (throw 'loop nil)))))

;;;###autoload
(defun sane-term-create ()
  "Create new term buffer."
  (interactive)
  (ansi-term sane-term-shell-command))

;;;###autoload
(defun sane-term ()
  "Cycle through term buffers, creating if necessary."
  (interactive)
  (when sane-term-initial-create
    (unless (sane-term-buffer-exists-p)
      (sane-term-create)))
  (sane-term-next))

(defadvice term-handle-exit
    (after term-kill-buffer-on-exit activate)
  "Kill term buffers on exiting term (C-d or `exit`).
Optionally go to next term buffer."
  (when sane-term-kill-on-exit
    (kill-buffer)
    (when sane-term-next-on-kill
      (sane-term-next))))


(provide 'sane-term)

;;; sane-term.el ends here
