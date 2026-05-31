#!/bin/bash

# Base Dotfiles Setup Script (arch-hypr branch)
# Installs only what is needed for the dots to run on any Arch + Hyprland box.
# PC-specific configuration (default shell, monitors, themes) is NOT applied here.
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Get the dotfiles repo directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date '+%H:%M:%S')] $message${NC}"
}

# Function to run a script if it exists
run_script() {
    local script="$1"
    local description="$2"

    if [[ -f "$SCRIPTS_DIR/$script" ]]; then
        print_status "$BLUE" "$description"
        chmod +x "$SCRIPTS_DIR/$script"
        bash "$SCRIPTS_DIR/$script"
        print_status "$GREEN" "Done: $description"
    else
        print_status "$YELLOW" "Skipped (not found): $script"
    fi
}

# Function to verify installation
verify_installation() {
    if [[ -f "$SCRIPTS_DIR/verify.sh" ]]; then
        print_status "$BLUE" "Verifying installation..."
        chmod +x "$SCRIPTS_DIR/verify.sh"
        bash "$SCRIPTS_DIR/verify.sh" || true
    fi
}

# Function to show next steps
show_next_steps() {
    print_status "$CYAN" "Base install done. Optional steps (run only what you want):"
    echo -e "  1. ${YELLOW}Edit monitors${NC}:        ~/.config/hypr/monitors.lua  (current values are PC-specific)"
    echo -e "  2. ${YELLOW}Nushell plugins${NC}:      bash scripts/nushell.sh"
    echo -e "  3. ${YELLOW}Fish plugins${NC}:         bash scripts/fish.sh"
    echo -e "  4. ${YELLOW}Default shell${NC}:        chsh -s \$(which fish)   # or nu, bash..."
    echo -e "  5. ${YELLOW}Themes / extras${NC}:"
    echo -e "       - GRUB theme:           bash scripts/grub.sh"
    echo -e "       - Spotify + Spicetify:  bash scripts/spotify.sh"
    echo -e "       - SDDM theme:           bash scripts/sddm-astronaut-setup.sh"
    echo -e "  6. ${YELLOW}Reboot${NC} and launch Hyprland"

    if [[ -d "$HOME/.dotfiles_backup" ]]; then
        echo -e "\n${YELLOW}Backed up files: ~/.dotfiles_backup${NC}"
    fi

    echo -e "\n${GREEN}Done.${NC}"
}

# Main execution
main() {
    clear
    print_status "$PURPLE" "Di3go0-0's Dotfiles Setup"
    print_status "$BLUE" "================================"

    # Check if running as root (shouldn't be)
    if [[ $EUID -eq 0 ]]; then
        print_status "$RED" "Don't run this script as root!"
        exit 1
    fi

    # Check if in correct directory
    if [[ ! -d "$REPO_DIR/.config" ]]; then
        print_status "$RED" ".config directory not found in repo!"
        exit 1
    fi

    print_status "$BLUE" "Repository: $REPO_DIR"
    print_status "$BLUE" "Home directory: $HOME"

    # Ask for confirmation
    echo -e "\n${YELLOW}This will install BASE packages and symlink your dots.${NC}"
    echo -e "${YELLOW}Default shell, monitors and themes are NOT touched.${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "$YELLOW" "Setup cancelled"
        exit 0
    fi

    # 1. Install base packages (includes yay install + system update)
    run_script "packages.sh" "Installing base packages..."

    # 2. Backup critical files before overwriting
    run_script "backup-critical.sh" "Backing up critical files..."

    # 3. Create symlinks
    run_script "symlink.sh" "Setting up dotfiles symlinks..."

    # 4. Post-setup tasks (font cache, icon cache, wallust bootstrap)
    run_script "post-setup.sh" "Running post-setup tasks..."

    # 5. Verify
    verify_installation

    # 6. Next steps (manual scripts the user runs themselves)
    show_next_steps
}

# Run main function
main "$@"
