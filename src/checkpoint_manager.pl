:- module(checkpoint_manager, [
    create_checkpoint/4,
    return_to_checkpoint/4
]).

:- use_module(state_store).

create_checkpoint(SimulationId, Label, State0, State) :-
    new_id(checkpoint, CheckpointId),
    get_time(Now),
    Entry = checkpoint(
        CheckpointId,
        label(Label),
        created_at(Now)
    ),
    append(State0.checkpoints, [Entry], Checkpoints),
    State = State0.put(_{
        checkpoints: Checkpoints,
        last_checkpoint_id: CheckpointId
    }),
    put_state(SimulationId, State).

return_to_checkpoint(SimulationId, CheckpointId, State0, State) :-
    memberchk(checkpoint(CheckpointId, _, _), State0.checkpoints),
    !,
    new_id(branch, BranchId),
    get_time(Now),
    Branch = timeline_branch(
        BranchId,
        parent_branch(State0.active_branch),
        origin_checkpoint(CheckpointId),
        created_at(Now),
        status(active)
    ),
    append(State0.branches, [Branch], Branches),
    State = State0.put(_{
        branches: Branches,
        active_branch: BranchId
    }),
    put_state(SimulationId, State).
return_to_checkpoint(_, CheckpointId, _, _) :-
    throw(error(unknown_checkpoint(CheckpointId), checkpoint_manager/4)).
