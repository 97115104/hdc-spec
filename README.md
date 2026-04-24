# AIISP — Artificial Intelligence Inference Standards Protocol

[![Status: Draft v0.1](https://img.shields.io/badge/status-draft%20v0.1-orange)](./spec/aiisp-1.md)
[![Spec License: CC BY 4.0](https://img.shields.io/badge/spec-CC%20BY%204.0-blue)](./LICENSE)
[![Code License: MIT](https://img.shields.io/badge/code-MIT-green)](./LICENSE-CODE)
[![Discussion](https://img.shields.io/badge/discuss-issue%20%231-brightgreen)](https://github.com/97115104/aiisp-spec/issues/1)

A minimal, transport-agnostic, opt-in HTTP standard for declaring and settling
the energy, environmental, and human-attribution components of a single Large
Language Model inference request.

Published in the spirit of the early IETF RFCs that defined TCP, IP, HTTP, and
TLS — small, composable, opt-in, and owned by no single party.

## Quick links

- **Read the spec** → [`spec/aiisp-1.md`](./spec/aiisp-1.md)
- **Read it rendered** → <https://97115104.github.io/aiisp-spec/>
- **Read the companion paper** → <https://humandatacollective.org> *(commentable)*
- **Discuss v0.1** → [issue #1](https://github.com/97115104/aiisp-spec/issues/1)
- **Propose a change** → [open a PR](https://github.com/97115104/aiisp-spec/pulls) or [file an amendment](https://github.com/97115104/aiisp-spec/issues/new?template=amendment.yml)

## Repository layout

```
.
├── spec/                    # Normative specification documents
│   ├── README.md
│   └── aiisp-1.md           # AIISP-1 — the inference transparency layer
├── paper/                   # Companion paper (motivation, not normative)
│   ├── human-data-collective.tex   # LaTeX source (canonical)
│   ├── human-data-collective.md    # Markdown mirror
│   ├── human-data-collective.pdf   # Typeset edition
│   ├── human-data-collective.bib   # Bibliography
│   └── generate-latex.sh           # pdflatex × 3 build script
├── docs/                    # GitHub Pages site (index + spec renderer)
├── .github/                 # Issue templates, PR template, Pages workflow
├── CONTRIBUTING.md          # How to file an issue or open a PR
├── GOVERNANCE.md            # How decisions about the standard are made
├── CHANGELOG.md             # Revision history
├── CITATION.cff             # Machine-readable citation metadata
├── CODE_OF_CONDUCT.md       # Contributor Covenant v2.1
├── SECURITY.md              # Private security disclosure
├── LICENSE                  # CC BY 4.0 — applies to spec & paper text
└── LICENSE-CODE             # MIT — applies to scripts & reference code
```

## Status

This is a **Draft (v0.1, April 2026)** circulated for public comment. It is
not, at the date of writing, a ratified standard of any standards-development
organization. The author intends to submit this document to the IETF ART area,
the Decentralized Identity Foundation, and the W3C AI Provenance community
group, in that order.

The **protocol family** is called **AIISP**. This **specification** is
**AIISP-1**, *The Artificial Intelligence Inference Standards Protocol*.
Future specifications will be **AIISP-2** (Attribution), **AIISP-3**
(Governance), and so on, following the IETF RFC numbering convention.

## How to contribute

The repository hosts two things you can contribute to: the **spec** in
[`spec/aiisp-1.md`](./spec/aiisp-1.md) and the **companion paper** in
[`paper/`](./paper/). Both follow the same PR-and-issue workflow against
different files.

| You want to… | Use this |
| --- | --- |
| Comment generally on AIISP-1 v0.1 | Reply on [issue #1](https://github.com/97115104/aiisp-spec/issues/1) |
| File a specific objection on a section | [Comment template](https://github.com/97115104/aiisp-spec/issues/new?template=comment.yml) |
| Propose a new feature, header, or behaviour | [Amendment template](https://github.com/97115104/aiisp-spec/issues/new?template=amendment.yml) |
| Report a typo or broken citation | [Errata template](https://github.com/97115104/aiisp-spec/issues/new?template=errata.yml) |
| Propose textual changes | Open a [Pull Request](https://github.com/97115104/aiisp-spec/pulls) |
| Comment on a specific paper passage | Select text at <https://humandatacollective.org> |
| Disclose a security issue privately | See [`SECURITY.md`](./SECURITY.md) |

Full guidelines are in [`CONTRIBUTING.md`](./CONTRIBUTING.md). Decision
process and versioning are in [`GOVERNANCE.md`](./GOVERNANCE.md).

## Building the paper locally

```bash
cd paper && ./generate-latex.sh
```

Requires TeX Live or MacTeX (`brew install --cask mactex-no-gui` on macOS).
See [`paper/README.md`](./paper/README.md) for the full editorial workflow.

## License

- **Specification text** in [`spec/`](./spec/) and **paper text** in [`paper/`](./paper/)
  are licensed [Creative Commons Attribution 4.0 International](./LICENSE)
  so any party may implement, mirror, translate, or fork without permission.
- **Scripts and any reference implementation code** are licensed under the
  [MIT License](./LICENSE-CODE).

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

## Code of Conduct

This project follows the [Contributor Covenant v2.1](./CODE_OF_CONDUCT.md). By
participating you agree to abide by its terms.

## Contact

Editor: Austin Harshberger · `x@97115104.com`
