
# Dots | Hyprland & Terminal Setup

## *A modular, automated workflow for efficiency*

---

## 🖥️ Desktop Environment

This setup focuses on a high-performance Wayland experience:

* **Window Manager:** [Hyprland](https://hyprland.org/) (Dynamic Tiling)
* **Status Bar:** [Waybar](https://github.com/Alexays/Waybar) (Highly customizable)
* **Application Launcher:** [Rofi (Wayland)](https://github.com/davatorium/rofi)
* **Logout Menu:** [Wlogout](https://www.google.com/search?q=https://github.com/Artsy0/wlogout)

## 🐚 Terminal Ecosystem

My terminal workflow is designed for speed and modern syntax:

* **Text Editor:** [Neovim](https://neovim.io/) (The heart of my coding)
* **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/) (GPU-accelerated)
* **Shells:** [Nushell](https://www.nushell.sh/) & [Fish](https://fishshell.com/)
* **Multiplexer:** [Zellij](https://zellij.dev/)
* **Prompt:** [Starship](https://starship.rs/)

---

## 📂 Repository Structure

```text
.
├── init.sh                <-- Run this to start the setup
├── Resources
│   ├── Font.png
│   └── wallpapers/        <-- Hand-picked collection (Tokyo Night, Arcade, etc.)
├── scripts/
│   ├── grub.sh            # Theme & Boot config
│   ├── nushell.sh         # Shell environment setup
│   ├── packages.sh        # Dependency management
│   ├── sddm-astronaut.sh  # Login manager theme
│   └── symlink.sh         # Dotfiles linking via GNU Stow
└── stow.md

```

---

## 🚀 One-Step Installation

The entire environment is automated. To deploy this configuration on a fresh system, simply execute the initialization script:

```bash
chmod +x init.sh
./init.sh

```

> [!TIP]
> This script handles package installation, shell configuration, and UI styling automatically.

---

## क्यों (Why this setup?)

* **Performance:** Utilizing Wayland and GPU-accelerated tools (Kitty, Hyprland) ensures a lag-free experience.
* **Modernity:** Moving from traditional shells to **Nushell** allows for structured data handling in the terminal.
* **Aesthetics:** A consistent theme across SDDM, Waybar, and Neovim creates a distraction-free environment.
* **Automation:** Using `init.sh` and symlinking ensures that moving to a new machine takes minutes, not hours.

---

## 🔡 Required Font

To display icons and symbols correctly in the terminal and Waybar, I use the **CaskaydiaCove Nerd Font Mono**.

**Download:** [CascadiaCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip)

1. Download the ZIP.
2. Extract files to `~/.local/share/fonts/`.
3. Update font cache: `fc-cache -fv`.

---

## 🤝 Contributing & Acknowledgements

Special thanks to [Gentleman-Programming](https://github.com/Gentleman-Programming) and [Nikolov Lazar](https://github.com/nikolovlazar) for the inspiration.

Feel free to fork this repo and adapt it to your own workflow!

Would you like me to add more detail to any specific script description or include the specific keybindings for Hyprland?
