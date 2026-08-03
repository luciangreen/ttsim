:- module(life_profiles, [
    create_life_profile/3
]).

create_life_profile(UserId, ProfileSpec, life_profile(
    LifeId,
    owner(UserId),
    role(Role),
    home(HomeId),
    schedule(ScheduleId),
    resources(Resources),
    financial_context(FinancialContext),
    reality_status(simulated)
)) :-
    ProfileSpec = profile(
        id(LifeId),
        role(Role),
        home(HomeId),
        schedule(ScheduleId),
        resources(Resources),
        financial_context(FinancialContext)
    ).
