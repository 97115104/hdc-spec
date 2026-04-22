# HDC-1: The Human Data Collective Inference Transparency Standard

[![Status: Draft](https://img.shields.io/badge/status-draft%20v0.1-orange)](./hdc-1.md)
[![Spec License: CC BY 4.0](https://img.shields.io/badge/spec%20license-CC%20BY%204.0-blue)](./LICENSE-SPEC)
[![Code License: MIT](https://img.shields.io/badge/code%20license-MIT-green)](./LICENSE-CODE)
[![Discussion](https://img.shields.io/badge/discussion-open-brightgreen)](https://github.com/97115104/hdc-spec/issues/1)

This repository hosts **HDC-1**, the first specification in the **HDC** (Human Data Collective) family of internet standards. HDC-1 defines a minimal, transport-agnostic, opt-in HTTP standard for declaring and settling the energy, environmental, and human-attribution components of a single Large Language Model inference request.

The standard is published in the spirit of the early IETF RFCs that defined TCP, IP, HTTP, and TLS, namely small, composable, opt-in, and owned by no single party.

## Read the spec

- **[hdc-1.md](./hdc-1.md)** — full specification, latest draft.
- **[Rendered HTML](https://97115104.github.io/hdc-spec/)** — GitHub Pages mirror.
- **[Companion paper](https://github.com/97115104/human-data-network)** — long-form motivation document.

## How to comment

The primary public discussion thread for HDC-1 v0.1 is **issue #1**:

> https://github.com/97115104/hdc-spec/issues/1

You do not need permission to comment. Open an issue, file a pull request against [`hdc-1.md`](./hdc-1.md), or reply to issue #1 with prose feedback. All substantive comments will be tracked in the revision history of the spec.

| You want to... | Use this |
| --- | --- |
| Add a general comment or question | Reply on [issue #1](https://github.com/97115104/hdc-spec/issues/1) |
| Propose a textual amendment | Open a [Pull Request](https://github.com/97115104/hdc-spec/pulls) against `hdc-1.md` |
| File a specific objection | Open a [Comment issue](https://github.com/97115104/hdc-spec/issues/new?template=comment.yml) |
| Propose a new spec in the family | Open an [Amendment issue](https://github.com/97115104/hdc-spec/issues/new?template=amendment.yml) |
| Report an erratum in the published draft | Open an [Errata issue](https://github.com/97115104/hdc-spec/issues/new?template=errata.yml) |

## Status

This is a **Draft (v0.1, April 2026)** circulated for public comment. It is not, at the date of writing, a ratified standard of any standards-development organization. The author intends to submit this document to the IETF ART area, the W3C AI Provenance community group, and the Decentralized Identity Foundation, in that order.

## Naming

- The **protocol family** is called **HDC**.
- This **specification** is **HDC-1**, titled *Inference Transparency*.
- Future specifications will be **HDC-2** (Attribution), **HDC-3** (Governance), and so on, following the IETF RFC numbering convention.

## License

- The **specification text** in [`hdc-1.md`](./hdc-1.md) is licensed under [Creative Commons Attribution 4.0 International](./LICENSE-SPEC) so that any party may implement, mirror, translate, or fork it without permission.
- The **reference implementation** (when published) will be licensed under the [MIT License](./LICENSE-CODE).

## Citing this document

```bibtex
@misc{hdc1_2026,
  author       = {Harshberger, Austin},
  title        = {HDC-1: The Human Data Collective Inference Transparency Standard},
  year         = {2026},
  month        = apr,
  version      = {Draft v0.1},
  howpublished = {Open standard, GitHub repository},
  url          = {https://github.com/97115104/hdc-spec},
  note         = {Public review thread: \url{https://github.com/97115104/hdc-spec/issues/1}}
}
```

Plain prose:

> Harshberger, A. (2026). *HDC-1: The Human Data Collective Inference Transparency Standard* (Draft v0.1). <https://github.com/97115104/hdc-spec>

## Governance

See [GOVERNANCE.md](./GOVERNANCE.md) for how decisions about the standard are made, how amendments are accepted, and how the spec is versioned.

## Code of Conduct

This project follows the [Contributor Covenant v2.1](./CODE_OF_CONDUCT.md). By participating you agree to abide by its terms.

## Contact

Editor: Austin Harshberger, `x@97115104.com`
