fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/uv/bin

set -x EDITOR nvim
set -x ELECTRON_OZONE_PLATFORM_HINT wayland
set -x XDG_SESSION_TYPE wayland
set -x XDG_CURRENT_DESKTOP sway

# ── App aliases ────────────────────────────────────────────────────
alias ll    "ls -lah --color=auto"
alias v     "nvim"
alias t     "tmux"
alias brave "brave-browser --ozone-platform=wayland"
alias claude-desktop "claude-desktop --disable-gpu --ozone-platform=wayland"
alias bw    "bw"

# ── Homelab SSH ────────────────────────────────────────────────────
alias m2    "ssh rade@192.168.3.29"
alias intel "ssh rade@192.168.3.12"
alias nas   "ssh rade@192.168.3.67"
alias ha    "ssh rade@192.168.3.40"

# ── Git ────────────────────────────────────────────────────────────
alias gs    "git status"
alias ga    "git add -A"
alias gc    "git commit -m"
alias gp    "git push"
alias gpl   "git pull"

# ── Claude ────────────────────────────────────────────────────────
alias cc    "claude"

function fish_greeting
    echo "⚡ Athenyx WSL — $(date '+%A, %d %b %H:%M')"
    echo "   claude · brave · bitwarden · sway"
end
