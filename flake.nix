{
  description = "A flake for building NixOS installers that work on T2 Macs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
    }:
    let
      system = "x86_64-linux";
      inherit (nixpkgs) lib;

      mergeMap = fn: list: lib.lists.foldr (a: b: a // b) { } (map fn list);
      attributes =
        mergeMap
          (config: {
            ${lib.strings.removeSuffix ".nix" (builtins.baseNameOf config)} =
              (lib.nixosSystem {
                inherit system;

                modules = [ config ];

                specialArgs = {
                  inherit nixos-hardware;
                };
              }).config.system.build.isoImage;
          })
          (
            builtins.filter (x: x != null) (
              lib.attrsets.mapAttrsToList (
                key: value: if value == "regular" && lib.strings.hasInfix "iso" key then ./nix/${key} else null
              ) (builtins.readDir ./nix)
            )
          );
    in
    attributes
    // {
      hydraJobs = attributes;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
