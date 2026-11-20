<h1 align="center">My Effect</h1>

<p align="center"><b>A firmware for the Valeton GP-5, built with <a href="https://github.com/OpenGP5/OpenGP5">OpenGP5</a>.</b></p>

<p align="center">
  <img alt="Version 0.1.0" src="https://img.shields.io/badge/version-0.1.0-3cc0c1?style=flat-square">
  <a href="https://github.com/OpenGP5/OpenGP5"><img alt="Built on OpenGP5 0.8.0-alpha" src="https://img.shields.io/badge/built%20on-OpenGP5%200.8.0--alpha-5b6b7b?style=flat-square"></a>
  <a href="LICENSE"><img alt="Licence: MIT-0" src="https://img.shields.io/badge/licence-MIT--0-3ee8b5?style=flat-square"></a>
</p>

---

> [!TIP]
> **This repository is a template.** Click **Use this template** on GitHub to start your own firmware from it. It's
> a small overdrive (drive, tone, level, four presets) that already builds, tests itself and publishes releases.
> Change it into yours, then replace this README's title, description and badges with your own.

## Start

1. Click **Use this template** (top of the page on GitHub) and create your repository.
2. Edit `firmware.json`: your firmware's `id`, `name`, `author`, `url` and `description`. The `id` is lowercase and
   names your firmware's storage on the pedal, so keep it once people use your firmware.
3. Build it, in the browser or on your computer:
   - **In the browser:** **Code › Codespaces › Create codespace**. When it has set itself up (a few minutes the
     first time), run `./test.sh` and `./build.sh` in its terminal. Nothing to install.
   - **On your computer** ([what you need](https://opengp5.github.io/docs/platform/setup/)):
     ```bash
     git clone --recursive <your repository>
     cd <your repository>
     opengp5/release/setup-toolchain.sh      # once: the two compilers, pinned (~190 MB)
     ./test.sh                               # the whole firmware in the simulator: build/sim/*.png, out.wav
     ./build.sh                              # -> build/GP-5_<id>.bin
     ```
4. Flash `build/GP-5_<id>.bin` with [OpenGP5 Launchpad](https://github.com/OpenGP5/Launchpad), the
   [web flasher](https://opengp5.github.io/flasher/) or `python3 opengp5/tools/gp5tool.py flash <file> --sections all`.
   Read [Before you flash](https://opengp5.github.io/docs/get-started/safety/) first.

Every push is built and tested by GitHub Actions (`.github/workflows/build.yml`): the image and the simulator's
screens are in the run's **Artifacts**. Push a tag like `v1.0.0` and it publishes a release with the image.

When it's ready for others, [list it in OpenGP5's catalog](https://github.com/OpenGP5/OpenGP5/blob/main/catalog/README.md):
Launchpad and the web flasher then offer it, and your `id` is yours. You can claim the `id` early, before a
release.

## Controls

| Control | Does |
|---|---|
| **Turn PARA** | Pick a row: DRIVE, TONE, LEVEL, PRESET |
| **Click PARA** | Adjust the row: turn to change it; click again when done |
| **Hold PARA** | Save the sound into the preset shown |
| **Foot switch** | The effect on or off |
| **Volume knob** | Output level |

## How it's made

| File | What |
|---|---|
| `firmware.json` | Who it is and what it needs ([manifest](https://opengp5.github.io/docs/platform/api/#firmwarejson)) |
| `params.h` | Its settings: saved, in presets, sent to the DSP, editable from Launchpad ([Parameters](https://opengp5.github.io/docs/platform/params/)) |
| `dsp/firmware.h` | The sound, on the DSP: `fw_process()` gets 64 samples at a time |
| `nds32/firmware.c` | The controls and the screen, on the control processor, with the [UI kit](https://opengp5.github.io/docs/platform/ui/) |
| `test/controls.txt` | What `./test.sh` does in the [simulator](https://opengp5.github.io/docs/platform/simulator/) |
| `opengp5/` | The platform, a git submodule pinned to a release. Move it on with `git -C opengp5 checkout <tag>` |

New to OpenGP5? Start with [Your first effect](https://opengp5.github.io/docs/platform/first-effect/) and the
[API reference](https://opengp5.github.io/docs/platform/api/).

## Licence

The template is MIT No Attribution (`LICENSE`): make your firmware from it under any licence you like, and put that
licence's name in `firmware.json`.

Not affiliated with or endorsed by Valeton. "Valeton" and "GP-5" are Valeton's trademarks, used only to say which
pedal this runs on.
