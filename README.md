**DISCLAIMER:** this is WIP. Attribute names and the general structure may change and break as the main nixified-ai flake is updated to match. I suggest you wait until https://github.com/nixified-ai/flake/pull/94 has been merged unless you just want to test it.

Flake meant for providing [nixified-ai](https://github.com/nixified-ai/flake) with configuration options at build time by overriding the default input. It's basically a cheat to parameterise the nixified-ai flake over another flake.

## Purpose of this configuration

This particular configuration is supposed to satisfy the [minimum requirements](https://github.com/Acly/krita-ai-diffusion/wiki/ComfyUI-Setup) for using it with the [Krita AI plugin](https://github.com/Acly/krita-ai-diffusion/) (installed separately).

TODO:
- [ ] custom nodes
  - [ ] https://github.com/Fannovel16/comfyui_controlnet_aux
  - [ ] https://github.com/cubiq/ComfyUI_IPAdapter_plus
  - [ ] https://github.com/ssitu/ComfyUI_UltimateSDUpscale
  - [ ] https://github.com/Acly/comfyui-inpaint-nodes
  - [ ] https://github.com/Acly/comfyui-tooling-nodes
- [ ] models
  - [ ] checkpoints
    - [x] SD 1.5
      - [x] https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/realisticVisionV51_v51VAE.safetensors
      - [x] https://huggingface.co/Lykon/DreamShaper/resolve/main/DreamShaper_8_pruned.safetensors
    - [x] SD XL
      - [x] https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/juggernautXL_version6Rundiffusion.safetensors
  - [x] inpaint
    - [x] shared between SD 1.5 and SD XL
      - [x] https://huggingface.co/Acly/MAT/resolve/main/MAT_Places512_G_fp16.safetensors
    - [x] SD XL
      - [x] https://huggingface.co/lllyasviel/fooocus_inpaint/resolve/main/fooocus_inpaint_head.pth
      - [x] https://huggingface.co/lllyasviel/fooocus_inpaint/resolve/main/inpaint_v26.fooocus.patch
  - [x] loras
    - [x] SD 1.5
      - [x] https://huggingface.co/latent-consistency/lcm-lora-sdv1-5/resolve/main/pytorch_lora_weights.safetensors?download=true
        - name: lcm-lora-sdv1-5.safetensors
    - [x] SD XL
      - [x] https://huggingface.co/latent-consistency/lcm-lora-sdxl/resolve/main/pytorch_lora_weights.safetensors?download=true
        - name: lcm-lora-sdxl.safetensors
  - [x] controlnets
    - [x] SD 1.5
      - [x] https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_inpaint_fp16.safetensors
      - [x] https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_lora_rank128_v11f1e_sd15_tile_fp16.safetensors
  - [x] ipadapters
    - [x] SD 1.5
      - [x] https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors
    - [x] SD XL
      - [x] https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors
  - [x] upscale_models (all shared between SD 1.5 and SD XL)
    - [x] https://huggingface.co/gemasai/4x_NMKD-Superscale-SP_178000_G/resolve/main/4x_NMKD-Superscale-SP_178000_G.pth
    - [x] https://huggingface.co/Acly/Omni-SR/resolve/main/OmniSR_X2_DIV2K.safetensors
    - [x] https://huggingface.co/Acly/Omni-SR/resolve/main/OmniSR_X3_DIV2K.safetensors
    - [x] https://huggingface.co/Acly/Omni-SR/resolve/main/OmniSR_X4_DIV2K.safetensors
  - [x] clip_vision (all shared between SD 1.5 and SD XL)
    - [x] https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors?download=true

## Usage

How to use this with `comfyui-*`:
```sh
# clone this repo
git clone https://github.com/lboklin/nixified-cfg
cd nixified-cfg
# make whatever changes you want to `cfg.comfyui` in ./flake.nix
# then pass it in when calling a nixified-ai package:
nix {build,run} github:lboklin/nixified-ai#comfyui-{amd,nvidia} --override-input nixified-cfg .
```

