# dotfiles

## AI Shit

## Claude Skills

.claude/

## NeoVim :sunglasses:

`.config/nvim` is the default config (in this repo).

Profiles use `NVIM_APPNAME` — switch interactively with `nvims` (fzf), or launch directly:

| Command | Profile | Notes |
|---------|---------|-------|
| `nvim` / `v` | personal | Main config (this repo) |
| `nvim-lazyvim` | lazyvim | [LazyVim starter](https://github.com/LazyVim/starter) — clone separately |
| `nvim-nvchad` | nvchad | [NvChad starter](https://github.com/NvChad/starter) — clone separately |
| `nvim-kick` | kick | [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — clone separately |

Community profiles are git submodules — they are cloned automatically with:

```sh
git clone --recurse-submodules <this-repo>
```

Update tracked submodules from upstream:

```sh
sync-submodules
```

## Emacs

Doom uses the current XDG-style split between framework and private config:

```
dotfiles repo:
  .config/doom/                 Doom private config (config.el, init.el, packages.el)
  .config/emacs-personal/       optional standalone Evil config

not in repo:
  ~/.config/emacs/              Doom framework checkout
```

Bootstrap once per machine:

```sh
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

The Doom framework checkout should stay outside this dotfiles repo. Only
`.config/doom` is stowed. Avoid keeping both `~/.config/doom` and `~/.doom.d`;
Doom only recognizes one private config directory.
