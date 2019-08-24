# My dockerfiiiiles~~~~

## My magic to summon my dev env~~~

```bash
curl -sSLf goo.gl/2Is6c9 | bash -s
```

on first book the emacs server might take a bit to start (~1mn?).

### Basic stuff

| command | doc |
|---------|-----|
|`/m` | is host home |
|`/host` | is host `/` |
|`shell` | starts a mosh console with tmux in |
|`start-fk-dev-container` | starts a new container |
|`C-\ d` | to close a tmux session |
|`C-\ c` | to create a tmux window |
|`C-\ S-2` | pane down |
|`C-\ S-5` | pane right |
|`C-\ M-{arrow}` | resize pane |
|`C-\ x` | close pane |
|`C-\ 1,2,3,4...` | select window |
|`C-\ C-\` | to switch tmux window |
|`e` | is emacsclient |
|`fe` | is fasd + emacs client |
|`guix`| package stuff, for instance `guix package -i guile` installs guile locally|

### Bit more advanced

| command | doc |
|---------|-----|
|`,` | from / to /home/johan `, h/j` |
|`,,` | from /home/johan/foo/bar/zoo to /home `,, h` |
|`,,,` | goes backward then forward! fun! |
|`f` | file, `f -s tosearch` list with scores, `f -l` without scores, `f -e <cmd>` command on file |
|`a` | any, cf. f |
|`s` | search, cf. f |
|`d` | dir, cf. f |
|`z` | cd using fasd! |
|`h` | highlights stuff in many colors, `cat log | h this and that` |

### TODO

- autoinstall of guix packages declared in freakhill/dotguix
- history in dropbox
- support for mounts (mount -t vboxsf D_DRIVE /d)
- sudo? do we want sudo? ... meh
