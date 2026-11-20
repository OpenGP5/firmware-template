#!/bin/bash
# Checks on the computer, no pedal and no cross-compilers: the whole firmware in the simulator with test/controls.txt
# (memory checkers on), its screens in build/sim/ and its sound in build/sim/out.wav.
set -euo pipefail
cd "$(dirname "$0")"
O=${OPENGP5:-opengp5}
[ -f "$O/tools/simulate.py" ] || { echo "OpenGP5 missing: run  git submodule update --init"; exit 1; }
python3 "$O/tools/simulate.py" . --script test/controls.txt --check --out build/sim/out.wav --shots build/sim
python3 - <<'PY'
import wave, sys
with wave.open("build/sim/out.wav") as w: b = w.readframes(w.getnframes())
peak = max(abs(int.from_bytes(b[i:i + 3], "little", signed=True)) for i in range(0, len(b), 3)) / 2 ** 23
sys.exit("FAIL: the output is silent") if peak < 0.01 else print(f"ok: sound (peak {peak:.2f}), screens in build/sim/")
PY
