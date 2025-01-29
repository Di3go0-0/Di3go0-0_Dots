
# Setting Up Copy-Paste in Neovim with WSL

## 1. Download `win32yank.exe`

If you don't have it yet, download it and place it in a directory accessible from WSL:

```sh
curl -LO https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip win32yank-x64.zip -d ~/.local/bin/
chmod +x ~/.local/bin/win32yank.exe
```

## 2. Verify that `win32yank.exe` works

Run this command in WSL to check if `win32yank.exe` is available:

```sh
echo "test" | ~/.local/bin/win32yank.exe -i
~/.local/bin/win32yank.exe -o
```

If you see "test" in the output, then `win32yank` is working correctly.

---

## 3. Add `win32yank.exe` to `PATH` in Fish

Run this command in `fish` to add the directory where `win32yank.exe` is located to the `PATH`:

```fish
set -Ua fish_user_paths $HOME/.local/bin
```

This will permanently add the `~/.local/bin` directory to the `PATH` in `fish`.

## 4. Verify that `win32yank.exe` is in `PATH`

Close and reopen your terminal or run:

```fish
echo $PATH
```

Make sure `~/.local/bin` appears in the output. Then, check if `win32yank.exe` works:

```fish
echo "test" | win32yank.exe -i
win32yank.exe -o
```

If it prints "test", then it is working correctly.

---

## 5. Reload Fish Configuration

If the previous step didn't work, reload the configuration with:

```fish
exec fish
```

With this setup, `win32yank.exe` should be ready to sync the clipboard between Neovim in WSL and Windows. 🚀
