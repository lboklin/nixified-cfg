**NOTE:** this is wip; substitute github:nixified-ai/flake for github:lboklin/nixified-ai below.

Flake meant for providing [nixified-ai](https://github.com/nixified-ai/flake) with configuration options at build time by overriding the default input. It's basically a cheat to parameterise the nixified-ai flake over another flake.

## Usage

How to use this with `comfyui-*`:
```sh
# clone this repo
git clone <this repo>
# then pass it in when calling a nixified-ai package:
nix {build,run} github:nixified-ai/flake#comfyui-{amd,nvidia} --override-input cfg ./nixified-cfg
```

