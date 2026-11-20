# My Effect

A firmware for the Valeton GP-5, built with [OpenGP5](https://github.com/OpenGP5/OpenGP5). This repository is a
template: click **Use this template** on GitHub to start your own firmware from it. It is a small overdrive (drive,
tone, level, four presets) that already builds, tests itself and publishes releases. Change it into yours.

## Start

1. **Use this template** (top of the page on GitHub), then in your new repository:
2. Edit `firmware.json`: your firmware's `id` (lowercase, it names your storage on the pedal: keep it once people
   use your firmware), `name`, `author`, `url`, `description`.
3. Build it, one of two ways:
   - **In the browser:** *Code* → *Codespaces* → *Create codespace*. When it has set itself up (a few minutes the
     first time), run `./test.sh` and `./build.sh` in its terminal.
   - **On your computer:**
     ```
     git clone --recursive <your repository>
     cd <it>
     opengp5/release/setup-toolchain.sh      # once: the two compilers, pinned (~190 MB); macOS also needs Docker
     ./test.sh                               # the whole firmware in the simulator: build/sim/*.png, out.wav
     ./build.sh                              # -> build/GP-5_<id>.bin
     ```
4. Flash `build/GP-5_<id>.bin` with [OpenGP5 Launchpad](https://github.com/OpenGP5/Launchpad), the
   [web flasher](https://opengp5.github.io/OpenGP5/flasher/) or `python3 opengp5/tools/gp5tool.py flash <file> --sections all`.
   Read OpenGP5's [getting-started guide](https://github.com/OpenGP5/OpenGP5/blob/main/GETTING-STARTED.md),
   *Recovery* especially, before your first flash.

When it's ready for others, [list it in OpenGP5's catalog](https://github.com/OpenGP5/OpenGP5/blob/main/catalog/README.md):
Launchpad and the web flasher then offer it, and your id is yours. You can claim the id early, before a release.

Every push is built and tested by GitHub Actions (`.github/workflows/build.yml`): the image and the simulator's
screens are under the run's *Artifacts*. Push a tag like `v1.0.0` and it publishes a release with the image.

## What is where

| file | what |
|---|---|
| `firmware.json` | who it is and what it needs ([manifest](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/api.md#firmwarejson)) |
| `params.h` | its settings: saved, in presets, sent to the DSP, editable from Launchpad ([parameters](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/params.md)) |
| `dsp/firmware.h` | the sound, on the DSP: `fw_process()` gets 64 samples at a time |
| `nds32/firmware.c` | the controls and the screen, on the control processor, with the [UI kit](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/ui.md) |
| `test/controls.txt` | what `./test.sh` does in the [simulator](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/simulator.md) |
| `opengp5/` | the platform, a git submodule pinned to a release; move it on with `git -C opengp5 checkout <tag>` |

The controls as they are: turn PARA to pick DRIVE, TONE, LEVEL or PRESET; click to adjust, click again when done;
hold PARA to save into the preset shown; the foot switch turns the effect on and off; the volume knob is the output
level.

Start reading at OpenGP5's [Your first effect](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/first-effect.md)
and [API](https://github.com/OpenGP5/OpenGP5/blob/main/docs/platform/api.md).

## Licence

The template is MIT No Attribution (`LICENSE`): make your firmware from it under any licence you like, and put that
licence's name in `firmware.json`.
