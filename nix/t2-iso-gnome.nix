{ pkgs, lib, nixos-hardware, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
    ./common.nix
  ];

  # Audio works better with PipeWire
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
}
