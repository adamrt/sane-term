## Sane Term

Ansi Term with sane options and the ability to cycle/create terms.

__Setup__

```
(require 'sane-term)
(global-set-key (kbd "C-x t") 'sane-term)
(global-set-key (kbd "C-x T") 'sane-term-create)
```

__Variables__

`sane-term-shell-command` - defaults to "/bin/bash". shell to use for sane-term.

`sane-term-initial-create` - defaults to true. `sane-term` will create first term if none exist.

`sane-term-kill-on-exit` - defaults to true. C-d or `exit` will kill the term buffer.

`sane-term-next-on-kill` - defaults to true. After killing a term buffer, cycle to another.

`sane-term-no-underline` - defaults to true. Remove underline face in the term.