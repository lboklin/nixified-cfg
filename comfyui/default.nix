{ inputs, self, ... }: {
  flake = {
    cfg.comfyui = system: let
      pkgs = import inputs.nixpkgs { inherit system; };
      models = pkgs.callPackage ./models {};
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
