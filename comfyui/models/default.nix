## TODO: no easy way to handle secrets, so models requiring an API key are left out.
{ stdenv
, lib
, fetchurl
}:

let
  fetchModel = import ./fetch-model.nix { inherit lib fetchurl; };
  collectionDrv = import ./make-collection.nix { inherit lib stdenv; };
in collectionDrv {
  checkpoints = {
    # https://civitai.com/models/4384
    dreamshaper-xl-fp16 = (fetchModel {
      url = "https://civitai.com/api/download/models/128713";
      format = "safetensors";
      sha256 = "sha256-h521I8MNO5AXFD1WcFAV4VostWKHYsEdCG/tlTir1/0=";
    });
  };
  clip = {};
  clip_vision = {};
  configs = {};
  controlnet = {};
  embeddings = {};
  loras = {};
  # Upscaler comparisons can be found here:
  # https://civitai.com/articles/636/sd-upscalers-comparison
  upscale_models = {
    # https://openmodeldb.info/models/4x-realesrgan-x4plus
    # https://github.com/xinntao/Real-ESRGAN
    real-esrgan-4xplus = (fetchModel {
      url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth";
      format = "pth";
      sha256 = "sha256-T6DTiQX3WsButJp5UbQmZwAhvjAYJl/RkdISXfnWgvE=";
    });
  };
  vae = {};
  vae_approx = {};
}
