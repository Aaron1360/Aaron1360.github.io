# flake.nix
{
  description = "A reproducible Nix Flake environment for Jekyll development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        shell = import ./shell.nix { inherit pkgs; };
      in {
        devShells.default = shell;
      }
    );
}
