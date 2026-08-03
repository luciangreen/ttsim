:- module(audit_log, [
    append_audit_entry/4
]).

append_audit_entry(State0, Actor, Operation, State) :-
    get_time(Now),
    Entry = audit_entry(
        _,
        real_timestamp(Now),
        simulated_timestamp(State0.reality_context.simulated_date),
        branch(State0.active_branch),
        actor(Actor),
        operation(Operation),
        outcome(recorded)
    ),
    append(State0.audit_log, [Entry], Entries),
    State = State0.put(_{audit_log: Entries}).
