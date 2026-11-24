#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-only
# Ukigusa-felucca: build only the browser demo, without the JieLi toolchain or SDK.
# Runs the table/font generation step of tools/build.py, then web/emu/build.sh.
#   tools/emu_only.sh  ->  build/emu/   (serve with: python3 -m http.server -d build/emu 8790)
set -e
cd "$(dirname "$0")/.."
python3 -c 'import sys; sys.path.insert(0, "tools"); import build; build.generate()'
sh web/emu/build.sh
