:- module(visibility_modes, [
    visibility_mode/2
]).

visibility_mode(UserId, hidden_from_simulated_characters(UserId)).
