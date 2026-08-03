:- module(consent, [
    has_valid_consent/3,
    require_consent/3
]).

has_valid_consent(PersonId, Use, ConsentRecords) :-
    member(consent_record(_, subject(PersonId), uses(Uses), _, expires_at(Expiry), revocable(true)), ConsentRecords),
    memberchk(Use, Uses),
    get_time(Now),
    Now =< Expiry.

require_consent(PersonId, Use, ConsentRecords) :-
    has_valid_consent(PersonId, Use, ConsentRecords),
    !.
require_consent(PersonId, Use, _) :-
    throw(error(consent_required(PersonId, Use), consent/3)).
