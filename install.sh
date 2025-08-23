#!/usr/bin/env bash
set -euo pipefail


# Detecting package manager
if command -v pacman >/dev/null; then
    echo "[*] Arch Linux detected"
    sudo pacman -Syu --needed - < packages-arch.txt
elif command -v apt >/dev/null; then
    echo "[*] Debian/Ubuntu detected"
    sudo apt update
    xargs -a packages-deb.txt sudo apt install -y
else
    echo "[!] Unsupported distro. Please install dependencies manually."
    exit 1
fi

# Make zsh default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "[*] Setting zsh as default shell..."
    chsh -s "$(command -v zsh)"
fi

# Install oh-my-zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[*] Installing oh-my-zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install or Update Powerlevel10k if missing
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "[*] Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
    echo "[*] Updating Powerlevel10k..."
    git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" pull --ff-only
fi

# Install or Update fzf-tab plugin if missing
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab" ]; then
    echo "[*] Installing fzf-tab plugin..."
    git clone https://github.com/Aloxaf/fzf-tab \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"
else
    echo "[*] Updating fzf-tab plugin..."
    git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab" pull --ff-only
fi

# Install or Update zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "[*] Updating zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
else
    echo "[*] Updating zsh-autosuggestions plugin..."
    git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" pull --ff-only
fi

# Install or Update zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "[*] Updating zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
else
    echo "[*] Updating zsh-syntax-highlighting plugin..."
    git -C "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" pull --ff-only
fi

# Deploy Folders (symlink)
FOLDERS_DIR="$(cd "$(dirname "$0")"/folders && pwd)"

echo "[*] Installing folders..."
mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/functions"
ln -snf "$FOLDERS_DIR/functions" "$HOME/.config/functions"
find "$FOLDERS_DIR/functions" -type f -name "*.sh" -exec chmod u+x {} \;

# Deploy dotfiles (symlink)
DOTFILES_DIR="$(cd "$(dirname "$0")"/dotfiles && pwd)"

echo "[*] Installing configs..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Setup Catppuccin for bat
if command -v bat >/dev/null || command -v batcat >/dev/null; then
    echo "[*] Setting up Catppuccin for bat..."
    mkdir -p ~/.config/bat/themes
    rm -rf /tmp/catppuccin-bat
    git clone --depth=1 https://github.com/catppuccin/bat.git /tmp/catppuccin-bat
    cp /tmp/catppuccin-bat/themes/* ~/.config/bat/themes/
    if command -v bat >/dev/null; then
        bat cache --build
    elif command -v batcat >/dev/null; then
        batcat cache --build
    fi
fi

# Setup tmux plugin manager (TPM)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "[*] Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else 
    echo "[*] Updating TPM..."
    git -C ~/.tmux/plugins/tpm pull --ff-only
fi

# Install tmux plugins automatically
echo "[*] Installing TPM plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo
echo "[*] Done! Restart your terminal or log out/in."