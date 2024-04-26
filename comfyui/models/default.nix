## Some examples of how to add a model are included. Set `sha256 = ""` after adding a new model
## and wait for it to download and give you the correct one. Don't worry, the download is cached.
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
    # # https://civitai.com/models/112902/dreamshaper-xl
    # dreamshaper-xl-fp16 = (fetchModel {
    #   url = "https://civitai.com/api/download/models/351306";
    #   format = "safetensors";
    #   sha256 = "sha256-RJazbUi/18/k5dvONIXbVnvO+ivvcjjSkNvUVhISUIM=";
    # });
  };
  clip = {};
  clip_vision = {};
  configs = {
    # # https://huggingface.co/lllyasviel/ControlNet-v1-1
    # # See also the accompanying file in `controlnet`.
    # controlnet-v1_1_fe-sd15-tile = (fetchModel {
    #   format = "yaml";
    #   url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11f1e_sd15_tile.yaml";
    #   sha256 = "sha256-OeEzjEFDYYrbF2BPlsOj90DBq10VV9cbBE8DB6CmrbQ=";
    # });
  };
  controlnet = {
    # # https://huggingface.co/lllyasviel/ControlNet-v1-1
    # # See also the accompanying file in `configs`.
    # controlnet-v1_1_f1e-sd15-tile = (fetchModel {
    #   format = "pth";
    #   url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/blob/main/control_v11f1e_sd15_tile.pth";
    #   sha256 = "sha256-49icVoVc/i6gxOjLRcIpthTxjfwWjlxTx2BjraX4/mM=";
    # });
  };
  embeddings = {};
  loras = {};
  upscale_models = {};
  vae = {};
  vae_approx = {};
}
