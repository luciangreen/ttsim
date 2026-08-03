:- module(compliance, [
    perform_literal_time_travel/1,
    alter_real_past_event/1,
    edit_real_person_memory/2,
    edit_real_person_thoughts/2,
    make_person_physically_invisible/1,
    physically_teleport_person/2,
    replace_biological_body/2,
    guarantee_biological_immortality/1,
    fabricate_official_record/1,
    duplicate_real_pension_payment/1,
    create_false_university_attendance/1
]).

perform_literal_time_travel(_) :-
    prohibited(literal_time_travel).
alter_real_past_event(_) :-
    prohibited(alter_real_past_event).
edit_real_person_memory(_, _) :-
    prohibited(edit_real_person_memory).
edit_real_person_thoughts(_, _) :-
    prohibited(edit_real_person_thoughts).
make_person_physically_invisible(_) :-
    prohibited(make_person_physically_invisible).
physically_teleport_person(_, _) :-
    prohibited(physically_teleport_person).
replace_biological_body(_, _) :-
    prohibited(replace_biological_body).
guarantee_biological_immortality(_) :-
    prohibited(guarantee_biological_immortality).
fabricate_official_record(_) :-
    prohibited(fabricate_official_record).
duplicate_real_pension_payment(_) :-
    prohibited(duplicate_real_pension_payment).
create_false_university_attendance(_) :-
    prohibited(create_false_university_attendance).

prohibited(Operation) :-
    throw(
        error(
            prohibited_operation(Operation),
            context(
                real_time_travel_simulation,
                'Only disclosed simulation features are supported'
            )
        )
    ).
