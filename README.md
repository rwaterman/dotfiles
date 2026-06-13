# dotfiles

## NeoVim

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
