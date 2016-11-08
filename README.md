### Sane Term

sane-term is ansi-term with sane options and the ability to cycle/create terms.

__Overview__

* `sane-term` will cycle through term buffers, creating one if there are none.
* `sane-term-create` will create a new term buffer.

__Setup__

```emacs
;; Enable sane term
(require 'sane-term)
(global-set-key (kbd "C-x t") 'sane-term)
(global-set-key (kbd "C-x T") 'sane-term-create)


;; Optional convenience binding. This allows C-y to paste even when in term-char-mode (see below). 
(add-hook 'term-mode-hook (lambda() (define-key term-raw-map (kbd "C-y") (lambda () (interactive) (term-line-mode) (yank) (term-char-mode)))))
```

When in a sane-term buffer you can use `C-c C-j` to switch to term-line-mode, which you can then treat like a normal emacs buffer (move, yank, etc). `C-c C-k` will return you to term-char-mode, which will act like a traditional ansi-term.

__Variables__

* `sane-term-shell-command` [`$SHELL or "/bin/sh"`] - shell to use for sane-term.
* `sane-term-initial-create` [`t`] - `sane-term` will create first term if none exist.
* `sane-term-kill-on-exit` [`t`] - C-d or `exit` will kill the term buffer.
* `sane-term-next-on-kill` [`t`] - After killing a term buffer, cycle to another.

__Common Issues__

When you start a term you may find your environment variables are not set. This is the proper, yet unexpected behavior. You can read about it here https://github.com/adamrt/sane-term/issues/6 but the gist is that your `~/.profile` is not being read. Non-login shells read from `~/.bashrc` instead. Put the following in your `~/.bashrc` (create it if necessary).

```
source /etc/profile
source ~/.profile
```
