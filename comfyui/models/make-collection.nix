{ lib
, stdenv
}:

## adapted from https://github.com/LoganBarnett/dotfiles/blob/eed1ad6c03283967320fb8bc04ed7b233b164f3b/nix/hacks/comfyui-services-web-apps/comfyui.nix#L281
let
  inherit (builtins) mapAttrs;
  inherit (lib) isAttrs isString;
  inherit (lib.attrsets) attrValues mapAttrsToList;
  inherit (lib.lists) all flatten;
  inherit (lib.strings) concatStrings intersperse;
  inherit (lib.trivial) throwIfNot;
  join = (sep: (xs: concatStrings (intersperse sep xs)));
  join-lines = join "\n";
  # We don't have a type system and this is pretty deep in the call stack,
  # so do some checking on the inputs so we have fewer stones to overturn
  # when something goes wrong later.
  throw-if-not-fetched = fetched:
    throwIfNot (isAttrs fetched) "fetched must be an attrset."
    throwIfNot (isString fetched.format) "fetched.format must be a string."
    throwIfNot (isString fetched.path) "fetched.path must be a string."
  ;
  fetched-to-symlink = path: name: fetched: (
    throwIfNot (isString path) "path must be a string."
    throwIfNot (isString name) "name must be a string."
    throw-if-not-fetched fetched
      ''
       ln -snf ${fetched.path} $out/${name}.${fetched.format}
      ''
  );

  linkModels = modelPaths: models:
    throwIfNot (isAttrs modelPaths) "modelPaths must be an attrset."
    (throwIfNot (lib.lists.all lib.id (mapAttrsToList (_: v: isString v) modelPaths)) "modelPaths must be an attrset of strings."
    (throwIfNot (isAttrs models) "models must be an attrset."
    (let
      # a typed derivation producing symlinks to models of a common type
      # fetched-by-name is an attrset of fetched models
      modelsDrvOfType = type: fetched-by-name: {
        model-type = type;
        drv = let
          name = "comfyui-models-${type}";
          paths = mapAttrsToList (fetched-to-symlink modelPaths."${type}") fetched-by-name;
        in stdenv.mkDerivation {
          inherit name;
          pname = name;
          sourceRoot = name;
          installPhase = ''
            mkdir -p $out
          '' + (join-lines paths);
          phases = [ "installPhase" ];
        };
      };
    in join-lines
      (builtins.map
        (x: ''
          subdir=${modelPaths."${x.model-type}"}
          # `ln -s` will link *into* the subdir if it already exists, even with -f
          mkdir -p ''${subdir%${x.model-type}}
          ln -snf ${x.drv} $subdir
        '')
        (flatten (mapAttrsToList modelsDrvOfType models))
      )
    )));
in models: throwIfNot (isAttrs models) "models must be an attrset" (let
    name = "comfyui-models";
    modelPaths = mapAttrs (type: _: "$out/${type}") models;
  in stdenv.mkDerivation {
    inherit name;
    pname = name;
    sourceRoot = name;
    installPhase = ''
      mkdir -p $out
    '' + linkModels modelPaths models;
    phases = [ "installPhase" ];

    meta.description = "Collection of models. Note that this goes into base_path/models/";
  })

