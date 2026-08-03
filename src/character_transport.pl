:- module(character_transport, [
    transport_mode/1,
    transport_character/5
]).

transport_mode(scene_cut).
transport_mode(fade_out_fade_in).
transport_mode(simulated_teleport).
transport_mode(bot_reassignment).
transport_mode(remote_avatar).
transport_mode(time_skip).

transport_character(CharacterId, FromScene, ToScene, TransportMode, Result) :-
    transport_mode(TransportMode),
    !,
    Result = transport_result(
        character(CharacterId),
        from(FromScene),
        to(ToScene),
        mode(TransportMode),
        disclosure(simulated_only)
    ).
transport_character(_, _, _, TransportMode, _) :-
    throw(error(invalid_transport_mode(TransportMode), character_transport/5)).
