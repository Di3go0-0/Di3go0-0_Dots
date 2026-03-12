#!/usr/bin/env bash

set -e

echo "==> Installing Spotify..."
sudo apt install -y spotify-client

echo "==> Installing Spicetify CLI..."
npm install -g spicetify-cli

echo "==> Creating Spotify config directory..."
mkdir -p ~/.config/spotify

if [ ! -f ~/.config/spotify/prefs ]; then
    touch ~/.config/spotify/prefs
fi

echo "==> Running spicetify backup apply..."
spicetify backup apply || true

echo "==> Adjusting permissions..."
sudo chown -R $USER:$USER /opt/spotify 2>/dev/null || true
sudo chown -R $USER:$USER /opt/spotify/Apps 2>/dev/null || true

echo "==> Applying spicetify..."
spicetify apply

echo "✅ Spotify + Spicetify installation completed."
