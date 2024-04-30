{ ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages = {
      comfyui-models = pkgs.callPackage ./models {};
      comfyui-custom-nodes = pkgs.callPackage ./custom-nodes {};
    };

    checks = {
      # TODO: add some more (lightweight) stuff to the model set
      comfyui-model-collection = let
        yaml-file = import ./models/fetch-model.nix { inherit lib; inherit (pkgs) fetchurl; } {
          format = "yaml";
          url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11f1e_sd15_tile.yaml";
          sha256 = "sha256-OeEzjEFDYYrbF2BPlsOj90DBq10VV9cbBE8DB6CmrbQ=";
        };
        collectionDrv = pkgs.callPackage ./models/make-collection.nix {};
      # fetch a 2KB yaml file to check that it works.
      in collectionDrv { configs = { controlnet-v1_1_fe-sd15-tile = yaml-file; }; };
      # TODO: add tests for custom nodes
      # ...
    };
  };
}
