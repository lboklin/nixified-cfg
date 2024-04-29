{ inputs, self, ... }: {
  flake = {
    cfg.comfyui = system: let
      pkgs = import inputs.nixpkgs { inherit system; };
      models = pkgs.callPackage ./models {};
      # this can be slightly confusing because this is *not* the same as base_path in extra_model_paths.yaml;
      # this is the base directory wherein misc mutable data is stored
      basePath = "/var/lib/comfyui";
    in {
      inherit models;
      modelsPath = "${self.packages."${system}".comfyui-models}";
      inputPath = "${basePath}/input";
      outputPath = "${basePath}/output";
      tempPath = "${basePath}/temp";
      userPath = "${basePath}/user";
      customNodes = [];
    };
  };
  imports = [
    ./packages.nix
  ];
}
