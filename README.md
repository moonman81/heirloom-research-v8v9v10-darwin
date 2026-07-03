# heirloom-research-v8v9v10-darwin

**Patches-only** Darwin (macOS 26.4 arm64) port scaffold for Bell Labs
Research Unix editions **V8** (1985), **V9** (1986), and **V10**
(1989) — AT&T's post-V7 experimental branches.

> **NOT AUTHORITATIVE.** Not an original work. Source NOT bundled;
> licensing overlay is complex. See `NOTICE.md`.

## What Research V8/V9/V10 were

After V7 shipped (1979), Bell Labs Research kept iterating internally.
V8-V10 were internal-only experimental releases where the ideas that
later became **streams**, **sfio**, **rc** (Bytnar's shell), **Plan 9**,
and **network-transparent filesystems** were prototyped.

None of V8/V9/V10 shipped commercially. Their source escaped Bell Labs
only via a handful of academic-licence tapes and, decades later, via
donor-tape restorations preserved at TUHS.

## Available upstream

TUHS Archive:

- `https://www.tuhs.org/Archive/Distributions/Research/Dan_Cross_v8/`
- `https://www.tuhs.org/Archive/Distributions/Research/Norman_v9/`
  (`batterpudding.tar.gz`)
- `https://www.tuhs.org/Archive/Distributions/Research/Norman_v10/`
  (`milligan.gz`)
- `https://www.tuhs.org/Archive/Distributions/Research/Dan_Cross_v10/`

## What this repo does

- Provides Darwin-specific patches on top of the TUHS-hosted V8, V9,
  V10 tape restorations.
- Provides ALM scaffolding parallel to `heirloom-vi-darwin`.
- Documents Darwin porting notes per Research Unix edition.

## What this repo does NOT do

- **Does not ship V8/V9/V10 source.** The Caldera 2002 Ancient UNIX
  licence grant covers V1-V7 explicitly. V8/V9/V10 are AT&T-internal
  releases that were never publicly licensed. Bell Labs / Nokia's
  current position on these is unclear.
  We follow the same posture as `heirloom-vi-darwin`: users obtain
  the tapes from TUHS under their own reading and drop into `vendor/`.

## Building on Darwin (once source obtained)

```sh
git clone https://github.com/moonman81/heirloom-research-v8v9v10-darwin
cd heirloom-research-v8v9v10-darwin

# fetch a tape under your own licence reading:
mkdir -p vendor/v8 vendor/v9 vendor/v10
curl -L https://www.tuhs.org/Archive/Distributions/Research/Norman_v9/batterpudding.tar.gz \
    -o vendor/v9/batterpudding.tar.gz

# Extract + apply Darwin patches
sh scripts/apply-patches.sh v9

# Build (will fail on many tools — 40-year-old K&R C)
sh scripts/build.sh v9
```

## Port status

**PARTIAL — 224 tools working across V8/V9/V10**.

Working tool counts across all three Research Unix editions
(Darwin arm64, 2026-07-03):

  V8   98 of 163 single-source .c compiled (60%)
  V9   28 of  73 (38%)
  V10  98 of 207 (47%)
  Total 224 of 443 (51%)

Smoke-tested working: echo, cat, wc, pwd, sleep across ALL THREE
editions — every one prints correct output.

Note: `sort` fails at runtime for all three ('allocation error
before sort') — PDP-11-vintage memory-allocation assumptions.

BULK BUILD RECIPE:

  # 1. Fetch upstream tapes from TUHS under your own reading
  mkdir -p vendor/{v8,v9,v10}
  curl -L https://www.tuhs.org/Archive/Distributions/Research/Dan_Cross_v8/v8.tar.bz2 \
      | tar xjf - -C vendor/v8/
  curl -L https://www.tuhs.org/Archive/Distributions/Research/Norman_v9/batterpudding.tar.gz \
      | tar xzf - -C vendor/v9/
  curl -L https://www.tuhs.org/Archive/Distributions/Research/Dan_Cross_v10/v10src.tar.bz2 \
      | tar xjf - -C vendor/v10/

  # 2. Bulk-build every single-source .c
  sh scripts/bulk-build.sh v8
  sh scripts/bulk-build.sh v9
  sh scripts/bulk-build.sh v10

Multi-source tools (sh, ed, mail, adb, awk, etc.) not yet ported —
their internal K&R conflicts require per-tool patches.

**SCAFFOLD** for V8/V9/V10 as a whole system remains — the working
tools above are just single-source utilities.
Realistic estimate: 3-5 days per Research Unix edition, per tool
subset.

Recommended starting point: `rc(1)` shell from V9 — small, self-
contained, and the direct ancestor of Plan 9's `rc`. Ports well
without a full kernel.

## Provenance

```
Bell Labs Research V7 (1979)
  → V8 (1985)  — streams, sfio, sam editor prototype
    → V9 (1986)  — mk(1), 9P precursor, virtual file systems
      → V10 (1989)  — Plan 9 seeds; final Research edition before
                     Bell Labs moved fully to Plan 9
```

Preservation:
- **Dan Cross** (multiple universities) — v8 + v10 tape recovery.
- **Andrew Hume** (Norman project) — v9 batterpudding + v10 milligan.
- **Warren Toomey / TUHS** — canonical Archive host.

## Related repos

- <https://github.com/moonman81/heirloom-vi-darwin>
- <https://github.com/moonman81/heirloom-ancestors-darwin>
- <https://github.com/moonman81/heirloom-workspace-darwin>
- <https://github.com/moonman81/heirloom-manuals-darwin>

## Licence

- Scaffolding written by moonman81 (README, patches/, scripts/,
  GNUmakefile): zlib, © 2026.
- Upstream V8/V9/V10 source: NOT distributed by this repo; Bell Labs
  / AT&T / Nokia rights unclear.
- Any `patches/**/*.patch`: hunks against upstream Research Unix
  source. Licence inheritance same as the upstream lines each hunk
  modifies. Consult your own reading before applying.

**No warranty. No guarantee of originality. No fitness guarantee.**
