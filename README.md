## Term Cycle

Cycle through terms.

Multi Term changed too many settings and broke my workflow. All I need is some
sane defaults and ability to cycle through terminals and create new ones.

__Setup__

```
(require 'term-cycle)
(global-set-key (kbd "C-x t") 'term-cycle)
(global-set-key (kbd "C-x T") 'term-cycle-create)
```

__Variables__

`term-cycle-shell-command` - defaults to "/bin/bash". shell to use for term-cycle

`term-cycle-initial-create` - defaults to true. `term-cycle` will create first term if none exist.

`term-cycle-kill-on-exit` - defaults to true. C-d or `exit` will kill the term buffer.

`term-cycle-cycle-on-kill` - defaults to true. After killing a term buffer, cycle to another.