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

key_path="$installdir/git/madgraph4gpu"
installdir="$installdir/git"
cd "$installdir"

echo "Installation directory set to: $installdir"

if [[ ! -f "$key_path" ]]; then
    echo "==> Cloning mg5 repo"
    git clone git@github.com:madgraph5/madgraph4gpu.git --recurse-submodules
    
    cd "$key_path/MG5aMC/mg5amcnlo/"
    git submodule update --init --recursive

    cd "PLUGIN"
    ln -s "$key_path/epochX/cudacpp/CODEGEN/PLUGIN"
    echo
else
    echo "==> Repo already exists at $key_path"
fi

cd "$CUR_DIR"



