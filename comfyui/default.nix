{ ... }: {
  flake = {
    lib.comfyui.models = pkgs:
      import ./models { inherit (pkgs) lib fetchurl stdenv; };
    cfg.comfyui = pkgs: let
      basePath = "/var/lib/comfyui";
    in {
      modelsPath = "${basePath}/models";
      inputPath = "${basePath}/input";
      outputPath = "${basePath}/test-output";
      tempPath = "${basePath}/temp";
      userPath = "${basePath}/user";
      customNodes = [];
      models = {
        checkpoints = {};
        clip = {};
        clip_vision = {};
        configs = {};
        controlnet = {};
        embeddings = {};
        upscale_models = {};
        vae = {};
        vae_approx = {};
      };
    };
  };
  imports = [
    ./packages.nix
  ];
}
