# nix-user-chroot.sh

nix-user-chroot.sh is simple companion script of [nix-user-chroot](https://github.com/nix-community/nix-user-chroot/) tool. It gathers in one command the following steps: installation of nix-user-chroot, initialisation of nix store and nix activation. Only activation is performed in subsquent calls.

The first execution, the script executes roughly the next commands:
```console
$ curl -L https://github.com/nix-community/nix-user-chroot/releases/download/1.0.3/nix-user-chroot-bin-1.0.3-x86_64-unknown-linux-musl --output nix-user-chroot
$ mkdir -m 0755 ~/.nix
$ nix-user-chroot ~/.nix bash -c "curl -L https://nixos.org/nix/install | bash"
$ nix-user-chroot ~/.nix bash --rcfile "$HOME/.nix-profile/etc/profile.d/nix.sh"
```

## Installation
Just grab the nix-user-chroot.sh and set it as executable
```console
$ curl -L -O https://raw.githubusercontent.com/oar-team/nix-user-chroot-companion/master/nix-user-chroot.sh
$ chmod 755 nix-user-chroot.sh
```

## Use
```console
$ ./nix-user-chroot.sh
```
