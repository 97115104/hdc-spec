# AIISP - Artificial Intelligence Inference Standards Protocol

[![Status: AIISP-2 Draft v0.1](https://img.shields.io/badge/AIISP--2-draft%20v0.1-orange)](./spec/aiisp-2.md)
[![Spec License: CC BY 4.0](https://img.shields.io/badge/spec-CC%20BY%204.0-blue)](./LICENSES/CC-BY-4.0.txt)
[![Code License: MIT](https://img.shields.io/badge/code-MIT-green)](./LICENSE)

AIISP is an open standards family for inference transparency, contributor-aligned routing, public settlement records, and environmental accounting.

The active draft is **AIISP-2: Contributor-Aligned Inference Routing and Settlement Protocol**. AIISP-2 is the canonical standards track for the Human Data Collective v2 proposal. It defines category-specific model routing, contributor-operated inference nodes, accepted human data contributions, accepted DPO feedback pairs, event-based HDCT issuance, environmental lines, and settlement batches.

AIISP-1 remains in the repo as a historical and provider-facing draft for request-cost disclosure by centralized inference providers. It is not deleted or replaced.

## Quick Links

- **Active spec:** [`spec/aiisp-2.md`](./spec/aiisp-2.md)
- **Historical/provider-facing draft:** [`spec/aiisp-1.md`](./spec/aiisp-1.md)
- **Schemas:** [`spec/schemas/aiisp-2/`](./spec/schemas/aiisp-2/)
- **Examples:** [`examples/aiisp-2/`](./examples/aiisp-2/)
- **Reference design:** [`reference/`](./reference/)
- **Rendered docs:** <https://97115104.github.io/aiisp-spec/>
- **Companion papers:** [HDC v1 paper folder](./paper/v1/) and [HDC v2 paper folder](./paper/v2/)

## AIISP-2 In One Screen

```http
POST /v2/inference
Content-Type: application/json
X-AIISP-Category: writing
X-AIISP-Settlement: batch
```

The router selects a registered Category Model and an eligible Inference Node, returns a normal model response, and records a settlement event:

```json
{
  "version": "aiisp-2",
  "event_type": "verified_inference_served",
  "category": "writing",
  "contributor": "did:pkh:eip155:8453:0x1234...",
  "hdct_amount": "0.015",
  "batch_id": "batch_2026-05-01T12-00Z_001"
}
```

HDCT issuance is event-based only. A recorded event cannot be reminted. Valid issuance events are:

1. accepted data contribution
2. verified inference served, or a settled inference unit
3. accepted DPO pair

AIISP-2 does not define recurring royalties for old data contributions.

## Repository Layout

```text
.
spec/
  aiisp-1.md                    # Historical/provider-facing draft
  aiisp-2.md                    # Active HDC v2 draft
  schemas/aiisp-2/              # Draft v0.1 JSON schemas
examples/aiisp-2/               # Example AIISP-2 records
reference/
  contracts/                    # HDCT and settlement contract reference design
  router/                       # Router reference design
  node/                         # Inference-node reference design
  conformance/                  # Conformance-suite reference design
paper/
  v1/                           # HDC v1 companion paper
  v2/                           # HDC v2 companion paper
docs/                           # GitHub Pages site
GOVERNANCE.md
CHANGELOG.md
CITATION.cff
LICENSE                         # MIT License (code)
LICENSES/                       # SPDX license directory
  CC-BY-4.0.txt                 #   CC BY 4.0 (specification)
  MIT.txt                       #   MIT (code)
```

## Local Preview

Run the repo-root deploy script:

```sh
./deploy-locally.sh
```

The script builds the site, restarts the local preview server on `http://127.0.0.1:4173/`, smoke-checks the main pages, and opens the site in your browser. Override the port with `AIISP_PORT=4174 ./deploy-locally.sh`; skip browser launch with `AIISP_OPEN_BROWSER=0 ./deploy-locally.sh`.

## Specification Status

AIISP-2 is **Draft v0.1, May 2026**. It is published for public comment and is not yet a ratified standard of any standards-development organization.

The active AIISP-2 components are:

- `POST /v2/inference`
- category-specific model routing
- contributor-operated or Collective-operated inference nodes
- accepted data contribution records
- accepted DPO pair records
- event-based settlement events
- HDCT minting by settlement contract
- environmental lines for inference events
- public settlement batches

## How To Contribute

Use issues and pull requests for amendments, objections, errata, schemas, examples, and reference implementation work.

| You want to... | Use this |
| --- | --- |
| Propose a spec change | [Amendment issue](https://github.com/97115104/aiisp-spec/issues/new?template=amendment.yml) |
| File a specific objection | [Comment issue](https://github.com/97115104/aiisp-spec/issues/new?template=comment.yml) |
| Report a typo or broken citation | [Errata issue](https://github.com/97115104/aiisp-spec/issues/new?template=errata.yml) |
| Propose text, schemas, examples, or code | [Pull request](https://github.com/97115104/aiisp-spec/pulls) |
| Disclose a security issue privately | See [`SECURITY.md`](./SECURITY.md) |

Full guidelines are in [`CONTRIBUTING.md`](./CONTRIBUTING.md). Decision process and versioning are in [`GOVERNANCE.md`](./GOVERNANCE.md).

## Working With The Papers

The companion papers are non-normative motivation and background:

- [HDC v1 paper folder](./paper/v1/) contains the original Human Data Collective paper.
- [HDC v2 paper folder](./paper/v2/) contains the Human Data Collective v2 paper.

The normative protocol text lives in `spec/`.

## License

- Specification text, schemas, examples, and paper text are licensed [Creative Commons Attribution 4.0 International](./LICENSES/CC-BY-4.0.txt).
- Reference implementation code is licensed under the [MIT License](./LICENSES/MIT.txt).

## Citing This Document

```bibtex
@misc{aiisp2_2026,
  author       = {Harshberger, Austin},
  title        = {AIISP-2: Contributor-Aligned Inference Routing and Settlement Protocol},
  year         = {2026},
  month        = may,
  version      = {Draft v0.1},
  howpublished = {Open standard, GitHub repository},
  url          = {https://github.com/97115104/aiisp-spec}
}
```

Plain prose:

> Harshberger, A. (2026). *AIISP-2: Contributor-Aligned Inference Routing and Settlement Protocol* (Draft v0.1). <https://github.com/97115104/aiisp-spec>

## Contact

Editor: Austin Harshberger, `x@97115104.com`
