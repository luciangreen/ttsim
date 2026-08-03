:- module(health_simulation, [
    supported_health_feature/1,
    blocked_health_claim/1
]).

supported_health_feature(rest_scheduling).
supported_health_feature(sleep_reminders).
supported_health_feature(activity_planning).
supported_health_feature(accessibility_modes).
supported_health_feature(simulated_rehabilitation_scenarios).
supported_health_feature(healthy_workload_limits).
supported_health_feature(fictional_body_avatar_changes).

blocked_health_claim(diagnose_condition).
blocked_health_claim(treat_condition).
blocked_health_claim(promise_medical_outcome).
