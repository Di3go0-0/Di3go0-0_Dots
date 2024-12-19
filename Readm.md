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

## Prerequisites

> [!NOTE]  
> It is necessary to use a system with **Linux** or **macOS**, and have **git** installed.

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
