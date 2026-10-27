# ttsim

`ttsim` is a SWI-Prolog prototype for planning and exploring schedule scenarios. It keeps simulated timelines distinct from real schedules and includes small models for branching, fictional characters, life scenarios, and safety boundaries.

**Scope:** the repository does not yet implement every requirement in [`pr1.txt`](pr1.txt). Several modules are proof-of-concept term models; in particular, the publication checks, real-world action gateway, audit integration, and complete scheduler constraints remain unfinished. See [current coverage and remaining work](PROGRAM_REQUIREMENTS.md) before relying on a feature.

## Requirements and quick start

Install SWI-Prolog (on Debian or Ubuntu):

```bash
sudo apt-get update
sudo apt-get install swi-prolog-nox
```

Run the end-to-end demo:

```bash
swipl -q -s src/real_time_travel_simulation.pl -g run_demo -t halt
```

Run the full PlUnit suite from the repository root:

```bash
swipl -q -s test/run_tests.pl
```

Run one test file, for example:

```bash
swipl -q -s test/test_temporal_planner.pl -g run_tests -t halt
```

The suite currently covers the test files listed below. A green run verifies those tests only; it is not evidence that every requirement in `pr1.txt` is complete.

## Capability guide

| Capability | Current implementation | Tests |
|---|---|---|
| Reality labels, simulation clock, and dashboard | Basic labels, clock modes, and a dashboard term; the dashboard is not a complete user interface. | `test_reality_model.pl`, `test_simulation_clock.pl`, `test_reality_dashboard.pl` |
| Appointments, priorities, and temporal planning | Classifies events, preserves fixed events in the basic planner, and maps movable work into simulated/real schedule terms. Conflict detection and all scheduling constraints are not complete. | `test_appointments.pl`, `test_priority_scheduler.pl`, `test_temporal_planner.pl` |
| Checkpoints, branches, causal checks, and streamlining | Basic checkpoint/branch creation, comparison, consistency checks, and protected-segment streamlining. | `test_checkpoints.pl`, `test_branches.pl`, `test_causal_consistency.pl`, `test_streamlining.pl` |
| Characters, transport, bots, and consent | Provides character/transport terms, bot permission checks, and consent validation helpers. Consent is not enforced by every character, transport, or publication operation. | `test_characters.pl`, `test_bots.pl`, `test_consent.pl` |
| Life scenarios, identity, homes, creative sessions, highlights, and visibility | Provides small data models and helper predicates for these simulation-only concepts. | `test_life_profiles.pl`, `test_identity_continuity.pl`, `test_creative_sessions.pl`, `test_visibility.pl` |
| Health and avatar boundaries | Lists supported wellness scenarios and blocked medical claims; avatar replacement is a minimal identifier helper, not biological replacement. | `test_health_simulation.pl` |
| Provisional specifications | Labels assumptions as provisional and reports missing-input assumptions. Replacement and later verification workflows are not implemented. | `test_provisional_specs.pl` |
| Financial continuity | Detects repeated records matching the same verified pension-payment identifier. It is not a financial integration. | `test_financial_continuity.pl` |
| Ethics and prohibited operations | Blocks a defined set of literal/reality-altering operations through helper predicates. This is not a complete policy engine. | `test_ethics.pl` |
| Persistence | Saves and reloads a Prolog state term. Atomic writes, schema migration, and robust validation are still outstanding. | `test_persistence.pl` |
| Artefact provenance, publication, audit, and reports | Modules and term shapes exist, but publication review always reports success, audit is not wired throughout state changes, and reporting is basic. | No dedicated tests yet |
| REPL | Parses a small set of commands and displays the parsed term; it does not execute a complete command workflow. | Exercised indirectly by `test_scenarios.pl` only |

`test_scenarios.pl` exercises the demo path. The test runner loads all 23 current test files in `test/run_tests.pl`.

## Public API and examples

Load the main module in an interactive session:

```bash
swipl -s src/real_time_travel_simulation.pl
```

The facade exports these predicates:

- Simulation and scheduling: `new_time_simulation/2`, `import_appointments/3`, `create_task/3`, `classify_appointment/3`, `build_temporal_plan/6`.
- Branching and timeline: `create_checkpoint/3`, `return_to_checkpoint/3`, `compare_branches/4`, `streamline_timeline/4`.
- Scenario helpers: `create_life_profile/3`, `try_life/5`, `begin_simulated_morning/4`, `create_accelerated_work_session/5`, `select_highlights/3`.
- Reality and safety: `enter_separation_mode/2`, `reality_dashboard/2`, `promote_to_real_action/3`, `ethical_check/2`.
- Persistence and demo: `save_simulation/2`, `load_simulation/2`, `start_repl/0`, `run_demo/0`.

Create a simulation:

```prolog
?- new_time_simulation(
       simulation_spec(
           name('My Project'),
           timezone('Australia/Melbourne'),
           reality_labelling(always_visible)
       ),
       SimId).
```

Import a fixed appointment and create a movable task:

```prolog
?- import_appointments(SimId, [
       appointment(
           lecture_1,
           title('Monday lecture'),
           starts_at(datetime(2026,8,10,9,0,0)),
           ends_at(datetime(2026,8,10,11,0,0)),
           class(non_movable),
           source(calendar),
           location(campus),
           participants([user])
       )
   ], Count).

?- create_task(SimId,
       task('Draft report', duration_hours(4), movable(true)),
       TaskId).
```

Build a plan and inspect reality state:

```prolog
?- get_state(SimId, State),
   build_temporal_plan(
       State.appointments,
       [task(draft_report, duration_hours(4), movable(true))],
       [simulate_days(2)],
       [],
       Plan, Findings).

?- reality_dashboard(SimId, Dashboard).
```

Create a checkpoint and branch from it:

```prolog
?- create_checkpoint(SimId, 'Before experiment', CheckpointId).
?- return_to_checkpoint(SimId, CheckpointId, BranchId).
```

Run the small interactive parser:

```bash
swipl -q -s src/real_time_travel_simulation.pl -g start_repl -t halt
```

Supported REPL input is limited to `new simulation "Name"`, `reality`, `return to real view`, and `quit`. Parsed commands are displayed, not executed.

## Safety boundaries

- Time travel, teleportation, invisibility, body changes, and immortality are simulation or narrative concepts only; prohibited literal operations throw structured errors.
- A simulated result is not proof of a real event or completed task.
- Health helpers do not diagnose, treat, or promise medical outcomes.
- Consent and explicit approval are requirements of the design, but enforcement is incomplete; do not use this prototype to represent, contact, publish about, or take actions for real people.

See [`PROGRAM_REQUIREMENTS.md`](PROGRAM_REQUIREMENTS.md) for the module inventory, test map, and outstanding acceptance criteria.
