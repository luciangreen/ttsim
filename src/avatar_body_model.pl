:- module(avatar_body_model, [
    replace_avatar_body/3
]).

:- use_module(state_store).

replace_avatar_body(CharacterId, AvatarSpecification, NewAvatarId) :-
    nonvar(CharacterId),
    nonvar(AvatarSpecification),
    new_id(avatar, NewAvatarId).
