{ lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    ./common.nix
  ];

  # Audio works better with PipeWire
  services.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
}
