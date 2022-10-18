{ pkgs, nixos-hardware, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
    ./common.nix
  ];

  # ZFS is broken and prevents building without this
  nixpkgs.config.allowBroken = true;
}
