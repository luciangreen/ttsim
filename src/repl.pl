:- module(repl, [
    start_repl/0
]).

:- use_module(command_parser).

start_repl :-
    writeln('time-sim REPL. Type "quit" to exit.'),
    repeat,
    write('time-sim> '),
    read_line_to_string(user_input, Input),
    ( Input == "quit" ->
        writeln('Goodbye.'), !
    ; command_parser:parse_command(Input, Command) ->
        format('Parsed command: ~q~n', [Command]),
        fail
    ; writeln('Unknown command.'),
      fail
    ).
