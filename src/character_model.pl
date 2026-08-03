:- module(character_model, [
    character_type/1,
    validate_character/2
]).

:- use_module(consent).

character_type(real_user_avatar).
character_type(consenting_real_person_avatar).
character_type(fictional_character).
character_type(simulation_agent).
character_type(role_template).

validate_character(character(_, type(Type), _, _, _, _, _), ConsentRecords) :-
    character_type(Type),
    ( Type == consenting_real_person_avatar ->
        consent:require_consent(subject_placeholder, avatar_representation, ConsentRecords)
    ; true
    ).
