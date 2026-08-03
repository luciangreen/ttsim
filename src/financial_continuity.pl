:- module(financial_continuity, [
    validate_financial_continuity/2
]).

validate_financial_continuity(FinancialRecords, Findings) :-
    findall(
        blocking(duplicate_real_payment(PaymentId)),
        duplicate_real_payment(PaymentId, FinancialRecords),
        Duplicates
    ),
    ( Duplicates == [] ->
        Findings = [ok(financial_continuity_preserved)]
    ;   Findings = Duplicates
    ).

duplicate_real_payment(PaymentId, FinancialRecords) :-
    include(=(financial_resource(PaymentId, type(pension), _, _, status(real_verified))), FinancialRecords, Matches),
    length(Matches, Count),
    Count > 1.
