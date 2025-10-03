# env.nu
#
# Installed by:
# version = "0.105.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PATH = ($env.PATH | split row (char esep) | append '/usr/bin' | append '/usr/local/bin')

export-env {
    $env.LD_LIBRARY_PATH = "/opt/oracle/instantclient_23_9"
    $env.ORACLE_HOME = "/opt/oracle/instantclient_23_9"
    $env.PATH = ($env.PATH | split row (char esep) | prepend "/opt/oracle/instantclient_23_9" | str join (char esep))
}

