![504_1x_shots_so](https://github.com/Di3go0-0/Di3go0-0_Dots/blob/main/Resources/Font.png)

# Dots | My Personal Setup Configuration

## _The tools I use to enhance my workflow_

[![Nvim](https://img.shields.io/badge/Editor-Neovim-green)](https://neovim.io/)
[![LazyVim](https://img.shields.io/badge/Config-LazyVim-yellow)](https://github.com/LazyVim/LazyVim)
[![WezTerm](https://img.shields.io/badge/Terminal-WezTerm-orange)](https://wezfurlong.org/wezterm/)
[![Zellij](https://img.shields.io/badge/Terminal-Zellij-blue)](https://zellij.dev/)
[![Fish](https://img.shields.io/badge/Shell-Fish-cyan)](https://fishshell.com/)
[![Starship](https://img.shields.io/badge/Prompt-Starship-red)](https://starship.rs/)
[![LazyGit](https://img.shields.io/badge/Git-LazyGit-lightgrey)](https://github.com/jesseduffield/lazygit)

---

## Content

- [Prerequisites](#prerequisites)
- [Why i use these tools](#why-i-use-these-tools)
- [Installation](#installation)
- [Custom configurations](#custom-configurations)
- [Acknowledgements](#acknowledgements)
- [Contributing](#contributing)

---

## Prerequisites

> [!NOTE]  
> It's necessary to use a system based on **Unix** or **WSL**, and have **git** installed.

- [**Neovim**](https://neovim.io/)
- [**LazyVim**](/Readme.md)
- [**WezTerm**](https://wezfurlong.org/wezterm/)
- [**Zellij**](https://zellij.dev/)
- [**Fish**](https://fishshell.com/)
- [**Starship**](https://starship.rs/)
- [**pj**](https://github.com/oh-my-fish/plugin-pj)
- [**Homebrew**](https://brew.sh/)
- [**LazyGit**](https://github.com/jesseduffield/lazygi)

---

## Why i use these tools

> [!NOTE]
> This is my personal set-up configuration. Here’s a breakdown of why I chose each tool and how they enhance my workflow:

- [**Neovim**](https://neovim.io/) - Text Editor  
  A fast, lightweight, and highly extensible editor built for modern workflows, powered by Lua for ultimate flexibility.

- [**LazyVim**](https://github.com/LazyVim/LazyVim) - Configuration  
  A preconfigured Neovim setup that’s modular, efficient, and ready to use out of the box, saving time and boosting productivity.

- [**WezTerm**](https://wezfurlong.org/wezterm/) - Terminal Emulator  
  A fast, GPU-accelerated terminal with modern features like panes, tabs, and seamless integration with my workflow.

- [**Zellij**](https://zellij.dev/) - Terminal Multiplexer  
  A flexible, user-friendly multiplexer that simplifies session management with a clean UI and powerful keybindings.

- [**Fish**](https://fishshell.com/) - Shell  
  An interactive, user-friendly shell with intuitive syntax and powerful autocompletion, making terminal navigation faster and smoother.

- [**Starship**](https://starship.rs/) - Prompt  
  A blazing-fast, highly customizable prompt. I use it to display essential information like directory, Git status, and language versions.  
  With configurations like the **Kanagawa Dragon** palette and personalized symbols, it enhances my terminal aesthetic and workflow:

  ```toml
  [character]
  success_symbol = "[󱗞](fg:#957FB8)"
  error_symbol = "[󱗞](fg:red)"

  [directory]
  format = "[$path](bold fg:directory) "

  [cmd_duration]
  format = " took [ $duration](bold fg:duration) "

  [git_branch]
  format = "-> [ $branch](bold fg:git)"
  ```

- [**pj**](https://github.com/jkbrzt/pj) - Project Jump `plugin-pj`  
  I use **pj** to quickly jump between multiple project directories with ease. Here's my Fish configuration for fast project switching:

  ```fish
  # Alias for opening projects
  alias z="pj open"

  # Define common project paths
  set -gx PROJECT_PATHS ~/Documentos/aplications ~/Documentos/Universidad/
  ```

- [**Homebrew**](https://brew.sh/) - Package Manager  
  A powerful and user-friendly package manager for macOS and Linux that simplifies the installation, updating, and management of software packages. It automates the process of downloading, configuring, and installing tools you need, saving time and effort.

- [**LazyGit**](https://github.com/jesseduffield/lazygit) - Git Interface  
  A fast and intuitive terminal UI for Git that enhances your Git workflow. It provides a clean interface for managing branches, staging changes, committing, and more. LazyGit simplifies common Git operations with keyboard shortcuts and easy navigation, making version control much faster and more efficient.

---

## Installation

> **Important**
> Follow these steps to install the setup:

### 1. Install Fish

```bash
sudo apt install fish
chsh -s /usr/bin/fish
```

### 2. Install Homebrew

```fish
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH' >> ~/.config/fish/config.fish
```

### 3. Install Essential Tools

```fish
brew install neovim wezterm zellij starship lazygit fisher
```

### 4. Install Fish Plugins

```fish
fisher install oh-my-fish/plugin-pj
fisher install patrickf1/fzf.fish
```

---

## Custom configurations

- [Nvim Config](nvim)
- [LazyVim Config](lazyvim)
- [Wezterm Config](wezterm)
- [Zellij Config](zellij)
- [Fish Config](fish)
- [Starship Config](starship)
- [LazyGit Config](l)

Aquí tienes la sección configurada con el formato que pediste, excepto para Wezterm:

### Nvim Configuration

To modify your **Nvim** [nvim](nvim) configuration, move the configuration folder from the repository to the path `~/.config/nvim/`.

### Zellij Configuration

To modify your **Zellij** [zellij](zellij) configuration, move the configuration folder from the repository to the path `~/.config/zellij/`.

### Fish Configuration

To modify your **Fish** [fish](fish) configuration, move the configuration folder from the repository to the path `~/.config/fish/`.

### Starship Configuration

To modify your **Starship** [starship](starship) configuration, move the `starship.toml` file from the repository to the path `~/.config/`.

### LazyGit Configuration

To modify your **LazyGit** [LazyGit](lazygit) configuration, move the configuration folder from the repository to the path `~/.config/lazygit/`.

### Wezterm Configuration

To modify your **Wezterm** configuration, move the `.wezterm.lua` file to your home directory `~/`.

> **Important**: You need to install a **Nerd Font** for Wezterm to work with custom fonts. Here's how you can do it:

#### Installing Iosevka Nerd Font

1. First, you need to download **Iosevka Nerd Font**. Go to the official [Nerd Fonts GitHub page](https://github.com/ryanoasis/nerd-fonts) and download the font file for Iosevka.
2. After downloading the font file, unzip it into a folder. For example, you can unzip it in `~/.local/share/fonts/`.
3. Copy all the font files from the extracted folder to the font directory in your system (`~/.local/share/fonts/` or `/usr/share/fonts` depending on your system).

#### Configuring Wezterm to Use Iosevka Nerd Font

Once the font is installed, in your Wezterm configuration file (`.wezterm.lua`), use the following line to set the font:

```lua
config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Regular" })
```

This will set Iosevka as the terminal font for Wezterm.

#### Modifying the Background Image Path

In the Wezterm configuration file (`.wezterm.lua`), you also need to modify the path of the background image. On line 69, change the following line:

```lua
config.window_background_image = "/home/diego/Imágenes/Wallpapers/DD20.png"
```

If you want to use the image from the repository, change it to the absolute path of the image in your system. The image is located in the [`DD20.png`](Resources/IMG/DD20.png) folder of the repository. For example, if your home directory is `/home/diego`, you should set the following:

```lua
config.window_background_image = "/home/diego/wezterm/IMG/DD20.png"
```

---

## Acknowledgements

A special thanks to the following people for inspiring and sharing their amazing work:

- [**Gentleman-Programming**](https://github.com/Gentleman-Programming) for their contributions and configurations that significantly improved my setup.
- [**Nikolov Lazar**](https://github.com/nikolovlazar) for sharing their knowledge and tools, which helped shape this workflow.

Your work has been invaluable in enhancing my personal setup. Thank you for inspiring the community!

---

## Contributing

Contributions are always welcome!

If you have any suggestions, improvements, or fixes, feel free to open an issue or submit a pull request. Let's make this setup even better together 🚀.
