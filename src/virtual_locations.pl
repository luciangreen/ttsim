:- module(virtual_locations, [
    begin_simulated_morning/4,
    reskin_environment/4
]).

begin_simulated_morning(LifeId, HomeId, Date, scene(LifeId, HomeId, morning, Date)).

reskin_environment(PhysicalHost, VirtualAppearance, DisclosureMode, environment(
    host(PhysicalHost),
    appearance(VirtualAppearance),
    disclosure(DisclosureMode)
)).
