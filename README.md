# NeoVim setup

## How to use
1. Clone this config in your repo
2. Move config to ~/.config/nvim
3. Delete a cache
4. Start nvim

```bash
git clone https://github.com/reqox/neovim-config.git
mv ~/.config/nvim ~/.config/nvim.yournvim.backup
mv ./neovim-config ./nvim && mv ./nvim ~/.config/
echo "rm -rfv ~/.local/state/nvim && rm -rfv ~/.local/share/nvim && rm -rfv ~/.cache/nvim" > ~/.config/nvim/nvim--clear && chmod a+x ~/.config/nvim/nvim--clear
```
