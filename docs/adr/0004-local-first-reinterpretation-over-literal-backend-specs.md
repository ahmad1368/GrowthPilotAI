# 0004: Reinterpret infeasible backend-dependent issues locally, don't skip them

## Status
Accepted

## Context
A large share of this repo's auto-generated issue backlog is written as if
a NestJS/Express + MongoDB backend and, in some cases, a React web frontend
already exist alongside the Flutter app (e.g. #184's Swagger/Storybook ask,
#190's App Store Connect API, #192's LinkedIn ad campaign, #205's Jest/
Supertest suite). None of that backend or frontend exists — this is a
Flutter-only, local-first client (ADR 0001). Two options exist for these
issues: leave them permanently unimplementable, or find the closest thing
that's actually true to both the issue's underlying business intent and
this app's real architecture.

## Decision
When an issue's literal spec requires infrastructure that doesn't exist,
implement the closest genuinely-buildable local-first equivalent instead of
either (a) building the literal, infeasible spec, or (b) skipping the issue
entirely — and document the reinterpretation explicitly in the PR body.
Examples already shipped this way: `MockBankLinkService` (client-side
contract + mock standing in for a real Plaid/NestJS integration, #63-#66),
`CalculateGstPst`'s Ontario HST support (standing in for #205's Jest test
suite, by testing this app's actual financial-calculation engine instead),
`AcquisitionAttributionService` (UTM capture standing in for #192's full
LinkedIn campaign), and this very `docs/adr/` directory (standing in for
#184's Swagger/Storybook, which have no NestJS/React target to document).

## Consequences
- A reader following an issue number back to its PR sees real, working
  local code — not a stub, not a TODO, and not silence — even when the
  issue's own literal acceptance criteria can't be fully met.
- Every such PR also states plainly what's still missing to fulfill the
  issue's literal ask (e.g. "still requires a real Apple Developer account,"
  "still requires an actual NestJS backend") rather than implying the issue
  is fully resolved by github's auto-close on merge.
- This decision means "closed" on this repo's issue tracker doesn't always
  mean "100% of the literal spec is done" — it means "the feasible part is
  done, and the infeasible part is explicitly documented as such." Anyone
  auditing closed issues for literal compliance needs to read the linked
  PR, not just trust the closed state.
