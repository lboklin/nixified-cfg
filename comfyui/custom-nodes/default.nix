## In here is where you add your custom nodes.
## FIXME: dependencies don't work.
{ lib
, pkgs
}@args:

let
  inherit (pkgs) fetchFromGitHub stdenv;
  # Patches don't apply to $src, and as with many scripting languages that don't
  # have a build output per se, we just want the script source itself placed
  # into $out.  So just copy everything into $out instead of from $src so we can
  # make sure we get everything in the future, and we use the patched versions.
  install = ''
  shopt -s dotglob
  shopt -s extglob
  cp -r ./!($out|$src) $out/
'';
  mkComfyUICustomNodes = args: pkgs.stdenv.mkDerivation ({
    installPhase = ''
      runHook preInstall
      mkdir -p $out/
      ${install}
      runHook postInstall
    '';

    passthru.dependencies = [];
  } // args);
  deps = nodes: with builtins; lib.pipe nodes [
    attrValues
    (map (v: v.dependencies))
    concatLists
  ];
  drv = nodes:
    (pkgs.linkFarm "comfyui-custom-nodes" nodes)
      # can't do it this way
      .overrideAttrs (old: old // { dependencies = deps nodes; });

in drv {}
