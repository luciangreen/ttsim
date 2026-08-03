:- module(reporting, [
    real_schedule_report/2,
    simulation_schedule_report/2,
    branch_comparison_report/3,
    reality_separation_report/2,
    deferred_completion_report/2,
    financial_continuity_report/2,
    unverified_assumptions_report/2,
    ethical_findings_report/2
]).

real_schedule_report(temporal_plan(real_schedule(Real), _, _, _, _, _), report(real_completed, Real)).
simulation_schedule_report(temporal_plan(_, simulated_schedule(Sim), _, _, _, _), report(simulated_completed, Sim)).
branch_comparison_report(BranchA, BranchB, report(branches(BranchA, BranchB), status(compared))).
reality_separation_report(State, report(separation_mode, State.separation_mode)).
deferred_completion_report(State, report(deferred_completions, State.deferred_completions)).
financial_continuity_report(Findings, report(financial_truth, Findings)).
unverified_assumptions_report(Assumptions, report(awaiting_verification, Assumptions)).
ethical_findings_report(Findings, report(ethical_findings, Findings)).
