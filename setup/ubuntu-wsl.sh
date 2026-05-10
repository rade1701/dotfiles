#!/usr/bin/env bash
set -e
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

echo "═══════════════════════════════════════════"
echo "  Athenyx — Ubuntu WSL Full Stack Install"
echo "═══════════════════════════════════════════"

# ── System ──────────────────────────────────────────────────────────
echo "→ Updating system..."
sudo apt update && sudo apt upgrade -y

# ── Base packages ───────────────────────────────────────────────────
echo "→ Installing base packages..."
sudo apt install -y \
  git curl wget unzip \
  fish tmux neovim \
  sway waybar rofi mako-notifier \
  alacritty grim \
  fonts-jetbrains-mono fonts-noto-color-emoji \
  wl-clipboard \
  htop btop ripgrep fd-find bat \
  python3 python3-pip \
  libfuse2

# ── Node.js (LTS) ───────────────────────────────────────────────────
echo "→ Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# ── Brave ───────────────────────────────────────────────────────────
echo "→ Installing Brave..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser

# ── Bitwarden CLI ───────────────────────────────────────────────────
# GUI: install as Brave browser extension (no ARM64 Linux AppImage available)
# https://chromewebstore.google.com/detail/bitwarden/nngceckbapebfimnlniiiahkandclblb
echo "→ Installing Bitwarden CLI..."
sudo npm install -g @bitwarden/cli

# ── Claude Desktop ──────────────────────────────────────────────────
echo "→ Installing Claude Desktop (unofficial Linux port)..."
curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop.gpg
echo "deb [signed-by=/usr/share/keyrings/claude-desktop.gpg arch=amd64,arm64] \
  https://pkg.claude-desktop-debian.dev stable main" \
  | sudo tee /etc/apt/sources.list.d/claude-desktop.list
sudo apt update && sudo apt install -y claude-desktop

# ── Claude Code CLI ─────────────────────────────────────────────────
echo "→ Installing Claude Code CLI..."
sudo npm install -g @anthropic-ai/claude-code

# ── OpenAI CLI ──────────────────────────────────────────────────────
echo "→ Installing OpenAI CLI..."
pip3 install --user openai --break-system-packages

# ── Link configs ────────────────────────────────────────────────────
echo "→ Linking configs..."
mkdir -p "$HOME/.config/sway"
ln -sf "$DOTFILES/sway/config"         "$HOME/.config/sway/config"

mkdir -p "$HOME/.config/waybar"
ln -sf "$DOTFILES/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
ln -sf "$DOTFILES/waybar/style.css"    "$HOME/.config/waybar/style.css"

mkdir -p "$HOME/.config/mako"
ln -sf "$DOTFILES/mako/config"         "$HOME/.config/mako/config"

mkdir -p "$HOME/.config/fish"
ln -sf "$DOTFILES/fish/config.fish"    "$HOME/.config/fish/config.fish"

sudo cp "$DOTFILES/wsl/wsl.conf" /etc/wsl.conf

# ── Fish as default shell ────────────────────────────────────────────
echo "→ Setting fish as default shell..."
sudo chsh -s "$(which fish)" "$USER"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║         Install complete ✓           ║"
echo "╠══════════════════════════════════════╣"
echo "║  sway          → run: sway           ║"
echo "║  brave         → run: brave          ║"
echo "║  bitwarden     → run: bitwarden      ║"
echo "║  bw (CLI)      → run: bw --help      ║"
echo "║  claude        → run: claude         ║"
echo "║  claude-desktop→ run: claude-desktop ║"
echo "║  openai        → run: openai --help  ║"
echo "╚══════════════════════════════════════╝"
