# nix-user-chroot.sh

nix-user-chroot.sh is a simple companion script to [nix-user-chroot](https://github.com/nix-community/nix-user-chroot/) tool. It gathers in one command the following steps: installing nix-user-chroot, initializing nix store and activating nix. Only activation is performed in subsequent calls.

During the first execution, the script executes roughly the next commands:
```console
$ curl -L https://github.com/nix-community/nix-user-chroot/releases/download/1.0.3/nix-user-chroot-bin-1.0.3-x86_64-unknown-linux-musl --output nix-user-chroot
$ mkdir -m 0755 ~/.nix
$ nix-user-chroot ~/.nix bash -c "curl -L https://nixos.org/nix/install | bash"
$ nix-user-chroot ~/.nix bash --rcfile "$HOME/.nix-profile/etc/profile.d/nix.sh"
```

## Installation
Just grab the nix-user-chroot.sh and set it as executable:
```console
$ curl -L -O https://raw.githubusercontent.com/oar-team/nix-user-chroot-companion/master/nix-user-chroot.sh
$ chmod 755 nix-user-chroot.sh
```

## Use
```console
$ ./nix-user-chroot.sh
```
