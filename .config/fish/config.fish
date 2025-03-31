set -g fish_greeting

# This line is only for hyprland enviroment
source ~/.config/fish/hyde_config.fish

set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH

if status is-interactive
    and not set -q ZELLIJ
    and not set -q ZELLIJ_SESSION_NAME
    zellij
end

alias P="pj open"

set -gx PROJECT_PATHS ~/WorkSpace/Project/

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias vc='code'

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'
set -gx PATH $HOME/.linuxbrew/bin $PATH

starship init fish | source

## Configuración de Oracle
set -gx LD_LIBRARY_PATH /opt/oracle/instantclient_23_7/
set -gx ORACLE_HOME /opt/oracle/instantclient_23_7/
set -gx PATH /opt/oracle/instantclient_23_7/ $PATH
