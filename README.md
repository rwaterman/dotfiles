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

## Emacs

Uses [Chemacs2](https://github.com/plexus/chemacs2) as a profile switcher. Everything
editable lives under `.config`:

```
.config/
  chemacs/profiles.el   profile definitions (Chemacs2 reads this natively)
  doom/                 Doom private config (config.el, init.el, packages.el)
  emacs-doom/           Doom framework      → "default" profile   [submodule]
  emacs-kick/           emacs-kick          → "kick" profile       [submodule]
  emacs-personal/       minimal Evil config → "personal" profile
```

The **Chemacs2 bootloader** is the one piece not in this repo — Emacs loads it from
`~/.emacs.d`. Bootstrap it once per machine:

```sh
git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
```

The framework submodules come down with `git clone --recurse-submodules`. After cloning,
build the Doom profile:

```sh
~/.config/emacs-doom/bin/doom install
```

### Profiles

| Launch | Profile | Notes |
|--------|---------|-------|
| `emacs` | default | Doom Emacs (`~/.config/emacs-doom`) |
| `emacs --with-profile personal` | personal | Minimal Evil config (this repo) |
| `emacs --with-profile kick` | kick | [emacs-kick](https://github.com/LionyxML/emacs-kick) |

