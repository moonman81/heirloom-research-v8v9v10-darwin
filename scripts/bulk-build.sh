#!/bin/sh
# bulk-build.sh <edition>   where <edition> ∈ {v8, v9, v10}
# Bulk-compile every single-source .c file in the extracted upstream
# tree under vendor/<edition>/ to build/<edition>/.
set -eu
ED="${1:?edition required (v8|v9|v10)}"

case "$ED" in
  v8) SRCDIR="vendor/v8/usr/src/cmd" ;;
  v9) SRCDIR="vendor/v9/cmd" ;;
  v10) SRCDIR="vendor/v10/cmd" ;;
  *)  echo "unknown edition $ED" >&2; exit 2 ;;
esac

if [ ! -d "$SRCDIR" ]; then
    echo "$SRCDIR not found — extract upstream tape first (see README.md)" >&2
    exit 2
fi

mkdir -p "build/$ED"
CFLAGS="-O -std=gnu89 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-conversion -Wno-return-type -Wno-return-mismatch -Wno-deprecated-non-prototype -Wno-incompatible-function-pointer-types -Wno-int-to-pointer-cast -Wno-parentheses -Wno-format-security"

pass=""; fail=""
for src in $(find "$SRCDIR" -maxdepth 1 -name '*.c'); do
    tool=$(basename "$src" .c)
    if cc $CFLAGS "$src" -o "build/$ED/$tool" 2>/dev/null; then
        pass="$pass $tool"
    else
        fail="$fail $tool"
    fi
done

n_pass=$(echo $pass | wc -w | tr -d ' ')
n_fail=$(echo $fail | wc -w | tr -d ' ')
echo "$ED: pass=$n_pass fail=$n_fail"
echo "$pass" > "build/$ED/PASS.txt"
echo "$fail" > "build/$ED/FAIL.txt"
