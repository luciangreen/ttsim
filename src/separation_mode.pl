:- module(separation_mode, [
    enter_separation_mode/2
]).

enter_separation_mode(State0, State) :-
    State = State0.put(_{
        separation_mode: separation_mode(
            State0.id,
            paused,
            reason(user_requested)
        ),
        bots_paused: true
    }).
