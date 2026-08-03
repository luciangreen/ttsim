:- begin_tests(health_simulation).

:- use_module('../src/health_simulation').

test(wellness_feature_allowed) :-
    health_simulation:supported_health_feature(rest_scheduling).

test(medical_promise_blocked) :-
    health_simulation:blocked_health_claim(promise_medical_outcome).

:- end_tests(health_simulation).
