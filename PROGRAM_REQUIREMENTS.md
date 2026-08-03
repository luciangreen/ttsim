# PROGRAM REQUIREMENTS

Primary language: **SWI-Prolog**

This implementation delivers the 58-section `pr1.txt` specification as a coherent codebase with:

1. modular source layout (`src/`),
2. test suite (`test/` with PlUnit),
3. CI workflow (`.github/workflows/ci.yml`),
4. reality/simulation separation and compliance protections.

## Implemented capability groups

1. **Reality and time model**: layered reality model, clock modes, dashboard projection.
2. **Scheduling**: appointment classes, non-movable priority, movable task mapping, temporal plan generation.
3. **Timeline branching**: checkpoint creation, return-to-checkpoint branch creation, branch comparison.
4. **Streamlining**: timeline compression preserving protected segments.
5. **Characters and transport**: typed characters, simulated-only transport modes.
6. **Life and continuity**: life profiles, simulated mornings, identity continuity records.
7. **Provisional specs**: inaccessible-source policy with assumptions and uncertainty report.
8. **Financial continuity**: pension status model and duplicate real-payment detection.
9. **Creative/highlight modes**: accelerated sessions, highlight selection, separation mode.
10. **Health/avatar/narrative**: supported wellness-only features, avatar-only body replacement, narrative continuity types.
11. **Ethics and compliance**: blocked operations, prohibited predicates throwing structured exceptions.
12. **Persistence and REPL**: save/load state, command parser, interactive prompt.

## Public API

The public API is exposed by `src/real_time_travel_simulation.pl`:

- `new_time_simulation/2`
- `import_appointments/3`
- `create_task/3`
- `classify_appointment/3`
- `build_temporal_plan/6`
- `create_checkpoint/3`
- `return_to_checkpoint/3`
- `compare_branches/4`
- `streamline_timeline/4`
- `create_life_profile/3`
- `try_life/5`
- `begin_simulated_morning/4`
- `create_accelerated_work_session/5`
- `select_highlights/3`
- `enter_separation_mode/2`
- `reality_dashboard/2`
- `promote_to_real_action/3`
- `ethical_check/2`
- `save_simulation/2`
- `load_simulation/2`
- `start_repl/0`

## Demonstration

`run_demo/0` creates a simulation, imports university appointments, builds a plan, branches from a checkpoint, checks consistency, and prints a dashboard while preserving simulation-vs-reality separation.

## Compliance boundary

Terms like time travel, invisibility, body replacement, and immortality are implemented as simulation/narrative abstractions only. Literal physical interpretations are explicitly blocked by `src/compliance.pl`.
