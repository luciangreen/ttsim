:- module(appointment_model, [
    appointment_class/1,
    classify_appointment/2,
    priority_order/1,
    non_movable/1
]).

appointment_class(non_movable).
appointment_class(high_priority).
appointment_class(movable).
appointment_class(optional).
appointment_class(simulation_only).

priority_order([
    emergency,
    legal_obligation,
    health_and_safety,
    university_exam,
    university_class,
    employment,
    appointment_with_others,
    financial_deadline,
    personal_commitment,
    creative_work,
    recreation,
    simulation_only
]).

classify_appointment(appointment(_, _, _, _, class(Class), _, _, _), Class) :-
    appointment_class(Class),
    !.
classify_appointment(appointment(_, _, _, class(Class)), Class) :-
    appointment_class(Class),
    !.
classify_appointment(Appointment, non_movable) :-
    Appointment =.. [_|Args],
    member(title(Title), Args),
    downcase_atom(Title, Lower),
    ( sub_atom(Lower, _, _, _, 'university')
    ; sub_atom(Lower, _, _, _, 'exam')
    ; sub_atom(Lower, _, _, _, 'medical')
    ; sub_atom(Lower, _, _, _, 'legal')
    ),
    !.
classify_appointment(_, movable).

non_movable(appointment(_, _, _, _, class(non_movable), _, _, _)).
non_movable(appointment(_, _, _, class(non_movable))).
