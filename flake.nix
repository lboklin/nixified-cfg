{
  description = "Minimal configuration satisfying all basic requirements of the Krita AI plugin";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = { system, pkgs, lib, ... }: let
        pkgs = import inputs.nixpkgs { inherit system; };
      in {
        _module.args = {
          inherit pkgs;
        };
      };
      systems = [ "x86_64-linux" ];


      imports = [
        ./comfyui
      ];
    };
}
