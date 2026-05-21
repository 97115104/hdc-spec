# Contributing to AIISP

Thank you for taking the time to comment on the AIISP standards family. This repository is published for open review, and substantive feedback is the primary input that will shape later drafts.

The active draft is **AIISP-2: Contributor-Aligned Inference Routing and Settlement Protocol**. AIISP-1 remains available as a historical and provider-facing draft.

This repository has four contribution surfaces:

- normative specifications in `spec/`;
- schemas in `spec/schemas/`;
- examples in `examples/`;
- non-normative companion papers in `paper/v1/` and `paper/v2/`.

---

## Contributing to the specs

### 1. File a structured issue

Open a new issue using one of the templates:

- **Comment** - a specific objection, question, or suggestion against a numbered section of a spec.
- **Amendment** - a proposal for a new feature, header, event type, schema field, or behavior.
- **Errata** - a typo, broken link, arithmetic error, or factual mistake in a published draft.

### 2. Submit a pull request

For textual changes, open a pull request against the relevant file:

- AIISP-2 active draft: [`spec/aiisp-2.md`](./spec/aiisp-2.md)
- AIISP-1 historical/provider-facing draft: [`spec/aiisp-1.md`](./spec/aiisp-1.md)

Pull requests should:

- touch only one logical change per PR, except batched typo fixes;
- include a short rationale in the PR description;
- identify whether the change is editorial or substantive;
- update the revision history if the change is substantive;
- preserve RFC 2119 keyword use in normative sections.

AIISP-2 amendments must preserve the event-based HDCT issuance invariant unless the proposal explicitly supersedes AIISP-2. A recorded event cannot be reminted, and AIISP-2 must not reintroduce recurring royalty mechanics for prior data use.

---

## Contributing schemas and examples

AIISP-2 schemas live in [`spec/schemas/aiisp-2/`](./spec/schemas/aiisp-2/). Examples live in [`examples/aiisp-2/`](./examples/aiisp-2/).

Schema and example pull requests should:

- update both schema and example files when a field changes;
- keep examples free of raw prompts, completions, private contributor data, secrets, and real wallet keys unless the example is explicitly public test data;
- use decimal strings for token, environmental, and settlement quantities where the schema requires fixed precision;
- explain any backward-incompatible change.

---

## Contributing to the companion papers

The Human Data Collective papers are non-normative motivation documents:

- [HDC v1 paper folder](./paper/v1/) contains the HDC v1 paper.
- [HDC v2 paper folder](./paper/v2/) contains the HDC v2 paper.

Edit the Markdown files for prose changes. PDF refreshes should be reviewed as generated artifacts and kept in sync with the Markdown source.

---

## What "substantive" means

A change is substantive if it would alter the behavior of a conformant implementation. Substantive changes require either:

- public issue discussion with no unresolved objections from the editor; or
- a pull request approved by the editor with a public rationale.

Non-substantive changes such as typos, formatting, broken links, and citation polish can be merged on sight.

## Review timeline

The editor commits to acknowledging every issue and pull request within 14 days. A response is not the same as a merge or a closed issue; some discussions will remain open while the design space is explored.

## Provenance and attestation

Accepted substantive changes may be attested under the [`attest` v3](https://attest.97115104.com) specification and recorded in the relevant spec revision history. By contributing you agree that your contribution may be redistributed under the spec's [CC BY 4.0](./LICENSE) license and that your name and contribution may be recorded in the public attestation chain.

## Code of conduct

This project follows the [Contributor Covenant v2.1](./CODE_OF_CONDUCT.md). Participation in any project channel constitutes agreement to the Code of Conduct.

## Conflicts of interest

If you are an employee, contractor, or paid representative of any party that would be affected by this standards family, including inference providers, router operators, cloud operators, carbon or water credit registries, labor platforms, contributor organizations, or node operators, please disclose that affiliation in your first comment on any thread. Disclosure does not disqualify a contribution; non-disclosure does.

## Contact

For private comments or for issues that should not be discussed in public, contact the editor at `x@97115104.com`.
