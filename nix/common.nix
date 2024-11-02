{
  pkgs,
  modulesPath,
  nixos-hardware,
  ...
}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/channel.nix"
    nixos-hardware.nixosModules.apple-t2
  ];

  nix.settings = {
    trusted-substituters = [ "https://t2linux.cachix.org" ];
    trusted-public-keys = [ "t2linux.cachix.org-1:P733c5Gt1qTcxsm+Bae0renWnT8OLs0u9+yfaK2Bejw=" ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    python3
    dmg2img
    (pkgs.callPackage ./pkgs/firmware-script.nix { })
  ];

  # ZFS is (sometimes) broken and prevents building without this
  nixpkgs.config.allowBroken = true;
}
