:- module(pension_model, [
    financial_status/1,
    validate_pension_resource/1
]).

financial_status(real_verified).
financial_status(real_user_supplied).
financial_status(simulated).
financial_status(projected).

validate_pension_resource(financial_resource(_, type(pension), amount(_), frequency(_), status(Status))) :-
    financial_status(Status),
    !.
validate_pension_resource(Resource) :-
    throw(error(invalid_pension_resource(Resource), pension_model/1)).
