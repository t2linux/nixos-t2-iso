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
    trusted-substituters = [
      "https://t2linux.cachix.org"
    ];
    trusted-public-keys = [
      "t2linux.cachix.org-1:P733c5Gt1qTcxsm+Bae0renWnT8OLs0u9+yfaK2Bejw="
    ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    python3
    dmg2img
    (callPackage ./pkgs/firmware-script.nix { })
  ];

  # Don't actually let broken stuff sneak into the ISO. If ZFS breaks, it actually breaks building the kernel (module)
  # due to an upstream check and this wouldn't do anything to stop that from happening.
  ## ZFS is (sometimes) broken and prevents building without this
  ## nixpkgs.config.allowBroken = true;

  nixpkgs.hostPlatform = "x86_64-linux"; # t2 is x86_64-linux only
}
