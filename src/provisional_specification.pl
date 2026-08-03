:- module(provisional_specification, [
    approximation_policy/4,
    construct_provisional_spec/4
]).

approximation_policy(
    inaccessible_source,
    generate_provisional_specification,
    require_label(provisional),
    require_later_review(true)
).

construct_provisional_spec(KnownFacts, Assumptions, Specification, UncertaintyReport) :-
    Specification = provisional_specification(
        facts(KnownFacts),
        assumptions(Assumptions),
        label(provisional),
        requires_review(true)
    ),
    UncertaintyReport = uncertainty_report(
        assumption_count(Count),
        missing_inputs_detected(Missing)
    ),
    length(Assumptions, Count),
    ( member(missing_input(_), Assumptions) -> Missing = true ; Missing = false ).
