#!/usr/bin/env bash

set -e

echo "==> Importando clave PGP de Spotify..."
gpg --recv-keys C85668DF69375001

echo "==> Instalando Spotify desde AUR..."
yay -S --noconfirm spotify

echo "==> Instalando Spicetify CLI..."
yay -S --noconfirm spicetify-cli

echo "==> Creando carpeta de configuración de Spotify..."
mkdir -p ~/.config/spotify

if [ ! -f ~/.config/spotify/prefs ]; then
  echo "==> Creando archivo prefs vacío..."
  touch ~/.config/spotify/prefs
fi

echo "==> Ejecutando spicetify backup apply..."
spicetify backup apply || true

echo "==> Ajustando permisos en /opt/spotify..."
sudo chmod a+wr -R /opt/spotify
sudo chmod a+wr -R /opt/spotify/Apps

echo "==> Aplicando spicetify..."
spicetify apply

echo "✅ Instalación de Spotify + Spicetify completada."
echo "👉 Ahora puedes instalar temas (ej: Lucid) usando Marketplace o manualmente."
