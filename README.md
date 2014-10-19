### Sane Term

Ansi Term with sane options and the ability to cycle/create terms.

__Overview__

* `sane-term` will cycle through term buffers, creating one if there are none.
* `sane-term-create` will create a new term buffer.

__Setup__

```
(require 'sane-term)
(global-set-key (kbd "C-x t") 'sane-term)
(global-set-key (kbd "C-x T") 'sane-term-create)
```

__Variables__

* `sane-term-shell-command` [`"/bin/bash"`] - shell to use for sane-term.
* `sane-term-initial-create` [`t`] - `sane-term` will create first term if none exist.
* `sane-term-kill-on-exit` [`t`] - C-d or `exit` will kill the term buffer.
* `sane-term-next-on-kill` [`t`] - After killing a term buffer, cycle to another.
* `sane-term-no-underline` [`t`] - Remove underline face in the term.