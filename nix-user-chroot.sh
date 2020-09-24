#!/bin/bash

version="1.0.3"
nix_user_root_url="https://github.com/nix-community/nix-user-chroot/releases/download/$version/nix-user-chroot-bin-$version-x86_64-unknown-linux-musl"
nix_user_root="nix_user_root_$version"
nix_user_root_dir="$HOME/.nix_user_root"
nix_user_root_cmd="$nix_user_root_dir/$nix_user_root"

userns=$(/sbin/sysctl -n kernel.unprivileged_userns_clone)

if [ "$userns" == "0" ]; then
    echo "Need user namespace feature, execute following:"
    echo "sudo sysctl -w kernel.unprivileged_userns_clone=1"
    exit 1
fi
    
if [ ! -f $nix_user_root_cmd ]; then
    echo "Install nix-user-root command"
    mkdir -p $nix_user_root_dir
    curl -L $nix_user_root_url --output $nix_user_root_cmd
    chmod 755 $nix_user_root_cmd
    mkdir -p -m 0755 "$HOME/.nix"
fi

nix_store_dir="$HOME/.nix"
if [ ! -d $nix_store_dir ]; then
    echo "Install Nix"
    mkdir -m 0755 "$HOME/.nix"
    install_nix="$nix_user_root_cmd $nix_store_dir bash -c 'curl -L https://nixos.org/nix/install | bash'"
    eval $install_nix
fi

echo "Activate Nix"
nix_user_root_bash="$nix_user_root_cmd $nix_store_dir bash --rcfile '$HOME/.nix-profile/etc/profile.d/nix.sh'"
eval $nix_user_root_bash
