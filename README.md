# dotfiles

Personal macOS dotfiles for Liang's current machine.

This repo stores configuration only. It intentionally does not install apps, package managers, language runtimes, editor extensions, or CLIs.

## Included

- VSCodium settings, keybindings, and extension inventory
- zsh and Zim config
- Git global config and ignore files
- GitHub CLI config, excluding authenticated `hosts.yml`
- `mo` config
- Ghostty config as the primary terminal setup
- Kitty config and color files as secondary terminal setup

## Not Included

- nvim config
- GitHub CLI auth tokens
- Editor history, global storage, workspace storage, or cache data
- Tool installation scripts

## Wire Config Files

Run this from the repo root:

```sh
./setup.sh
```

The script backs up existing real files under `~/.dotfiles-backup/<timestamp>/` before replacing them with symlinks to this repo. Existing correct symlinks are left unchanged.

## Manual Steps

- Install tools and apps manually.
- Log in to GitHub CLI with `gh auth login`.
- Install VSCodium extensions manually if needed, using `vscodium/extensions.txt` as the inventory.
