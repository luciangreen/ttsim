:- begin_tests(bots).

:- use_module('../src/bot_controller').

test(permission_enforced) :-
    Bot = bot(
        helper,
        role(scheduler),
        permissions([analyse_schedule]),
        prohibited_actions([publish])
    ),
    bot_controller:can_bot_perform(Bot, analyse_schedule),
    \+ bot_controller:can_bot_perform(Bot, publish).

:- end_tests(bots).
