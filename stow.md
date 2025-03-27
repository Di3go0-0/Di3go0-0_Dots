# Symbolic links

- To delete symbolics links from a folder

```fish
find ~/folder -maxdepth 1 -type l -exec rm {} \;

```

- To make a symbolic links of .config

```fish
stow -t ~/.config/ .config/ --adopt
```

- To make a symbolic links of .wezterm.lua

```fish
stow -t ~/ wezterm/ --adopt
```

- To make a symbolic links of .wezterm.lua in Windows

```fish
  stow -t /mnt/c/Users/user/ wezterm.Windows/ --adopt
```

