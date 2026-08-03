:- module(highlight_selector, [
    select_highlights/3
]).

select_highlights(Timeline, SelectionCriteria, Highlights) :-
    include(matches_criteria(SelectionCriteria), Timeline, Highlights).

matches_criteria(Criteria, timeline_event(_, Tag, _)) :-
    memberchk(Tag, Criteria),
    !.
matches_criteria(_, timeline_segment(_, importance(high), _, _, _)).
