{ pkgs, ... }:

{
  nix = {
    binaryCaches = [
      "https://t2linux.cachix.org"
    ];
    binaryCachePublicKeys = [
      "t2linux.cachix.org-1:P733c5Gt1qTcxsm+Bae0renWnT8OLs0u9+yfaK2Bejw="
    ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
