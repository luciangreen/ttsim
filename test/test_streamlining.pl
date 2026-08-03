:- begin_tests(streamlining).

:- use_module('../src/timeline_streamliner').

test(protected_events_retained) :-
    Timeline = [
        timeline_segment(s1, importance(low), dependencies(none), result(routine), skippable(true)),
        timeline_segment(s2, importance(critical), dependencies(consent_decision), result(decision_point), skippable(false))
    ],
    timeline_streamliner:streamline_timeline(Timeline, [], Streamlined, Removed),
    member(timeline_segment(s2, _, _, _, _), Streamlined),
    member(timeline_segment(s1, _, _, _, _), Removed).

:- end_tests(streamlining).
