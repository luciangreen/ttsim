:- begin_tests(characters).

:- use_module('../src/character_transport').

test(simulated_transport_mode_labelled) :-
    character_transport:transport_character(c1, scene_a, scene_b, simulated_teleport, Result),
    Result = transport_result(character(c1), from(scene_a), to(scene_b), mode(simulated_teleport), disclosure(simulated_only)).

:- end_tests(characters).
