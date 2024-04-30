{ inputs, self, ... }: {
  flake = {
    cfg.comfyui = system: let
      # this can be slightly confusing because this is *not* the same as base_path in extra_model_paths.yaml;
      # this is the base directory wherein misc mutable data is stored
      basePath = "/var/lib/comfyui";
    in {
      models = "${self.packages."${system}".comfyui-models}";
      customNodes = "${self.packages."${system}".comfyui-custom-nodes}";
      inputPath = "${basePath}/input";
      outputPath = "${basePath}/output";
      tempPath = "${basePath}/temp";
      userPath = "${basePath}/user";
    };
  };
  imports = [
    ./packages.nix
  ];
}
