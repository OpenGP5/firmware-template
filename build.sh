#!/bin/bash
# Build the firmware into one flashable image: build/GP-5_<id>.bin (the id from firmware.json).
# First time: git submodule update --init && opengp5/release/setup-toolchain.sh   (README.md)
set -euo pipefail
cd "$(dirname "$0")"
O=${OPENGP5:-opengp5}                                    # OPENGP5=<an OpenGP5 checkout>: build against another one
[ -f "$O/platform/build_firmware.sh" ] || { echo "OpenGP5 missing: run  git submodule update --init"; exit 1; }
ID=$(python3 -c 'import json; print(json.load(open("firmware.json"))["id"])')
[ "$ID" = my-effect ] && echo "note: firmware.json still has the template's id (my-effect): give your firmware its own"
"$O/platform/build_firmware.sh" . "build/GP-5_$ID.bin"
python3 "$O/tools/gp5tool.py" info "build/GP-5_$ID.bin"
