:- module(timeline_streamliner, [
    streamline_timeline/4
]).

streamline_timeline(Timeline, _Objectives, StreamlinedTimeline, RemovedSegments) :-
    partition(protected_segment, Timeline, Protected, Candidate),
    partition(keep_segment, Candidate, Kept, RemovedSegments),
    append(Protected, Kept, StreamlinedTimeline).

protected_segment(timeline_segment(_, _, _, result(_), skippable(false))).
protected_segment(timeline_segment(_, importance(critical), _, _, _)).
protected_segment(timeline_segment(_, _, dependencies(consent_decision), _, _)).
protected_segment(timeline_segment(_, _, dependencies(payment_record), _, _)).

keep_segment(timeline_segment(_, importance(high), _, _, _)).
keep_segment(timeline_segment(_, _, _, result(decision_point), _)).
