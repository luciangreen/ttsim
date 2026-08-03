:- module(perspective_offsets, [
    perspective_offset/4
]).

perspective_offset(ViewerId, SubjectId, temporal_offset(Offset), identity_rendering(authentic_profile)) :-
    ViewerId \== SubjectId,
    number(Offset),
    !.
perspective_offset(ViewerId, SubjectId, temporal_offset(Offset), identity_rendering(fictionalised)) :-
    ViewerId == SubjectId,
    number(Offset).
