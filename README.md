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

Uses [Chemacs2](https://github.com/plexus/chemacs2) as a profile switcher. This repo
manages the editable config; the frameworks live outside it as plain git clones:

```
dotfiles repo:
  .config/chemacs/profiles.el   profile definitions
  .config/doom/                 Doom private config (config.el, init.el, packages.el)
  .config/emacs-personal/       minimal Evil config → "personal" profile

not in repo (clone once per machine):
  ~/doom-emacs/                 Doom framework      → "default" profile
  ~/emacs-kick/                 emacs-kick          → "kick" profile
  ~/.emacs.d/                   Chemacs2 bootloader
```

Bootstrap once per machine:

```sh
git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
git clone https://github.com/doomemacs/doomemacs ~/doom-emacs
git clone https://github.com/LionyxML/emacs-kick ~/emacs-kick
~/doom-emacs/bin/doom install
```

### Profiles

| Launch | Profile | Notes |
|--------|---------|-------|
| `emacs` | default | Doom Emacs (`~/doom-emacs`) |
| `emacs --with-profile personal` | personal | Minimal Evil config (this repo) |
| `emacs --with-profile kick` | kick | [emacs-kick](https://github.com/LionyxML/emacs-kick) (`~/emacs-kick`) |

