## In here is where you add your custom nodes. Some examples are included.
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

in drv {
  # # https://github.com/Fannovel16/comfyui_controlnet_aux
  # # Nodes for providing ControlNet hint images.
  # controlnet-aux = mkComfyUICustomNodes {
  #   pname = "comfyui-controlnet-aux";
  #   version = "unstable-2024-04-05";
  #   pyproject = true;
  #   dependencies = with pkgs.python3Packages; [
  #     matplotlib
  #     opencv4
  #     scikit-image
  #   ];
  #   src = fetchFromGitHub {
  #     owner = "Fannovel16";
  #     repo = "comfyui_controlnet_aux";
  #     rev = "c0b33402d9cfdc01c4e0984c26e5aadfae948e05";
  #     hash = "sha256-D9nzyE+lr6EJ+9Egabu+th++g9ZR05wTg0KSRUBaAZE=";
  #     fetchSubmodules = true;
  #   };
  # };

  # # Handle upscaling of smaller images into larger ones.  This is helpful to go
  # # from a prototyped image to a highly detailed, high resolution version.
  # ultimate-sd-upscale = mkComfyUICustomNodes {
  #   pname = "ultimate-sd-upscale";
  #   version = "unstable-2024-03-30";
  #   src = fetchFromGitHub {
  #     owner = "ssitu";
  #     repo = "ComfyUI_UltimateSDUpscale";
  #     rev = "b303386bd363df16ad6706a13b3b47a1c2a1ea49";
  #     hash = "sha256-kcvhafXzwZ817y+8LKzOkGR3Y3QBB7Nupefya6s/HF4=";
  #     fetchSubmodules = true;
  #   };
  # };
}
