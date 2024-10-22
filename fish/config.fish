if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx PATH /bin /usr/bin /usr/local/sbin /usr/local/bin /usr/sbin /sbin /usr/games /usr/local/games /snap/bin /home/diego/.dotnet/tools $PATH

if not set -q ZELLIJ
    zellij
end
