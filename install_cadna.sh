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

key_path="$installdir/git/cadnac"
installdir="$installdir/git"
cd "$installdir"

set -e

current_ver=$(autoconf --version | head -n1 | awk '{print $NF}')
required_ver="2.71"

version_ge() { 
    [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ] 
}

if command -v autoconf >/dev/null 2>&1 && version_ge "$current_ver" "$required_ver"; then
    echo "Autoconf $current_ver is already >= $required_ver. Nothing to do."
else
    sudo dnf install -y gcc make m4 wget tar
    
    tmpdir=$(mktemp -d)
    cd "$tmpdir"
    wget https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz
    tar xf autoconf-2.71.tar.gz
    cd autoconf-2.71
    ./configure --prefix=/usr/local
    make -j"$(nproc)"
    sudo make install
fi

# Verify installation
installed_ver=$(autoconf --version | head -n1 | awk '{print $NF}')
echo "Autoconf $installed_ver installed successfully."

echo "Installation directory set to: $installdir"

if [[ ! -f "$key_path" ]]; then
    echo "==> Cloning cadna repo"
    #git clone https://gitlab.lip6.fr/pequan/cadna/cadnac
    cd "$key_path"
    git switch -f cadnac_half_fma
    
    cd sources_generateur
    make
    
    cd ..
    aclocal && autoheader && autoconf && automake -a -c
    
    # Correct --prefix
    ./configure --prefix="$(pwd)" CC=gcc CXX=g++ --enable-half-emulation
    make install
    
    cd examplesC
    make
    ./ex1_cad
    
    cd ../examples_half
    make
    ./ex1_cad

    echo "export CADNA_PATH=$(key_path)" >> ~/.bashrc  
    echo
else
    echo "==> Repo already exists at $key_path"
fi

cd "$CUR_DIR"



