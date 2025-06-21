## 📄 `README.md`

````markdown
# 💻 Configuración personalizada de Nushell

Este documento describe cómo configurar un entorno de desarrollo moderno con [Nushell](https://www.nushell.sh), integrando herramientas poderosas como `zoxide`, `carapace`, `atuin`, `starship`, y variables de entorno personalizadas.

---

## 📦 Requisitos

- Nushell `>= 0.89`
- Arch Linux (u otra distro compatible)
- Gestor de paquetes como `pacman` o `yay`

---

## 📁 Estructura esperada

```text
~/.config/nushell/
├── config.nu             # Archivo principal de configuración de Nushell
├── env.nu                # Opcional (si usas entorno separado)
├── bash-env.nu           # Variables de entorno personalizadas
~/.zoxide.nu              # Configuración de zoxide
~/.cache/
│   └── starship/init.nu  # Prompt de starship
│   └── carapace/init.nu  # Autocompletado externo
~/.local/share/atuin/
    └── init.nu           # Historial inteligente
```
````

---

## 🧠 Configuración en `config.nu`

Asegúrate de que tu archivo `~/.config/nushell/config.nu` contenga al menos estas líneas:

```nu
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu
source ~/.local/share/atuin/init.nu
source ~/.cache/starship/init.nu
source ~/.config/bash-env.nu
```

---

## 🚀 Instalación paso a paso

### 1. Instalar herramientas necesarias

```bash
sudo pacman -S nushell starship zoxide carapace atuin
```

---

### 2. Configurar zoxide (navegación rápida)

```nu
nu
zoxide init nushell | save -f ~/.zoxide.nu
```

---

### 3. Configurar carapace (autocompletado inteligente)

```bash
mkdir -p ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
```

---

### 4. Configurar atuin (historial inteligente)

```bash
mkdir -p ~/.local/share/atuin
atuin init nu | save -f ~/.local/share/atuin/init.nu
```

> Puedes registrarte y sincronizar tu historial si lo deseas:
>
> ```bash
> atuin register
> atuin sync
> ```

---

### 5. Configurar starship (prompt personalizado)

```bash
mkdir -p ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
```

Personaliza el prompt en `~/.config/starship.toml`.

---

### 6. Configurar archivo de entorno personalizado (`bash-env.nu`)

Crea el archivo:

```nu
nvim ~/.config/bash-env.nu
```

Con el contenido:

```nu
export-env {
  $env.MY_CUSTOM_VAR = "valor"
  $env.PATH = ($env.PATH | append '/ruta/adicional')
}
```

Esto te permite agregar rutas personalizadas o variables que quieras tener disponibles siempre.

---

## 🧪 Verificación

Reinicia Nushell:

```bash
nu
```

Y prueba:

```nu
z # navegación con zoxide
zi # búsqueda interactiva de zoxide
atuin search # historial inteligente
echo $env.MY_CUSTOM_VAR # variable definida
```

---

## 🎨 Bonus: Personalización

Puedes agregar temas y configuraciones extra para:

- `starship` → edita `~/.config/starship.toml`
- `zoxide` → ver comandos con `zoxide --help`
- `atuin` → ver configuración en `~/.config/atuin/config.toml`

---

## ✅ Resultado final

Tendrás un shell moderno, rápido, con navegación eficiente, historial poderoso, autocompletado inteligente y un prompt estilizado:

✨ **Zoxide + Carapace + Atuin + Starship + Entorno Personalizado**

---
