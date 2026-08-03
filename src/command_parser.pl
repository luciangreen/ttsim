:- module(command_parser, [
    parse_command/2
]).

parse_command(Text, new_simulation(Name)) :-
    string_lower(Text, Lower),
    sub_string(Lower, 0, _, _, "new simulation"),
    split_string(Text, "\"", "", Parts),
    nth1(2, Parts, Name),
    !.
parse_command("reality", reality_dashboard).
parse_command("return to real view", return_to_real_view).
