:- module(reality_dashboard, [
    reality_dashboard/2
]).

reality_dashboard(State, Dashboard) :-
    Dashboard = reality_dashboard(
        real_timestamp(State.reality_context.real_timestamp),
        real_location(State.reality_context.real_location),
        next_real_appointment(State.reality_context.next_real_appointment),
        active_simulation(State.id),
        active_branch(State.active_branch),
        simulated_date(State.reality_context.simulated_date),
        reality_warnings(State.reality_context.reality_warnings),
        pending_real_actions(State.reality_context.pending_real_actions)
    ).
