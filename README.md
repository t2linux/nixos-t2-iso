## NixOS Installers for T2 Macs

This flake can be used to build a NixOS installer that can be used with T2 Macs.

This repo provides two ISOs:
* `t2-iso-minimal`
* `t2-iso-gnome`

It is recommended to use `t2-iso-minimal` for installing NixOS. `t2-iso-gnome` can be used to preview what the system will look like after the installation.

Prebuilt installers are available in the [releases page](https://github.com/t2linux/nixos-t2-iso/releases).

As ISO files can be quite large depending on their content, they are split into multiple parts. You can join them with this command after downloading all the files for the variant you want:
```
cat t2-iso-<variant>.iso-part-* > t2-iso-<variant>.iso
```

## Building

You can build with this command:
```
nix build .#packages.x86_64-linux.t2-iso-minimal
```

The build has to be done in Linux. If you are on macOS, you should do the build in a Linux VM.
