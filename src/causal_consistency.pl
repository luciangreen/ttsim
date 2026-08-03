:- module(causal_consistency, [
    depends_on/2,
    causes/2,
    conflicts_with/2,
    check_temporal_consistency/2
]).

:- dynamic depends_on/2.
:- dynamic causes/2.
:- dynamic conflicts_with/2.

check_temporal_consistency(BranchId, Findings) :-
    findall(conflict(A, B), conflicts_with(A, B), ConflictFindings),
    findall(missing_cause(A, B), (depends_on(A, B), \+ causes(B, A)), MissingFindings),
    append(ConflictFindings, MissingFindings, Raw),
    ( Raw == [] ->
        Findings = [ok(branch_consistent(BranchId))]
    ;   Findings = Raw
    ).
