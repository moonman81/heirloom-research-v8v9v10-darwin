#!/bin/sh
# apply-patches.sh <edition>   where <edition> ∈ {v8, v9, v10}
set -eu
ED="${1:?edition required}"
if [ ! -d "vendor/$ED" ]; then
    echo "vendor/$ED not found — fetch upstream tape first (see HOWTO.md)" >&2
    exit 2
fi
# apply patches/$ED/*.patch in order
for p in patches/$ED/*.patch; do
    [ -f "$p" ] || continue
    echo "applying $p"
    (cd "vendor/$ED" && patch -p1 -N < "../../$p") || echo "  (skip already-applied)"
done
