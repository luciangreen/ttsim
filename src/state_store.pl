:- module(state_store, [
    reset_store/0,
    new_id/2,
    put_state/2,
    get_state/2,
    update_state/3
]).

:- dynamic simulation_state/2.
:- dynamic id_counter/2.
:- meta_predicate update_state(+, 2, -).

reset_store :-
    retractall(simulation_state(_, _)),
    retractall(id_counter(_, _)).

new_id(Prefix, Id) :-
    with_mutex(ttsim_id_lock, next_id(Prefix, N)),
    format(atom(Id), '~w_~|~`0t~d~6+', [Prefix, N]).

next_id(Prefix, N) :-
    ( retract(id_counter(Prefix, Prev)) ->
        N is Prev + 1
    ;   N = 1
    ),
    assertz(id_counter(Prefix, N)).

put_state(SimulationId, State) :-
    retractall(simulation_state(SimulationId, _)),
    assertz(simulation_state(SimulationId, State)).

get_state(SimulationId, State) :-
    simulation_state(SimulationId, State),
    !.
get_state(SimulationId, _) :-
    throw(error(unknown_simulation(SimulationId), state_store/2)).

update_state(SimulationId, Updater, NewState) :-
    get_state(SimulationId, State0),
    call(Updater, State0, NewState),
    put_state(SimulationId, NewState).
