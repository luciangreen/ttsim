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

## Key safety constraints

1. No literal time travel, teleportation, biological replacement, or immortality claims.
2. No representation of real people without consent.
3. No simulation output is treated as real-world execution.
4. Real-world actions require explicit approval (`promote_to_real_action/3`).
