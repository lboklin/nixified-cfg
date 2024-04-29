{ stdenv
, lib
, fetchurl
}:

let
  fetchModel = import ./fetch-model.nix { inherit lib fetchurl; };
  collection = builtins.mapAttrs (_: builtins.mapAttrs (_: fetchModel)) (import ./collection.nix);
  mkCollection = import ./make-collection.nix { inherit lib stdenv; };
in mkCollection collection
