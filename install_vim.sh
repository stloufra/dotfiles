#!/usr/bin/env bash
set -euo pipefail

VIM_VERSION="v9.1.0"
PREFIX="$HOME/opt/vim"
SRC_DIR="$HOME/src/vim"

echo "==> Installing Vim $VIM_VERSION into $PREFIX"

# ---------- sanity checks ----------
command -v gcc >/dev/null || { echo "gcc not found"; exit 1; }
command -v make >/dev/null || { echo "make not found"; exit 1; }
command -v python3 >/dev/null || { echo "python3 not found"; exit 1; }

# ---------- fetch source ----------
if [[ ! -d "$SRC_DIR" ]]; then
  echo "==> Cloning Vim repository"
  git clone https://github.com/vim/vim.git "$SRC_DIR"
fi

cd "$SRC_DIR"
git fetch --tags
git checkout "$VIM_VERSION"

# ---------- detect GTK ----------
GUI_FLAG="--enable-gui=no"
if pkg-config --exists gtk+-3.0 2>/dev/null; then
  echo "==> GTK3 detected, enabling GUI"
  GUI_FLAG="--enable-gui=gtk3"
else
  echo "==> GTK3 not found, building terminal Vim"
fi

# ---------- configure ----------
echo "==> Configuring"
./configure \
  --prefix="$PREFIX" \
  --with-features=huge \
  --enable-multibyte \
  --enable-terminal \
  --enable-cscope \
  --enable-python3interp=yes \
  --with-python3-command=python3 \
  $GUI_FLAG \
  --enable-fail-if-missing

# ---------- build ----------
echo "==> Building"
make -j"$(nproc)"

# ---------- install ----------
echo "==> Installing"
make install

# ---------- activate ----------
if ! grep -q 'opt/vim/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/opt/vim/bin:$PATH"' >> "$HOME/.bashrc"
fi

# ---------- verification ----------
echo
echo "==> Installation complete"
"$PREFIX/bin/vim" --version | head -n 2

