#!/bin/bash

# Unified Dotfiles Setup Script for Ubuntu
# Complete installation and configuration for Di3go0-0's dotfiles
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

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to update system
update_system() {
    print_status $BLUE "🔄 Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    print_status $GREEN "✓ System updated"
}

# Function to install packages
install_packages() {
    print_status $BLUE "📦 Installing packages..."
    
    if [[ -f "$SCRIPTS_DIR/packages.sh" ]]; then
        chmod +x "$SCRIPTS_DIR/packages.sh"
        "$SCRIPTS_DIR/packages.sh"
        print_status $GREEN "✓ Packages installed"
    else
        print_status $RED "❌ packages.sh not found"
        exit 1
    fi
}

# Function to create symbolic links
setup_dotfiles() {
    print_status $BLUE "🔗 Setting up dotfiles..."
    
    if [[ -f "$SCRIPTS_DIR/symlink.sh" ]]; then
        chmod +x "$SCRIPTS_DIR/symlink.sh"
        "$SCRIPTS_DIR/symlink.sh"
        print_status $GREEN "✓ Dotfiles linked"
    else
        print_status $RED "❌ symlink.sh not found"
        exit 1
    fi
}

# Function to setup shell
setup_shell() {
    print_status $BLUE "🐚 Setting up shell configuration..."
    
    # Link bashrc if it exists
    if [[ -f "$REPO_DIR/.bashrc" ]]; then
        backup_file "$HOME/.bashrc"
        ln -sf "$REPO_DIR/.bashrc" "$HOME/.bashrc"
        print_status $GREEN "✓ bashrc linked"
    fi
    
    # Link gitconfig if it exists
    if [[ -f "$REPO_DIR/.gitconfig" ]]; then
        backup_file "$HOME/.gitconfig"
        ln -sf "$REPO_DIR/.gitconfig" "$HOME/.gitconfig"
        print_status $GREEN "✓ gitconfig linked"
    fi
    
    # Link editorconfig if it exists
    if [[ -f "$REPO_DIR/.editorconfig" ]]; then
        backup_file "$HOME/.editorconfig"
        ln -sf "$REPO_DIR/.editorconfig" "$HOME/.editorconfig"
        print_status $GREEN "✓ editorconfig linked"
    fi
}

# Function to backup existing files
backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$backup_dir"
        mv "$file" "$backup_dir/"
        print_status $YELLOW "  Backed up: $(basename "$file")"
    fi
}

# Function to verify installation
verify_installation() {
    print_status $BLUE "🔍 Verifying installation..."
    
    local errors=0
    
    # Check critical commands
    local commands=("nvim" "kitty" "waybar" "hyprland" "starship" "git")
    for cmd in "${commands[@]}"; do
        if command_exists "$cmd"; then
            print_status $GREEN "✓ $cmd"
        else
            print_status $RED "❌ $cmd not found"
            ((errors++))
        fi
    done
    
    # Check config files
    local configs=("$HOME/.config/hypr" "$HOME/.config/waybar" "$HOME/.config/kitty")
    for config in "${configs[@]}"; do
        if [[ -d "$config" ]]; then
            print_status $GREEN "✓ $(basename "$config") config"
        else
            print_status $RED "❌ $(basename "$config") config missing"
            ((errors++))
        fi
    done
    
    if [[ $errors -eq 0 ]]; then
        print_status $GREEN "🎉 Installation verified successfully!"
    else
        print_status $RED "⚠️  Found $errors issues during verification"
    fi
}

# Function to show next steps
show_next_steps() {
    print_status $CYAN "\n📋 Next Steps:"
    echo -e "  1. ${YELLOW}Restart your terminal${NC} or run: source ~/.bashrc"
    echo -e "  2. ${YELLOW}Reboot your system${NC} to apply all changes"
    echo -e "  3. ${YELLOW}Configure Hyprland${NC} by editing ~/.config/hypr/hyprland.conf"
    echo -e "  4. ${YELLOW}Test your setup${NC} by launching Hyprland"
    echo -e "  5. ${YELLOW}Customize themes${NC} in ~/.config/hypr/themes/"
    
    if [[ -d "$HOME/.dotfiles_backup" ]]; then
        echo -e "\n${YELLOW}📦 Backed up files: ~/.dotfiles_backup${NC}"
    fi
    
    echo -e "\n${GREEN}✨ Enjoy your new dotfiles!${NC}"
}

# Main execution
main() {
    clear
    print_status $PURPLE "🚀 Di3go0-0's Dotfiles Setup (Ubuntu)"
    print_status $BLUE "================================"
    
    # Check if running as root (shouldn't be)
    if [[ $EUID -eq 0 ]]; then
        print_status $RED "❌ Don't run this script as root!"
        exit 1
    fi
    
    # Check if in correct directory
    if [[ ! -d "$REPO_DIR/.config" ]]; then
        print_status $RED "❌ .config directory not found in repo!"
        print_status $RED "   Make sure you're running this from the dotfiles repo"
        exit 1
    fi
    
    print_status $BLUE "📍 Repository: $REPO_DIR"
    print_status $BLUE "🏠 Home directory: $HOME"
    
    # Ask for confirmation
    echo -e "\n${YELLOW}This will install packages and set up your dotfiles on Ubuntu.${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status $YELLOW "Setup cancelled"
        exit 0
    fi
    
    # Run setup steps
    update_system
    install_packages
    setup_dotfiles
    setup_shell
    verify_installation
    show_next_steps
}

# Run main function
main "$@"
