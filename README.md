# AIISP-1: The Artificial Intelligence Inference Standards Protocol

[![Status: Draft](https://img.shields.io/badge/status-draft%20v0.1-orange)](./aiisp-1.md)
[![Spec License: CC BY 4.0](https://img.shields.io/badge/spec%20license-CC%20BY%204.0-blue)](./LICENSE-SPEC)
[![Code License: MIT](https://img.shields.io/badge/code%20license-MIT-green)](./LICENSE-CODE)
[![Discussion](https://img.shields.io/badge/discussion-open-brightgreen)](https://github.com/97115104/aiisp-spec/issues/1)

This repository hosts **AIISP-1**, the first specification in the **AIISP** family of internet standards. AIISP-1 defines a minimal, transport-agnostic, opt-in HTTP standard for declaring and settling the energy, environmental, and human-attribution components of a single Large Language Model inference request.

The standard is published in the spirit of the early IETF RFCs that defined TCP, IP, HTTP, and TLS, namely small, composable, opt-in, and owned by no single party.

## Read the spec

- **[aiisp-1.md](./aiisp-1.md)** — full specification, latest draft.
- **[Rendered HTML](https://97115104.github.io/aiisp-spec/)** — GitHub Pages mirror.
- **[Companion paper (Markdown)](./paper/human-data-collective.md)** — *The Human Data Collective*, the long-form motivation document for AIISP-1.
- **[Companion paper (PDF)](./paper/human-data-collective.pdf)** — typeset edition for reading offline.
- **[humandatacollective.org](https://humandatacollective.org)** — read the paper online and attach threaded comments to any passage.

## Companion paper

The AIISP-1 wire format is motivated by a longer argument developed in *The Human Data Collective* (Austin Harshberger, April 2026). The paper proposes a decentralized network of human-generated training data, fair creator compensation via on-chain settlement, and compulsory carbon and water credits built into every inference request.

The paper source lives in [`paper/`](./paper/) alongside the spec so that editorial changes go through the same PR process.

**To contribute to the paper:**

| You want to… | Use this |
| --- | --- |
| Leave a comment on a specific passage | Select the text at **[humandatacollective.org](https://humandatacollective.org)** and attach a threaded comment |
| Propose a prose, citation, or structural change | Open a [Pull Request](https://github.com/97115104/aiisp-spec/pulls) against [`paper/human-data-collective.tex`](./paper/human-data-collective.tex) (or `.md` if unfamiliar with LaTeX) |
| Report a factual error or broken citation | Open an [Errata issue](https://github.com/97115104/aiisp-spec/issues/new?template=errata.yml) |
| Discuss the paper's argument broadly | Reply on [issue #1](https://github.com/97115104/aiisp-spec/issues/1) |

## How to contribute

Contributions to the **spec** and contributions to the **companion paper** follow the same PR-and-issue workflow but target different files.

### Contributing to the spec (aiisp-1.md)

The primary public discussion thread for AIISP-1 v0.1 is **issue #1**:

> https://github.com/97115104/aiisp-spec/issues/1

You do not need permission to comment. Open an issue, file a pull request against [`aiisp-1.md`](./aiisp-1.md), or reply to issue #1 with prose feedback. All substantive comments will be tracked in the revision history of the spec.

| You want to… | Use this |
| --- | --- |
| Add a general comment or question | Reply on [issue #1](https://github.com/97115104/aiisp-spec/issues/1) |
| Propose a textual amendment | Open a [Pull Request](https://github.com/97115104/aiisp-spec/pulls) against `aiisp-1.md` |
| File a specific objection | Open a [Comment issue](https://github.com/97115104/aiisp-spec/issues/new?template=comment.yml) |
| Propose a new spec in the family | Open an [Amendment issue](https://github.com/97115104/aiisp-spec/issues/new?template=amendment.yml) |
| Report an erratum in the published draft | Open an [Errata issue](https://github.com/97115104/aiisp-spec/issues/new?template=errata.yml) |

### Contributing to the companion paper

The paper is published at **[humandatacollective.org](https://humandatacollective.org)**, where any reader can select a span of text and attach a threaded public comment without creating a GitHub account.

To propose edits directly, open a pull request against the LaTeX source [`paper/human-data-collective.tex`](./paper/human-data-collective.tex) — preferred for anything involving figures, tables, or equations. If you are not familiar with LaTeX, edit [`paper/human-data-collective.md`](./paper/human-data-collective.md) instead and the editor will reconcile it into the `.tex` source.

To build the PDF locally, run the included script:

```bash
cd paper && ./generate-latex.sh
```

Requires TeX Live or MacTeX (`brew install --cask mactex-no-gui` on macOS). See [`paper/README.md`](./paper/README.md) for the full editorial workflow.

## Status

This is a **Draft (v0.1, April 2026)** circulated for public comment. It is not, at the date of writing, a ratified standard of any standards-development organization. The author intends to submit this document to the IETF ART area, the W3C AI Provenance community group, and the Decentralized Identity Foundation, in that order.

## Naming

- The **protocol family** is called **AIISP**.
- This **specification** is **AIISP-1**, titled *The Artificial Intelligence Inference Standards Protocol*.
- Future specifications will be **AIISP-2** (Attribution), **AIISP-3** (Governance), and so on, following the IETF RFC numbering convention.

## License

- The **specification text** in [`aiisp-1.md`](./aiisp-1.md) is licensed under [Creative Commons Attribution 4.0 International](./LICENSE-SPEC) so that any party may implement, mirror, translate, or fork it without permission.
- The **reference implementation** (when published) will be licensed under the [MIT License](./LICENSE-CODE).

## Citing this document

```bibtex
@misc{aiisp1_2026,
  author       = {Harshberger, Austin},
  title        = {AIISP-1: The Artificial Intelligence Inference Standards Protocol},
  year         = {2026},
  month        = apr,
  version      = {Draft v0.1},
  howpublished = {Open standard, GitHub repository},
  url          = {https://github.com/97115104/aiisp-spec},
  note         = {Public review thread: \url{https://github.com/97115104/aiisp-spec/issues/1}}
}
```

Plain prose:

> Harshberger, A. (2026). *AIISP-1: The Artificial Intelligence Inference Standards Protocol* (Draft v0.1). <https://github.com/97115104/aiisp-spec>

## Governance

See [GOVERNANCE.md](./GOVERNANCE.md) for how decisions about the standard are made, how amendments are accepted, and how the spec is versioned.

## Code of Conduct

This project follows the [Contributor Covenant v2.1](./CODE_OF_CONDUCT.md). By participating you agree to abide by its terms.

## Contact

Editor: Austin Harshberger, `x@97115104.com`
