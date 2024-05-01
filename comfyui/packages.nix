{ ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages = {
      comfyui-models = pkgs.callPackage ./models {};
      comfyui-custom-nodes = pkgs.callPackage ./custom-nodes {};
    };

    checks = {
      # TODO: add some more (lightweight) stuff to the model set
      comfyui-model-collection = let
        yaml-file = {
          format = "yaml";
          url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11f1e_sd15_tile.yaml";
          sha256 = "sha256-OeEzjEFDYYrbF2BPlsOj90DBq10VV9cbBE8DB6CmrbQ=";
        };
        # fetch some small files
        # TODO: add more
        collection = { configs = { controlnet-v1_1_fe-sd15-tile = yaml-file; }; };
      in pkgs.callPackage ./models { inherit collection; };
      # TODO: add tests for custom nodes
      # ...
    };
  };
}
