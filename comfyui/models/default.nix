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
  configs = {
    # https://huggingface.co/lllyasviel/ControlNet-v1-1
    # See also the accompanying file in `controlnet`.
    controlnet-v1_1_fe-sd15-tile = (fetchModel {
      format = "yaml";
      url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11f1e_sd15_tile.yaml";
      sha256 = "sha256-OeEzjEFDYYrbF2BPlsOj90DBq10VV9cbBE8DB6CmrbQ=";
    });
  };
  controlnet = {
    # https://huggingface.co/lllyasviel/ControlNet-v1-1
    # See also the accompanying file in `configs`.
    controlnet-v1_1_f1e-sd15-tile = (fetchModel {
      format = "pth";
      url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1e_sd15_tile.pth";
      sha256 = "sha256-49icVoVc/i6gxOjLRcIpthTxjfwWjlxTx2BjraX4/mM=";
    });
  };
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
