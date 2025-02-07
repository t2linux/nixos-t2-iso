{
  description = "A flake for building NixOS installers that work on T2 Macs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  nixConfig = {
    extra-trusted-substituters = [ "https://cache.soopy.moe" ];
    extra-substituters = [ "https://cache.soopy.moe" ];
    extra-trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
    }:
    let
      inherit (nixpkgs) lib;

      system = "x86_64-linux";
      isos = [
        "gnome"
        "minimal"
      ];
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      packages.${system} = lib.genAttrs isos (
        iso:
        (lib.nixosSystem {
          modules = [ (self + "/nix/t2-iso-${iso}.nix") ];
          specialArgs = { inherit nixos-hardware; };
        }).config.system.build.isoImage
      );
    };
}
