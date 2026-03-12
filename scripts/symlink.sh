#!/bin/bash

# Unified Dotfiles Symlink Script
# Creates symbolic links from repo dotfiles to ~/.config
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get the dotfiles repo directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$REPO_DIR/.config"

echo -e "${BLUE}🚀 Creating symbolic links for dotfiles...${NC}"
echo -e "${BLUE}Repo directory: $REPO_DIR${NC}"
echo -e "${BLUE}Config directory: $CONFIG_DIR${NC}"

# Function to create backup
backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$backup_dir"
        mv "$file" "$backup_dir/"
        echo -e "${YELLOW}  Backed up existing file to: $backup_dir/$(basename "$file")${NC}"
    fi
}

# Function to create symbolic link
create_symlink() {
    local src="$1"
    local dest="$2"
    local desc="$3"

    # Check if existing symlink points to a different location
    if [[ -L "$dest" ]]; then
        local current_target=$(readlink -f "$dest")
        local new_target=$(readlink -f "$src")
        if [[ "$current_target" != "$new_target" ]]; then
            echo -e "${YELLOW}  ⚠ Removing old symlink: $dest${NC}"
            rm -f "$dest"
        else
            echo -e "${YELLOW}  ✓ $desc already linked correctly${NC}"
            return 0
        fi
    fi

    echo -e "${BLUE}Linking $desc...${NC}"

    mkdir -p "$(dirname "$dest")"
    backup_file "$dest"
    rm -rf "$dest"
    ln -sf "$src" "$dest"
    echo -e "${GREEN}  ✓ $desc linked${NC}"
}

# Ensure ~/.config exists
echo -e "${BLUE}📁 Creating ~/.config directory if needed...${NC}"
mkdir -p "$HOME/.config"

# Process root dotfiles
echo -e "${BLUE}📋 Processing root dotfiles...${NC}"
ROOT_FILES=(".bashrc" ".gitconfig" ".editorconfig" ".gitignore")
for file in "${ROOT_FILES[@]}"; do
    if [[ -f "$REPO_DIR/$file" ]]; then
        create_symlink "$REPO_DIR/$file" "$HOME/$file" "$file"
    fi
done

# Process all directories and files in .config
if [[ -d "$CONFIG_DIR" ]]; then
    echo -e "${BLUE}📋 Processing all config files...${NC}"
    
    for item in "$CONFIG_DIR"/*; do
        if [[ -e "$item" ]]; then
            item_name=$(basename "$item")
            dest_path="$HOME/.config/$item_name"
            create_symlink "$item" "$dest_path" "$item_name"
        fi
    done
else
    echo -e "${RED}❌ Config directory not found: $CONFIG_DIR${NC}"
    exit 1
fi

# Additional resources (wallpapers, fonts, etc.)
RESOURCES_DIR="$REPO_DIR/Resources"
if [[ -d "$RESOURCES_DIR" ]]; then
    echo -e "${BLUE}🎨 Organizing additional resources...${NC}"
    
    # Organized wallpaper structure
    if [[ -d "$RESOURCES_DIR/wallpapers" ]]; then
        mkdir -p "$HOME/Pictures/wallpapers"
        
        # Create organized wallpaper categories
        mkdir -p "$HOME/Pictures/wallpapers/anime"
        mkdir -p "$HOME/Pictures/wallpapers/nature"
        mkdir -p "$HOME/Pictures/wallpapers/city"
        mkdir -p "$HOME/Pictures/wallpapers/gaming"
        mkdir -p "$HOME/Pictures/wallpapers/general"
        
        echo -e "${BLUE}📸 Organizing wallpapers by category...${NC}"
        
        # Categorize wallpapers
        for wallpaper in "$RESOURCES_DIR/wallpapers"/*; do
            if [[ -f "$wallpaper" ]]; then
                filename=$(basename "$wallpaper")
                
                case "$filename" in
                    *DD*|*IMG*)
                        ln -sf "$wallpaper" "$HOME/Pictures/wallpapers/general/$filename"
                        echo -e "${GREEN}  ✓ $filename → general${NC}"
                        ;;
                    *berserk*|*relaxedmario*|*switchswirl*)
                        ln -sf "$wallpaper" "$HOME/Pictures/wallpapers/anime/$filename"
                        echo -e "${GREEN}  ✓ $filename → anime${NC}"
                        ;;
                    *aurora*|*firewatch*|*nightcity*|*osaka*)
                        ln -sf "$wallpaper" "$HOME/Pictures/wallpapers/nature/$filename"
                        echo -e "${GREEN}  ✓ $filename → nature${NC}"
                        ;;
                    *arcade*|*escapevelocity*)
                        ln -sf "$wallpaper" "$HOME/Pictures/wallpapers/gaming/$filename"
                        echo -e "${GREEN}  ✓ $filename → gaming${NC}"
                        ;;
                    *)
                        ln -sf "$wallpaper" "$HOME/Pictures/wallpapers/city/$filename"
                        echo -e "${GREEN}  ✓ $filename → city${NC}"
                        ;;
                esac
            fi
        done
        
        # Create wallpaper index file
        cat > "$HOME/Pictures/wallpapers/README.md" << 'EOF'
# Wallpaper Collection

## Categories
- **anime/**: Anime and gaming related wallpapers
- **nature/**: Natural landscapes and scenery
- **city/**: Urban environments and cityscapes
- **gaming/**: Gaming themed wallpapers
- **general/**: Miscellaneous wallpapers

## Usage
Set your wallpaper using a tool like `swaybg` or configure in your Hyprland config:

```bash
swaybg -i ~/Pictures/wallpapers/nature/firewatch.jpg
```
EOF
    fi
    
    # Link to resources in home directory
    create_symlink "$RESOURCES_DIR" "$HOME/.config/Resources" "Resources"
fi

echo -e "\n${GREEN}🎉 Dotfiles linking completed!${NC}"
echo -e "\n${BLUE}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal or source your shell config"
echo -e "  2. Install missing dependencies with: ${YELLOW}./scripts/packages.sh${NC}"
echo -e "  3. Configure any application-specific settings as needed"

if [[ -d "$HOME/.dotfiles_backup" ]]; then
    echo -e "\n${YELLOW}📦 Backed up files are stored in: ~/.dotfiles_backup${NC}"
fi

echo -e "\n${GREEN}✨ Enjoy your new dotfiles!${NC}"