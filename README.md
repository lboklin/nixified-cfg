**NOTE:** this is WIP.

Flake meant for providing [nixified-ai](https://github.com/nixified-ai/flake) with configuration options at build time by overriding the default input. It's basically a cheat to parameterise the nixified-ai flake over another flake.

## Usage

How to use this with `comfyui-*`:
```sh
# clone this repo
git clone https://github.com/lboklin/nixified-cfg
cd nixified-cfg
# make whatever changes you want to `cfg.comfyui` in ./flake.nix
# then pass it in when calling a nixified-ai package:
nix {build,run} github:lboklin/nixified-ai#comfyui-{amd,nvidia} --override-input cfg .
```

