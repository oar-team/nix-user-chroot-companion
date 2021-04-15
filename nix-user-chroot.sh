#!/bin/bash

version="1.2.1"
nix_user_chroot_url="https://github.com/nix-community/nix-user-chroot/releases/download/$version/nix-user-chroot-bin-$version-x86_64-unknown-linux-musl"
nix_user_chroot="nix_user_chroot_$version"
nix_user_chroot_dir="$HOME/.nix_user_chroot"
nix_user_chroot_cmd="$nix_user_chroot_dir/$nix_user_chroot"

userns=$(/sbin/sysctl -n kernel.unprivileged_userns_clone)

if [ "$userns" == "0" ]; then
    echo "Need user namespace feature, you can enable it with the following command:"
    echo "sudo sysctl -w kernel.unprivileged_userns_clone=1"
    exit 1
fi
    
if [ ! -f $nix_user_chroot_cmd ]; then
    echo "Install nix-user-root command"
    mkdir -p $nix_user_chroot_dir
    curl -L $nix_user_chroot_url --output $nix_user_chroot_cmd
    chmod 755 $nix_user_chroot_cmd
    echo "export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive" > $nix_user_chroot_dir/nix_setenv.sh
    echo "source $HOME/.nix-profile/etc/profile.d/nix.sh" >> $nix_user_chroot_dir/nix_setenv.sh
fi

nix_store_dir="$HOME/.nix"
if [ ! -d $nix_store_dir ]; then
    echo "Install Nix"
    mkdir -m 0755 "$HOME/.nix"
    install_nix="$nix_user_chroot_cmd $nix_store_dir bash -c 'curl -L https://nixos.org/nix/install | bash'"
    eval $install_nix
    
fi

clear
echo "Activate Nix"
nix_user_chroot_bash="$nix_user_chroot_cmd $nix_store_dir bash --rcfile $nix_user_chroot_dir/nix_setenv.sh"
eval $nix_user_chroot_bash
