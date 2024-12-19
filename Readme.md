# Dots my personal set-up configuration

## _The tools I use to enhance my workflow_

[![Nvim](https://img.shields.io/badge/Editor-Neovim-green)](https://neovim.io/)
[![LazyVim](https://img.shields.io/badge/Config-LazyVim-yellow)](https://github.com/LazyVim/LazyVim)
[![WezTerm](https://img.shields.io/badge/Terminal-WezTerm-orange)](https://wezfurlong.org/wezterm/)
[![Zellij](https://img.shields.io/badge/Terminal-Zellij-blue)](https://zellij.dev/)
[![Fish](https://img.shields.io/badge/Shell-Fish-cyan)](https://fishshell.com/)
[![Starship](https://img.shields.io/badge/Prompt-Starship-red)](https://starship.rs/)
[![LazyGit](https://img.shields.io/badge/Git-LazyGit-lightgrey)](https://github.com/jesseduffield/lazygit)

## Content

- [Prerequisites](#prerequisites)
- [Why i use these tools](#why-i-use-these-tools)
- [Installation](#installation)
- [Custom configurations](#custom-configurations)

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

## Installation

> [!IMPORTANT]  
> To set up this configuration, follow these steps:

1. **Install Homebrew**  
   Homebrew is a package manager that makes installing and managing software on macOS and Linux easier. First, install Homebrew by running the following command in your terminal:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

   - For additional installation instructions and troubleshooting, check the official [Homebrew installation page](https://brew.sh/).

2. **Install Neovim**  
   Install Neovim using Homebrew by running:

   ```bash
   brew install neovim
   ```

3. **Install WezTerm**  
   To install WezTerm, run:

   ```bash
   brew install wezterm
   ```

4. **Install Zellij**  
   Zellij can be installed with Homebrew by running:

   ```bash
   brew install zellij
   ```

5. **Install Fish**  
   Fish shell can be installed with:

   ```bash
   brew install fish
   ```

6. **Install Starship**  
   To install Starship prompt, run:

   ```bash
   brew install starship
   ```

7. **Install LazyGit**  
   LazyGit, a simple terminal UI for Git, can be installed via Homebrew with:

   ```bash
   brew install lazygit
   ```

8. **Install Fisher**  
   Before installing PJ, you must first install Fisher, a plugin manager for Fish. You can do this via Homebrew:

   ```bash
   brew install fisher
   ```

   For more details on Fisher, you can visit the official [Fisher GitHub page](https://github.com/jorgebucaran/fisher).

9. **Install PJ (plugin-pj)**  
   After installing Fisher, use it to install the PJ plugin for easy project switching:

   ```bash
   fisher install oh-my-fish/plugin-pj
   ```

10. **Install FZF Plugin**  
    You can also install the FZF plugin for fuzzy searching and navigation:

    ```bash
    fisher install patrickf1/fzf.fish
    ```

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

If you want to use the image from the repository, change it to the absolute path of the image in your system. The image is located in the [`wezterm/IMG/DD20.png`](Resources/IMG/DD20.png) folder of the repository. For example, if your home directory is `/home/diego`, you should set the following:

```lua
config.window_background_image = "/home/diego/wezterm/IMG/DD20.png"
```

---
