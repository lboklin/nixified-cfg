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
      .overrideAttrs (old: old // { dependencies = deps nodes; });

in drv {
  # https://github.com/Fannovel16/comfyui_controlnet_aux
  # Nodes for providing ControlNet hint images.
  controlnet-aux = mkComfyUICustomNodes {
    pname = "comfyui-controlnet-aux";
    version = "unstable-2024-04-05";
    pyproject = true;
    passthru.dependencies = with pkgs.python3Packages; [
      matplotlib
      opencv4
      scikit-image
    ];
    src = fetchFromGitHub {
      owner = "Fannovel16";
      repo = "comfyui_controlnet_aux";
      rev = "c0b33402d9cfdc01c4e0984c26e5aadfae948e05";
      hash = "sha256-D9nzyE+lr6EJ+9Egabu+th++g9ZR05wTg0KSRUBaAZE=";
      fetchSubmodules = true;
    };
  };

  # https://github.com/Acly/comfyui-inpaint-nodes
  # Provides nodes for doing better inpainting.
  inpaint-nodes = mkComfyUICustomNodes {
    pname = "comfyui-inpaint-nodes";
    version = "unstable-2024-04-08";
    pyproject = true;
    src = fetchFromGitHub {
      owner = "Acly";
      repo = "comfyui-inpaint-nodes";
      rev = "8469f5531116475abb6d7e9c04720d0a29485a66";
      hash = "sha256-Ane8zA9BN9QlRcQOwji4hZF2xoDPe/GvSqEyAPR+T28=";
      fetchSubmodules = true;
    };
  };

  # https://github.com/cubiq/ComfyUI_IPAdapter_plus
  # This allows use of IP-Adapter models (IP meaning Image Prompt in this
  # context).  IP-Adapter models can out-perform fine tuned models
  # (checkpoints?).
  ipadapter-plus = mkComfyUICustomNodes {
    pname = "comfyui-ipadapter-plus";
    version = "unstable-2024-04-10";
    pyproject = true;
    src = fetchFromGitHub {
      owner = "cubiq";
      repo = "ComfyUI_IPAdapter_plus";
      rev = "417d806e7a2153c98613e86407c1941b2b348e88";
      hash = "sha256-yuZWc2PsgMRCFSLTqniZDqZxevNt2/na7agKm7Xhy7Y=";
      fetchSubmodules = true;
    };
  };

  # https://github.com/Acly/comfyui-tooling-nodes
  # Make ComfyUI more friendly towards API usage.
  tooling-nodes = mkComfyUICustomNodes {
    pname = "comfyui-tooling-nodes";
    version = "unstable-2024-03-04";
    pyproject = true;
    src = fetchFromGitHub {
      owner = "Acly";
      repo = "comfyui-tooling-nodes";
      rev = "bcb591c7b998e13f12e2d47ee08cf8af8f791e50";
      hash = "sha256-dXeDABzu0bhMDN/ryHac78oTyEBCmM/rxCIPfr99ol0=";
      fetchSubmodules = true;
    };
  };

  # Handle upscaling of smaller images into larger ones.  This is helpful to go
  # from a prototyped image to a highly detailed, high resolution version.
  ultimate-sd-upscale = mkComfyUICustomNodes {
    pname = "ultimate-sd-upscale";
    version = "unstable-2024-03-30";
    src = fetchFromGitHub {
      owner = "ssitu";
      repo = "ComfyUI_UltimateSDUpscale";
      rev = "b303386bd363df16ad6706a13b3b47a1c2a1ea49";
      hash = "sha256-kcvhafXzwZ817y+8LKzOkGR3Y3QBB7Nupefya6s/HF4=";
      fetchSubmodules = true;
    };
  };
}
