# neovim-config

This repo holds the config files for my neovim setup.

To use it, first make a backup of your old config directory, then remove it. Old config directory is here: `~/.config/nvim/`.

Then just clone this config into your `~/.config/`. Make sure it's named correctly. Here's one way of doing it:
```
cd ~/.config/
git clone https://github.com/joshua-holmes/neovim-config.git && mv neovim-config nvim
```

OR you can just symlink it:
```
git clone https://github.com/joshua-holmes/neovim-config.git && mv neovim-config nvim
ln -s neovim-config ~/.config/nvim
```

Note that this setup is for me, so you may have to tweak some things to make it yours.
