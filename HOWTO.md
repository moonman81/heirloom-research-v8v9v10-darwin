# HOWTO — heirloom-research-v8v9v10-darwin

## Fetching a tape

```sh
mkdir -p vendor/v9
curl -L https://www.tuhs.org/Archive/Distributions/Research/Norman_v9/batterpudding.tar.gz \
    -o vendor/v9/batterpudding.tar.gz
shasum -a 256 vendor/v9/batterpudding.tar.gz
```

Or v10:

```sh
mkdir -p vendor/v10
curl -L https://www.tuhs.org/Archive/Distributions/Research/Norman_v10/milligan.gz \
    -o vendor/v10/milligan.gz
```

## Understanding the licence situation

Consult:

- TUHS's README on the Research directory.
- The Caldera 2002 licence (V1-V7 only — does NOT extend to V8-V10).
- Nokia's Bell Labs Archives contact if you need clarity.

If you can't get clarity, do not build or redistribute the source.

## Recommended first port: V9 rc(1)

Rob Pike's `rc(1)` shell is small, self-contained, and independent
of the V9 kernel. Ports well to Darwin. If you want to make progress
against this repo without touching kernel-linked utilities, start
with `rc`.
