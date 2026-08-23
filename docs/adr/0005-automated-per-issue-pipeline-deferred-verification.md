# 0005: Automated per-issue PR pipeline with deferred verification

## Status
Accepted

## Context
This repo's backlog is worked issue-by-issue by an automated pipeline: pick
the next open, genuinely-implementable issue, branch from `stage`, implement
it, write a test file, and open a PR — one issue per PR, one PR per pipeline
run. Running the full toolchain (`flutter analyze`, `flutter test`, an
emulator for visual QA) inside every single pipeline invocation is slow and
token-expensive at this cadence, and `flutter build web --release` is only
warranted when a change plausibly touches web-incompatible (native/platform)
code.

## Decision
The pipeline writes test files alongside new business logic but does not
execute `flutter analyze` or `flutter test` itself, and does not launch an
emulator/simulator for visual QA. `.github/workflows/flutter_ci.yml` is the
real backstop that runs `flutter analyze`/`flutter test` on every PR against
`stage` — verification is deferred to CI and to the human merging the PR,
not skipped. `/emulator-qa` exists as a separate, explicitly-invoked command
for when visual QA is actually wanted.

## Consequences
- A given PR's description can only say tests were *added*, never that they
  were *run and passing* — "run `flutter test` manually when ready" is a
  standing caveat on every PR from this pipeline, not a one-off disclaimer.
- Real bugs slip through until CI or a human runs the suite — e.g. #189's PR
  found a live crash (missing `ShadTheme` ancestor) that had already been
  merged in two earlier PRs, purely by static reading, not by running the
  app; a project that ran `flutter analyze`/tests every cycle might have
  caught type-level issues sooner, though a rendering-time `ShadTheme.of()`
  crash specifically wouldn't be caught by `flutter analyze` either way.
- Until recently, `.github/workflows/flutter_ci.yml` was itself a stub that
  never actually ran `flutter analyze`/`flutter test` — meaning this backstop
  didn't exist for a stretch of the project's history, and PRs pushing
  changes to `.github/workflows/*` require a `workflow`-scoped git
  credential this environment doesn't reliably have, which has blocked at
  least one CI-hardening change (the analyze/test gate itself) from landing
  promptly.
