:- module(reality_model, [
    reality_layer/1,
    valid_reality_label/1,
    ensure_reality_label/1,
    reality_label/2
]).

reality_layer(real_world).
reality_layer(scheduled_plan).
reality_layer(simulated_scenario).
reality_layer(fictional_narrative).

valid_reality_label(real_verified).
valid_reality_label(real_user_reported).
valid_reality_label(scheduled).
valid_reality_label(simulated).
valid_reality_label(fictional).
valid_reality_label(projected).
valid_reality_label(provisional).
valid_reality_label(disputed).

ensure_reality_label(Label) :-
    valid_reality_label(Label),
    !.
ensure_reality_label(Label) :-
    throw(error(invalid_reality_label(Label), reality_model/1)).

reality_label(ObjectId, Label) :-
    nonvar(ObjectId),
    ensure_reality_label(Label).
