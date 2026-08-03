:- module(persistence, [
    save_simulation/2,
    load_simulation/2
]).

:- use_module(state_store).

save_simulation(SimulationId, Path) :-
    get_state(SimulationId, State),
    setup_call_cleanup(
        open(Path, write, Stream, [encoding(utf8)]),
        write_term(Stream, simulation_dump(version(1), State), [fullstop(true), nl(true)]),
        close(Stream)
    ).

load_simulation(Path, SimulationId) :-
    setup_call_cleanup(
        open(Path, read, Stream, [encoding(utf8)]),
        read_term(Stream, Term, [syntax_errors(error)]),
        close(Stream)
    ),
    Term = simulation_dump(version(_), State),
    new_id(simulation, SimulationId),
    put_state(SimulationId, State.put(_{id: SimulationId})).
