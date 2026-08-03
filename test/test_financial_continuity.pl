:- begin_tests(financial_continuity).

:- use_module('../src/financial_continuity').

test(duplicate_real_payment_blocked) :-
    Records = [
        financial_resource(payment_001, type(pension), amount(10), frequency(monthly), status(real_verified)),
        financial_resource(payment_001, type(pension), amount(10), frequency(monthly), status(real_verified))
    ],
    financial_continuity:validate_financial_continuity(Records, Findings),
    member(blocking(duplicate_real_payment(payment_001)), Findings).

:- end_tests(financial_continuity).
