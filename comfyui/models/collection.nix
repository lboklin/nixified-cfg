## Here are some examples of how to add a model. Set `sha256 = ""` after adding a new model
## and wait for it to download and give you the correct one. The download *should* be cached.
## TODO: models requiring an API key can not currently be added here because there is no
## good/easy/satisfactory way to handle secrets.
{
  checkpoints = {
    # # https://civitai.com/models/112902/dreamshaper-xl
    # dreamshaper-xl-fp16 = ({
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
    # controlnet-v1_1_fe-sd15-tile = ({
    #   format = "yaml";
    #   url = "https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11f1e_sd15_tile.yaml";
    #   sha256 = "sha256-OeEzjEFDYYrbF2BPlsOj90DBq10VV9cbBE8DB6CmrbQ=";
    # });
  };
  controlnet = {
    # # https://huggingface.co/lllyasviel/ControlNet-v1-1
    # # See also the accompanying file in `configs`.
    # controlnet-v1_1_f1e-sd15-tile = ({
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
