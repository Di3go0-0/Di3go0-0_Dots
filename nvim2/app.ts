Failed to run `config` for telescope - fzf - native.nvim
...m / lazy / telescope.nvim / lua / telescope / _extensions / init.lua: 10: 'fzf' extension doesn't exist or isn't installed: ...hare / nvim / lazy / telescope - fzf - native.nvim / lua / fzf_lib.lua: 11: /home/diego /.local / share / nvim / lazy / telescope - fzf - native.nvim / lua /../ build / libfzf.so: cannot open shared object file: No such file or directory
# stacktrace:
- /telescope.nvim/lua / telescope / _extensions / init.lua: 10 _in_ ** load_extension **
  - /telescope.nvim/lua / telescope / _extensions / init.lua: 62 _in_ ** load_extension **
    - lua / plugins / editor / editor.lua: 158 _in_ ** config **
      - lua / config / lazy.lua: 16
        - init.lua: 2
Failed to run `config` for telescope.nvim
...m / lazy / telescope.nvim / lua / telescope / _extensions / init.lua: 10: 'fzf' extension doesn't exist or isn't installed: loop or previous error loading module 'telescope._extensions.fzf'
# stacktrace:
- /telescope.nvim/lua / telescope / _extensions / init.lua: 10 _in_ ** load_extension **
  - /telescope.nvim/lua / telescope / _extensions / init.lua: 62 _in_ ** load_extension **
    - lua / plugins / editor / editor.lua: 124 _in_ ** values **
      - lua / config / lazy.lua: 16
        - init.lua: 2
