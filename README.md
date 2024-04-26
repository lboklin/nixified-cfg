**DISCLAIMER:** this is WIP. Attribute names and the general structure may change and break as the main nixified-ai flake is updated to match. I suggest you wait until https://github.com/nixified-ai/flake/pull/94 has been merged unless you just want to test it.

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

