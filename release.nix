let
  pkgs = import <nixpkgs> { };

in
  { scratch = pkgs.haskellPackages.callPackage ./scratch.nix { };
  }
