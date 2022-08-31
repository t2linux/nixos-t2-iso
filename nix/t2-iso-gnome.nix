{ pkgs, lib, nixos-hardware, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
  ];

  # Audio works better with PipeWire
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # ZFS is broken and prevents building without this
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    vim 
  ];
}
