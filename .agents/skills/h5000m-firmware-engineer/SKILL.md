---
name: h5000m-firmware-engineer
description: Build, diagnose, and trace H5000M ImmortalWrt Rescue or Full firmware from this repository's exact source locks. Use for H5000M configuration, GitHub Actions builds, build failures, manifests, reports, and firmware artifacts; device validation and upstream-update promotion are separate workflows.
---

# H5000M firmware engineer

Follow `AGENTS.md` for permanent safety, evidence, product, and scope rules.

1. Reload the required repository context and Git state. Classify the request as
   configuration, build, failure repair, artifact inspection, or documentation.
2. Select Rescue or Full from the explicit task; never infer Full from a Rescue
   request. Read evidence references only when provenance or historical behavior
   affects the decision.
3. Validate the selected source lock: exact project, ImmortalWrt, feed, QModem
   and driver commits. Stop on drift or unknown required Rescue sources.
4. Run prepare and verify every checkout HEAD, then apply and verify native
   H5000M baselines, Higo hashes, defaults, dual UI, RG520/QMAP sources, and
   idempotence.
5. Load the selected profile, run `make defconfig`, save `resolved.config`, and
   gate every required requested/resolved option. Record missing options as
   `REQUESTED`, `RESOLVED`, `REASON`; do not build through a failed gate.
6. Pass source, config, H5000M, Higo, RG520 and traceability gates before compile.
   Build with reasonable parallelism. On an unclear failure, reproduce with
   single-job verbose output and identify the first causal error.
7. Make the smallest in-scope fix. Record error, root cause, changed files,
   before/after, impact and evidence. Stop if repair requires a source-lock or
   architecture change, removes a core function, repeats the same unresolved
   cause, or crosses current scope.
8. Generate the manifest from real Git/source/config/runner/artifact state,
   embed `/etc/h5000m-build.json`, create a build report and SHA256SUMS, and use
   run-specific artifact names. Unknown fields stay null/UNKNOWN.
9. Synchronize required documentation, run Git and sensitive-data checks,
   commit with a causal message, push only the authorized branch, and inspect
   the resulting workflow/artifacts. Never upgrade stable automatically.
