#! /bin/bash


CUR_DIR=$(pwd)

shared="/shared"

echo "Where do you want to install? (home/shared)"
read -rp "Enter 'home' or 'shared': " choice

case "$choice" in
    home|HOME)
        installdir="$HOME"
        ;;
    shared|SHARED)
        installdir="$shared"
        ;;
    *)
        echo "Invalid choice. Defaulting to home."
        installdir="$HOME"
        ;;
esac

mkdir -p "$installdir/git"
chmod 700 "$installdir/git"

key_path="$installdir/git/promise"
installdir="$installdir/git"
cd "$installdir"

echo "Installation directory set to: $installdir"

if [[ ! -f "$key_path" ]]; then

    echo "==> Cloning promise repo"
    git clone https://gitlab.lip6.fr/pequan/promise
    cd "$key_path"
    python3 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install .
    python3 -m pip install pytest
    init-promise
    cd examples
    pytest
    echo
else
    echo "==> Repo already exists at $key_path"
fi

cd "$CUR_DIR"



