#!/bin/bash

# Critical Files Backup/Restore Script for Dotfiles Installation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Critical files to protect
CRITICAL_FILES=(
    "$HOME/.ssh/config"
    "$HOME/.ssh/known_hosts"
    "$HOME/.ssh/id_rsa"
    "$HOME/.ssh/id_ed25519"
    "$HOME/.gnupg/gpg.conf"
    "$HOME/.gnupg/gpg-agent.conf"
    "$HOME/.config/Code/User/settings.json"
    "$HOME/.config/BraveSoftware/Brave-Browser/Default/Preferences"
    "$HOME/.mozilla/firefox/profiles.ini"
    "$HOME/.local/share/keyrings/login.keyring"
    "$HOME/.aws/credentials"
    "$HOME/.aws/config"
    "$HOME/.config/gcloud/application_default_credentials.json"
    "$HOME/.docker/config.json"
    "$HOME/.kube/config"
)

BACKUP_DIR="$HOME/.dotfiles_backup/critical"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Function to report
success() { echo -e "${GREEN}✅ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
info() { echo -e "${CYAN}ℹ️  $1${NC}"; }

# Function to backup critical files
backup_critical_files() {
    echo -e "${BLUE}🔐 Backing up critical files...${NC}"
    mkdir -p "$BACKUP_DIR"
    
    local backed_up=0
    
    for file in "${CRITICAL_FILES[@]}"; do
        if [[ -f "$file" || -d "$file" ]]; then
            local backup_name="$(basename "$file")_$TIMESTAMP"
            local backup_path="$BACKUP_DIR/$backup_name"
            
            # Preserve permissions and structure
            cp -rp "$file" "$backup_path" 2>/dev/null || {
                warning "Could not backup $file (permissions issue)"
                continue
            }
            
            success "Backed up: $file → $backup_name"
            ((backed_up++))
            
            # Create metadata file for restore info
            echo "original_path=$file" > "$backup_path.meta"
            echo "backup_time=$TIMESTAMP" >> "$backup_path.meta"
            echo "original_type=$(file -b "$file" 2>/dev/null || echo "unknown")" >> "$backup_path.meta"
        fi
    done
    
    if [[ $backed_up -gt 0 ]]; then
        success "Backed up $backed_up critical files to $BACKUP_DIR"
        
        # Create restore script
        cat > "$BACKUP_DIR/restore_critical.sh" << 'EOF'
#!/bin/bash
# Auto-generated restore script for critical files
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

BACKUP_DIR="$(dirname "$0")"
ORIGINAL_DIR="$HOME"

echo -e "${BLUE}🔄 Restoring critical files...${NC}"

for backup in "$BACKUP_DIR"/*.meta; do
    if [[ -f "$backup" ]]; then
        source "$backup"
        backup_file="${backup%.meta}"
        
        if [[ -f "$backup_file" || -d "$backup_file" ]]; then
            echo -e "${GREEN}Restoring: $original_path${NC}"
            cp -rp "$backup_file" "$original_path"
        fi
    fi
done

echo -e "${GREEN}✅ Critical files restored!${NC}"
EOF
        chmod +x "$BACKUP_DIR/restore_critical.sh"
        info "Restore script created: $BACKUP_DIR/restore_critical.sh"
    else
        info "No critical files found to backup"
    fi
}

# Function to restore critical files
restore_critical_files() {
    if [[ ! -d "$BACKUP_DIR" ]]; then
        error "No backup directory found: $BACKUP_DIR"
        return 1
    fi
    
    echo -e "${BLUE}🔄 Restoring critical files...${NC}"
    
    if [[ -f "$BACKUP_DIR/restore_critical.sh" ]]; then
        bash "$BACKUP_DIR/restore_critical.sh"
    else
        error "Restore script not found"
        return 1
    fi
}

# Function to list available backups
list_backups() {
    if [[ ! -d "$BACKUP_DIR" ]]; then
        info "No backup directory found"
        return
    fi
    
    echo -e "${BLUE}📋 Available backups in $BACKUP_DIR:${NC}"
    
    for meta in "$BACKUP_DIR"/*.meta; do
        if [[ -f "$meta" ]]; then
            source "$meta"
            local backup_file="${meta%.meta}"
            local backup_status="exists"
            
            [[ ! -f "$backup_file" ]] && backup_status="missing"
            
            echo -e "  ${GREEN}•${NC} $(basename "$original_path") ($backup_time) - $backup_status"
        fi
    done
}

# Main script logic
case "${1:-backup}" in
    "backup")
        backup_critical_files
        ;;
    "restore")
        restore_critical_files
        ;;
    "list")
        list_backups
        ;;
    *)
        echo "Usage: $0 {backup|restore|list}"
        echo "  backup  - Backup critical files"
        echo "  restore - Restore critical files from backup"
        echo "  list    - List available backups"
        exit 1
        ;;
esac