{
  description = "A flake for NixOS iso's that work on T2 Macs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:kekrby/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware }:
  let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;

    mergeMap = fn: list: lib.lists.foldr (a: b: a // b) {} (map fn list);
  in
  mergeMap (config: {
    ${lib.strings.removeSuffix ".nix" (builtins.baseNameOf config)} = (lib.nixosSystem {
      inherit system;

      modules = [ config ];

      specialArgs = {
        inherit nixos-hardware;
      };
    }).config.system.build.isoImage; 
  }) (builtins.filter (x: x != null) (lib.attrsets.mapAttrsToList (key: value: if value == "regular" then ./nix/${key} else null) (builtins.readDir ./nix)));
}
