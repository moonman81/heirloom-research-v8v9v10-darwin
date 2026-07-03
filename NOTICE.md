# NOTICE — heirloom-research-v8v9v10-darwin

## Scope

Patches-only Darwin port scaffold for Bell Labs Research Unix
editions V8 (1985), V9 (1986), V10 (1989).

**Not authoritative.** Upstream source at TUHS
(<https://www.tuhs.org/Archive/Distributions/Research/>).

## Content

- README, NOTICE, AI-DISCLOSURE, GRATITUDE, PROVENANCE, BIBLIOGRAPHY,
  HOWTO.
- `scripts/` — patch application + build wrappers.
- `patches/{v8,v9,v10}/` — currently empty; Darwin patches populate
  as porting proceeds.
- `vendor/` — where users drop TUHS-fetched tarballs; gitignored.

## Does not ship

- V8/V9/V10 source code. Bell Labs / AT&T / Nokia licensing overlay
  is unclear; the Caldera 2002 grant covers V1-V7 only.
- Any binaries.

## Take-down

`.github/ISSUE_TEMPLATE/attribution_concern.md` or
`i.am.moonman@gmail.com`. Honoured without argument.
