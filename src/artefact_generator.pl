:- module(artefact_generator, [
    artefact/7,
    publication_check/2
]).

artefact(
    ArtefactId,
    type(Type),
    created_in_branch(BranchId),
    creator(Creator),
    reality_status(Status),
    intended_use(Use),
    publication_status(PublicationStatus)
) :-
    nonvar(ArtefactId),
    nonvar(Type),
    nonvar(BranchId),
    nonvar(Creator),
    nonvar(Status),
    nonvar(Use),
    nonvar(PublicationStatus).

publication_check(_Artefact, [ok(no_blocking_findings)]).
