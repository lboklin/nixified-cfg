{ inputs', ... }: {
  perSystem = { pkgs, comfyuiModels, lib, ... }: let
    # this packages a model, but does not concern itself with directory structure:
    # placing it where it needs to go is left to whomever or whatever makes use of it
    drv = name: fetched: with lib; let
      join = with strings; (sep: (xs: concatStrings (intersperse sep xs)));
      join-lines = join "\n";
      fetched-to-symlink = name: fetched: let inherit (trivial) throwIfNot; in
        throwIfNot (isString name) "name must be a string."
        throwIfNot (isAttrs fetched) "fetched must be an attrset."
        throwIfNot (isString fetched.format) "fetched.format must be a string."
        throwIfNot (isString fetched.path) "fetched.path must be a string."
          ''
           ln -snf ${fetched.path} $out/${name}.${fetched.format}
          '';
    in pkgs.stdenv.mkDerivation {
      inherit name;
      pname = name;
      sourceRoot = name;
      installPhase = ''
        mkdir -p $out
      '' + (fetched-to-symlink name fetched);
      phases = [ "installPhase" ];
    };
  in {
    packages = with lib; pipe comfyuiModels [
      (mapAttrsToList (type:
        mapAttrsToList (name: fetched: {
          name = "comfyui-${type}-${name}";
          value = drv name fetched;
        })))
      (lists.flatten)
      (builtins.listToAttrs)
    ];

    checks = {
      # fetch a 2KB yaml file to check that it works.
      # nix build .#checks.<system>.comfyui-model-test => ./result/controlnet-v1_1_fe-sd15-tile.yaml
      # and it's the same result as building the package with
      # nix build .#comfyui-configs-controlnet-v1_1_fe-sd15-tile
      comfyui-model-test = drv "controlnet-v1_1_fe-sd15-tile" comfyuiModels.configs.controlnet-v1_1_fe-sd15-tile;
    };
  };
}
