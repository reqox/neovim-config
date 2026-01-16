# NeoVim setup

## How to use

1. Clone this config
2. Backup old config (if exists)
3. Install new config
4. Clear cache
5. Start nvim

```bash
git clone https://github.com/reqox/neovim-config.git
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
mv ./neovim-config ~/.config/nvim
~/.config/nvim/nvim--clear  # Clear cache (optional, for clean install)
nvim
```

## Clear cache manually (if needed)

```bash
~/.config/nvim/nvim--clear
```
