:- module(identity_continuity, [
    identity_continuity/7
]).

identity_continuity(
    UserId,
    LifeA,
    LifeB,
    shared_memory_scope(Scope),
    shared_assets(Assets),
    transition_policy(Policy),
    continuity_record(UserId, LifeA, LifeB, Scope, Assets, Policy)
).
