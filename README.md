# ttsim

Real Time Travel Simulation in **SWI-Prolog**.

This project implements a simulation framework for replaying and branching schedule scenarios while preserving:

1. real chronology,
2. consent,
3. legal/ethical boundaries,
4. clear reality labels (`real`, `scheduled`, `simulated`, `fictional`, `projected`, `provisional`).

## Quick start

```bash
swipl -q -s src/real_time_travel_simulation.pl -g run_demo -t halt
```

## Run tests

```bash
swipl -q -s test/run_tests.pl
```

## Example commands

All examples below can be run from an interactive SWI-Prolog session after loading the main module:

```bash
swipl -s src/real_time_travel_simulation.pl
```

### Create a new simulation

```prolog
?- new_time_simulation(
       simulation_spec(
           name('My Project'),
           timezone('Australia/Melbourne'),
           reality_labelling(always_visible)
       ),
       SimId).
% SimId = simulation_000001
```

### Import calendar appointments

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
% Count = 1
```

### Create a movable task

```prolog
?- create_task(SimId,
       task('Draft report', duration_hours(4), movable(true)),
       TaskId).
% TaskId = task_000001
```

### Build a temporal plan

```prolog
?- get_state(SimId, S),
   build_temporal_plan(
       S.appointments,
       [task(draft_report, duration_hours(4), movable(true))],
       [simulate_days(2)],
       [],
       Plan, Findings).
% Plan = temporal_plan(...)
% Findings = [...]
```

### Create a checkpoint and branch

```prolog
?- create_checkpoint(SimId, 'Before experiment', CpId).
% CpId = checkpoint_000001

?- return_to_checkpoint(SimId, CpId, BranchId).
% BranchId = branch_000002
```

### Streamline a timeline

```prolog
?- streamline_timeline(
       Plan,
       [preserve(non_movable)],
       Streamlined, Removed).
```

### View the reality dashboard

```prolog
?- reality_dashboard(SimId, Dashboard).
% Dashboard = reality_dashboard(...)
```

### Promote a simulated action to real

```prolog
?- promote_to_real_action(sim_action_001, approved, RealId).
% RealId = real_action_sim_action_001
```

### Run an ethical check

```prolog
?- ethical_check(simulate_timeline_branch, Findings).
% Findings = [ethical_check(simulate_timeline_branch, approved, [])]
```

### Save and load simulation state

```prolog
?- save_simulation(SimId, '/tmp/my_sim.pl').

?- load_simulation('/tmp/my_sim.pl', RestoredId).
```

### Interactive REPL

```bash
swipl -q -s src/real_time_travel_simulation.pl -g start_repl -t halt
```

```
time-sim> new simulation "My Project"
Parsed command: new_simulation("My Project")
time-sim> reality
Parsed command: reality_dashboard
time-sim> quit
Goodbye.
```

## Key safety constraints

1. No literal time travel, teleportation, biological replacement, or immortality claims.
2. No representation of real people without consent.
3. No simulation output is treated as real-world execution.
4. Real-world actions require explicit approval (`promote_to_real_action/3`).
