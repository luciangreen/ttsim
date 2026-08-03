:- module(bot_controller, [
    bot/4,
    can_bot_perform/2
]).

bot(BotId, role(Role), permissions(Permissions), prohibited_actions(ProhibitedActions)) :-
    atom(BotId),
    atom(Role),
    is_list(Permissions),
    is_list(ProhibitedActions).

can_bot_perform(bot(_, _, permissions(Permissions), prohibited_actions(Prohibited)), Action) :-
    memberchk(Action, Permissions),
    \+ memberchk(Action, Prohibited).
