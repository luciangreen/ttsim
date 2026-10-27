# Program requirements and implementation status

This file tracks the implementation against [`pr1.txt`](pr1.txt). The codebase is a runnable prototype; it does **not** yet satisfy every section or acceptance criterion of that specification. The README contains user-facing setup, examples, and a capability summary.

## Implemented prototype areas

| Area | Modules | Current coverage |
|---|---|---|
| Reality labels, clock, and dashboard | `reality_model`, `simulation_clock`, `reality_dashboard` | Basic labels, clock modes, and dashboard projection. |
| Appointment planning | `appointment_model`, `priority_scheduler`, `temporal_planner` | Appointment classification and a basic plan that keeps fixed events visible. Full conflict checks and all scheduling constraints are outstanding. |
| Timeline exploration | `checkpoint_manager`, `branch_manager`, `causal_consistency`, `timeline_streamliner` | Basic branch/checkpoint operations, comparisons, consistency findings, and protected-segment handling. |
| Characters and agents | `character_model`, `character_transport`, `bot_controller`, `consent` | Structured character/transport terms, permission checks, and consent validation helpers. Enforcement is not integrated into every operation. |
| Scenario models | `life_profiles`, `identity_continuity`, `virtual_locations`, `creative_work_sessions`, `highlight_selector`, `visibility_modes`, `narrative_continuity`, `perspective_offsets`, `avatar_body_model` | Mostly term-level or helper predicates; they do not implement a complete interactive simulation. |
| Wellness and finance | `health_simulation`, `financial_continuity`, `pension_model` | Wellness feature/claim boundaries and basic duplicate verified-payment detection. There are no medical or financial integrations. |
| Provisional specifications | `provisional_specification` | Assumption labelling and a simple uncertainty report. Source verification and replacement workflows are outstanding. |
| Ethics boundaries | `ethics`, `compliance` | A defined list of prohibited operations and blocking findings; not a comprehensive policy engine. |
| State and interaction | `state_store`, `persistence`, `command_parser`, `repl` | In-memory state, basic term save/load, and parsing of a few commands. |
| Other specification modules | `artefact_generator`, `audit_log`, `reporting`, `separation_mode` | Initial module/predicate shapes only; important behaviors listed below are not complete. |

## Running tests

Install SWI-Prolog, then run all current PlUnit tests from the repository root:

```bash
sudo apt-get update
sudo apt-get install swi-prolog-nox
swipl -q -s test/run_tests.pl
```

Run an individual test file:

```bash
swipl -q -s test/test_temporal_planner.pl -g run_tests -t halt
```

Run the demo separately:

```bash
swipl -q -s src/real_time_travel_simulation.pl -g run_demo -t halt
```

The GitHub Actions workflow runs the full test command on pushes and pull requests. The current runner loads these test files:

| Test file | Main behavior exercised |
|---|---|
| `test_reality_model.pl` | Accepted and rejected reality labels |
| `test_simulation_clock.pl` | Default clock modes and ratio validation |
| `test_appointments.pl` | Appointment classification |
| `test_priority_scheduler.pl` | Preservation of a university event |
| `test_temporal_planner.pl` | Real/simulated schedule representation |
| `test_streamlining.pl` | Preservation of protected timeline segments |
| `test_checkpoints.pl` | Checkpoint return creates a branch |
| `test_branches.pl` | Basic branch comparison |
| `test_causal_consistency.pl` | Detection of a conflict |
| `test_characters.pl` | Simulated-only transport labeling |
| `test_bots.pl` | Bot allow/deny permissions |
| `test_life_profiles.pl` | Life-profile term creation |
| `test_identity_continuity.pl` | Continuity-record construction |
| `test_provisional_specs.pl` | Assumptions in provisional specifications |
| `test_financial_continuity.pl` | Duplicate real pension-payment detection |
| `test_creative_sessions.pl` | Accelerated work-session construction |
| `test_visibility.pl` | Simulation-only invisibility mode |
| `test_health_simulation.pl` | Wellness feature and blocked medical claim |
| `test_ethics.pl` | Blocking literal time travel and prohibited operations |
| `test_reality_dashboard.pl` | Real and simulated dashboard context |
| `test_consent.pl` | Consent validation |
| `test_persistence.pl` | Basic save/load round trip |
| `test_scenarios.pl` | Demo scenario execution |

These are focused prototype tests, not exhaustive acceptance tests. The following modules currently have no dedicated tests: `artefact_generator`, `audit_log`, `avatar_body_model`, `character_transport`, `compliance`, `narrative_continuity`, `perspective_offsets`, `reporting`, and `separation_mode`.

## Remaining work

The highest-priority gaps against `pr1.txt` are:

1. **Scheduling correctness:** validate appointment shapes, detect overlapping physical commitments, require permission before moving another participant's appointment, model safe windows/rest constraints, and verify movable work placement against real fixed events.
2. **Real-action approval:** replace the current `promote_to_real_action/3` identifier conversion with a persisted request/review/approval/execution lifecycle. No external actions are currently executed.
3. **Publication safety and artefact provenance:** make `publication_check/2` inspect content and metadata for unsupported claims, false testimonials/endorsements, privacy, and other listed risks. It currently returns success without performing those checks.
4. **Consent enforcement:** connect consent expiry, allowed uses, and revocation to avatar creation, character transport, appointment changes, recording, sharing, and publication.
5. **Auditability:** assign audit IDs and record all required state changes, approvals, branches, consent, and label changes. `audit_log` is not currently wired across the application.
6. **Persistence safety:** add atomic writes, schema validation/migration, and tests for malformed or unsupported input; current persistence is a basic term round trip.
7. **Separation mode and REPL:** show real obligations prominently, disable immersive effects, pause actual bot activity, and make commands execute through validated state transitions. Current REPL only parses and prints a small set of commands.
8. **Reports and dashboard completeness:** cover real/simulated completion, provisional assumptions, finances, fictional/real people, and pending approvals consistently.
9. **Specification-wide tests:** add missing tests for artefact provenance/publication, audit coverage, all prohibited operations, separation behavior, persistence failure cases, and the complete required scenario.
10. **Remaining scenario features:** complete accessible-source/holiday workflows, shared-home rules, thoughts/words/deeds boundaries, simulated support-goal behavior, and the other detailed constraints in `pr1.txt`.

Until these gaps are closed, the acceptance criteria in `pr1.txt` should be treated as a roadmap, not a claim that the prototype is production-ready. In particular, do not rely on it for real-world approvals, publication screening, consent enforcement, official records, health advice, or financial actions.
