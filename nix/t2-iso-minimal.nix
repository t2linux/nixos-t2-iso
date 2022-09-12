{ pkgs, nixos-hardware, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
  ];

  # ZFS is broken and prevents building without this
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    vim 
  ];
}
