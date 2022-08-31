## NixOS Iso for T2 Macs

You can use this flake to build a NixOS iso that can be used with T2 Macs.

This repo provides two isos:
* `t2-iso-minimal`
* `t2-iso-gnome`

It is recommended to use `t2-iso-minimal` for installing NixOS. `t2-iso-gnome` can be used to preview what the system will look like after the installation.

You can build with this command:
```
nix build .#t2-iso-minimal
```

You need to have `nix` installed on a **Linux** host. If you are on macOS, you can use `podman` or `docker` with the `nixos/nix` image.

Prebuilt isos are also available in the [releases page](https://github.com/kekrby/nixos-t2-iso/releases).

As iso files can be quite large depending on their content, they are split into multiple parts. You can join them with this command after downloading all the files for the variant you want:
```
cat t2-iso-<variant>.iso-part-* > t2-iso-<variant>.iso
```
