{ lib
, fetchurl
, linkFarm
, collection ? (import ./collection.nix)
}:

let
  fetchModel = import ./fetch-model.nix { inherit lib fetchurl; };
  inherit (lib.attrsets) concatMapAttrs;
  concatMapModels = f: concatMapAttrs (type: concatMapAttrs (f type));
  collect = concatMapModels (type: name: model: let
    fetched = fetchModel model;
  in { "${type}/${name}.${fetched.format}" = fetched.path; });
in linkFarm "comfyui-models" (collect collection)
