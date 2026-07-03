#!/bin/sh
# build-v9-tool.sh <tool-name>
# Compiles a V9 single-source tool from vendor/v9/cmd/<tool-name>.c
# with Darwin-modern CFLAGS.
set -eu
TOOL="${1:?tool required (e.g. cat, echo)}"

SRC="vendor/v9/cmd/${TOOL}.c"
if [ ! -f "$SRC" ]; then
    echo "$SRC not found — extract V9 batterpudding.tar.gz into vendor/v9/ first" >&2
    exit 2
fi

mkdir -p build/v9
cc -O -std=gnu89 \
   -Wno-implicit-int -Wno-implicit-function-declaration \
   -Wno-int-conversion -Wno-return-type -Wno-return-mismatch \
   -Wno-deprecated-non-prototype -Wno-incompatible-function-pointer-types \
   "$SRC" -o "build/v9/${TOOL}"

file "build/v9/${TOOL}"
echo "OK build/v9/${TOOL}"
