# Architecture Decision Records

Issue #184 asked for a NestJS Swagger portal and a React Storybook — neither
exists in this Flutter-only, local-first repo, so those two pieces aren't
implemented. This directory is the one part of #184 that's genuinely
applicable here: a record of *why*, not just *how*, for decisions the code
alone doesn't explain.

## Format

Each ADR is a short markdown file: `NNNN-title-in-kebab-case.md`, numbered
sequentially, containing:

- **Status** — Accepted, Superseded, or Deprecated.
- **Context** — the problem or constraint that forced a decision.
- **Decision** — what was actually chosen.
- **Consequences** — the real trade-offs, including ones that turned out to
  be costly. An ADR that only lists upsides isn't telling the whole story.

New ADRs are numbered after the highest existing one and never renumbered or
deleted — if a decision is reversed, add a new ADR marked "Supersedes NNNN"
and mark the old one "Superseded by NNNN".

## Index

| # | Title | Status |
|---|-------|--------|
| [0001](0001-local-first-objectbox-persistence.md) | Local-first persistence with ObjectBox | Accepted |
| [0002](0002-getx-state-management-and-di.md) | GetX for state management and dependency injection | Accepted |
| [0003](0003-flat-shadcn-ui-design-system.md) | Flat shadcn_ui design system, retiring Glassmorphism | Accepted |
| [0004](0004-local-first-reinterpretation-over-literal-backend-specs.md) | Reinterpret infeasible backend-dependent issues locally, don't skip them | Accepted |
| [0005](0005-automated-per-issue-pipeline-deferred-verification.md) | Automated per-issue PR pipeline with deferred verification | Accepted |
| [0006](0006-append-only-persisted-enum-ordering.md) | Append-only ordering for enums backed by a persisted int index | Accepted |
