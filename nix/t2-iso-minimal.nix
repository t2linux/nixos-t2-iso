{ pkgs, nixos-hardware, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
  ];

  # ZFS is broken and prevents building without this
  nixpkgs.config.allowBroken = true;

  # iwd is preferred because wpa_supplicant does not work well (though wpa_cli seems to work fine for some reason)
  # wpa_supplicant is enabled by a module imported by the installation CD module so it is turned off so that it does not conflict with iwd
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;

  environment.systemPackages = with pkgs; [
    vim 
  ];
}
