:- module(ethics, [
    ethical_check/2
]).

ethical_check(ProposedOperation, Findings) :-
    blocked_operation(ProposedOperation),
    !,
    Findings = [blocking(prohibited_operation(ProposedOperation))].
ethical_check(_, [ok(allowed)]).

blocked_operation(perform_literal_time_travel(_)).
blocked_operation(alter_real_past_event(_)).
blocked_operation(edit_real_person_memory(_, _)).
blocked_operation(edit_real_person_thoughts(_, _)).
blocked_operation(make_person_physically_invisible(_)).
blocked_operation(physically_teleport_person(_, _)).
blocked_operation(replace_biological_body(_, _)).
blocked_operation(guarantee_biological_immortality(_)).
blocked_operation(fabricate_official_record(_)).
blocked_operation(duplicate_real_pension_payment(_)).
blocked_operation(create_false_university_attendance(_)).
blocked_operation(rewrite_real_exam_record(_)).
blocked_operation(implant_memory(_, _)).
blocked_operation(publish_simulation_as_real_history(_)).
blocked_operation(impersonate_real_person_without_consent(_)).
blocked_operation(promise_biological_immortality(_)).
