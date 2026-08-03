:- begin_tests(consent).

:- use_module('../src/consent').

test(valid_consent) :-
    get_time(Now),
    Expiry is Now + 3600,
    Records = [
        consent_record(c1, subject(person_1), uses([avatar_representation]), granted_at(Now), expires_at(Expiry), revocable(true))
    ],
    consent:has_valid_consent(person_1, avatar_representation, Records).

:- end_tests(consent).
