# Governance of the HDC Standards Family

This document describes how decisions are made about the HDC family of specifications, including HDC-1 and any future HDC-N drafts published in this repository.

## Status

HDC is, at the time of writing, an **editor-driven** standards effort. The editor (Austin Harshberger, `x@97115104.com`) is the sole decision-maker of last resort for HDC-1 v0.1. This is the same model under which the early IETF RFCs were edited (Jon Postel for RFC 791 and many of the foundational documents) and is appropriate for the pre-ratification stage of any new standard.

The editor commits to migrating governance to a multi-stakeholder body before HDC-1 is ratified to v1.0, with seats reserved for at least the following constituencies:

- A worker organization or labour-research institution representing data contributors.
- An environmental organization representing communities affected by data-center water and energy use.
- An implementer representative from at least one frontier inference provider.
- An implementer representative from the open-source model community.
- An academic representative from the AI policy or computational linguistics research community.
- The editor.

The composition of the multi-stakeholder body and the procedure by which seats are filled will be specified in **HDC-3: Governance**, currently a stub.

## Decision-making for HDC-1 v0.x drafts

While the standard is in `v0.x` draft status, the editor has final authority over text changes. The editor commits to:

1. Acknowledge every issue and pull request within 14 days.
2. Publish a written rationale for every rejected substantive change.
3. Maintain a public revision history in the spec's Appendix B.
4. Solicit at least one round of public review before each minor version increment (v0.1 → v0.2, etc.).
5. Not increment to v1.0 (ratification candidate) without the multi-stakeholder body in place.

## Versioning

This repository follows semantic-version-style numbering for the spec:

- **v0.x** — pre-ratification draft. Breaking changes to wire format permitted between minor versions.
- **v1.0** — first ratification candidate. Requires multi-stakeholder body sign-off.
- **v1.x** — stable spec. Backward-compatible changes only.
- **v2.0** — wire-format-breaking revision. Requires a new ratification round.

Each version is tagged in git as `vMAJOR.MINOR` (e.g. `v0.1`).

## Forking

The specification text is licensed under [CC BY 4.0](./LICENSE-SPEC), which means any party may fork this repository and publish a competing or derivative standard. The editor encourages competing proposals as a healthy part of the design process and will link to substantive forks from this README.

## Conflicts of interest

The editor is the founder of Happy Stack Calculus LLC, which intends to operate the reference implementation of the HDC settlement contract on Base as a public-benefit company. This is a direct material interest in the standard's adoption. The editor commits to:

- Disclosing the conflict on every public communication about the standard.
- Recusing from any decision in which the operator's commercial interests diverge from the contributors' interests, to be adjudicated by the multi-stakeholder body once seated.
- Publishing the operating company's compensation alongside contributor compensation on the same on-chain ledger described in HDC-1 Section 6.

## Amendment procedure

Substantive amendments to a published version proceed as follows:

1. **Issue.** The proposer opens an issue using the Amendment template, describing the problem and the proposed change.
2. **Discussion.** The issue remains open for a minimum of 14 days for public comment.
3. **Pull request.** If the discussion converges, the proposer (or the editor) opens a PR with the textual change and updates the revision history.
4. **Review.** The editor reviews the PR and either merges it, requests changes, or rejects it with public rationale.
5. **Release.** Merged amendments are bundled into the next minor version release.

## Forking the family namespace

HDC-N numbers (HDC-1, HDC-2, HDC-3, …) are assigned by the editor on a first-come basis through an Amendment-template issue. The editor will not assign a number to a specification that materially conflicts with a currently published HDC-N spec without first deprecating the conflicting spec through the standard amendment procedure.
