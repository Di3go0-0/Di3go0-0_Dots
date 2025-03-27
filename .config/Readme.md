# Create symbolic links

```fish
cd Di3go0-0_Config
```

- To move all files and folders to ./config from my ./config

```fish
 stow -t ~/.config/ .config/ --adopt
```

- To delete symbolic links of a folders

```fish
 find ~/folder -maxdepth 1 -type l -exec rm {} \;
```

- To move wezterm

```fish
  stow -t ~/ .wezterm.lua --adopt
```
