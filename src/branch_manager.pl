:- module(branch_manager, [
    compare_branches/4
]).

compare_branches(BranchA, BranchB, Differences, OutcomeComparison) :-
    ( BranchA == BranchB ->
        Differences = [],
        OutcomeComparison = equivalent
    ;   Differences = [different_branch_ids(BranchA, BranchB)],
        OutcomeComparison = diverged
    ).
