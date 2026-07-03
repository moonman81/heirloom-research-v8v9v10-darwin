#!/bin/sh
# build.sh <edition>
set -eu
ED="${1:?edition required}"
echo "Building $ED under vendor/$ED — WARNING: 40-year-old K&R C, many failures expected"
(cd "vendor/$ED" && make 2>&1 | head -30)
