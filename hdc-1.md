# HDC-1: The Human Data Collective Inference Transparency Standard

**Status:** Draft (v0.1, April 2026)
**Author:** Austin Harshberger, Happy Stack Calculus LLC, `x@97115104.com`
**Category:** Standards Track
**Repository:** <https://github.com/97115104/hdc-spec>
**Discussion:** <https://github.com/97115104/hdc-spec/issues/1>
**License:** CC BY 4.0 (specification text); reference implementation MIT.

---

## Abstract

This document specifies a minimal, transport-agnostic standard for declaring and settling the energy, environmental, and human-attribution components of a single Large Language Model (LLM) inference request. The standard adds two optional HTTP request headers, one structured response header, and one settlement record format. It is designed to layer cleanly on top of any existing HTTP-based inference API without breaking unmodified clients, and to be implementable by any provider in a single afternoon of integration work.

The standard is published in the spirit of the early internet RFCs, namely small, composable, opt-in, and owned by no single party. Comments and proposed amendments are solicited from any implementer, regulator, or contributor.

---

## Status of this memo

This memo specifies a proposed standard for the inference transparency layer of the Human Data Collective (HDC). It is published for comment and is not, at the date of writing, a ratified standard of any standards-development organization. Distribution is unlimited.

The author intends to submit this document for community review through, in order, the Internet Engineering Task Force (IETF) ART area, the Decentralized Identity Foundation (DIF), and the World Wide Web Consortium (W3C) AI Provenance community group, and will track substantive comments in the public revision history of this document.

---

## 1. Motivation

A single LLM inference request today bundles, into a single dollar amount, the cost of electricity, the cost of water for cooling, the embodied carbon of the compute substrate, the amortized cost of training data, and the provider's margin. None of these components is exposed to the requester, the regulator, or the human author whose work trained the model. The result is that none of them can be priced, audited, or compensated.

HDC-1 specifies a way to break that single dollar amount into named, machine-readable line items at the moment the request is served, and to settle those line items against a public ledger. It does not require any change to model architecture, training methodology, or pricing strategy. It requires only that the provider expose what is already happening inside its own billing system, in a standard format, on a standard channel.

The forcing function for adoption is the data, not the regulation. Sustainable access to fresh, attributed, categorized human-generated data is becoming the binding constraint on continued model improvement, and the Collective is the only proposed structure that produces such data at scale while compensating its sources. HDC-1 is the wire format that makes that exchange auditable.

---

## 2. Terminology

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119 and RFC 8174 when they appear in all capitals.

- **Provider.** An entity that serves LLM inference requests over HTTP, including but not limited to Anthropic, OpenAI, Google, Microsoft, Meta, xAI, Cohere, Mistral, and any operator of a self-hosted open-source model exposed over a network.
- **Client.** Any process that issues an HTTP inference request to a Provider.
- **Branded Inference Token (BIT).** An ERC-20 token minted on Base by a Provider, identifying that Provider's participation in the HDC settlement contract.
- **Settlement Contract.** The on-chain HDC distribution contract, deployed at an address published in the HDC registry, that splits incoming settlement transactions into the energy, environmental, and creator-compensation pools.
- **Attestation.** A signed record produced under the `attest` v3 specification, binding an identifier to authored content; used here to resolve the creator-compensation share to specific contributors.
- **Settlement cadence.** The interval at which a Provider batches inference requests into a single on-chain settlement transaction. RECOMMENDED to be no longer than 24 hours.

---

## 3. Request headers

### 3.1 `X-HDC-Token`

A Client MAY include this header on any inference request to opt the request into HDC settlement.

```
X-HDC-Token: <0x-prefixed 20-byte hex address of the Provider's BIT>
```

If the header is absent, the request MUST be processed and billed exactly as it is today, with no HDC settlement performed and no HDC response headers emitted. If the header is present and the supplied token address is not registered in the HDC registry for the receiving Provider, the Provider MUST respond with HTTP 400 and a JSON error body of the form `{"error": "hdc_token_unknown", "token": "0x..."}`.

### 3.2 `X-HDC-Settlement`

A Client MAY include this header to control settlement timing.

```
X-HDC-Settlement: deferred | realtime
```

`deferred` (the default if `X-HDC-Token` is present and `X-HDC-Settlement` is absent) batches the request into the Provider's next settlement cadence. `realtime` requests immediate per-request settlement, which is intended primarily for audit and conformance testing. Providers MAY refuse `realtime` for cost reasons by returning HTTP 503 and a JSON body `{"error": "realtime_unavailable"}`.

### 3.3 `X-HDC-Attribution`

A Client MAY include this header to declare that the request is intended to produce content that will itself be attested under the `attest` v3 specification, in which case the Provider's response cost record SHOULD additionally include an attribution-eligible flag for downstream pipelines.

```
X-HDC-Attribution: attested
```

Absence of this header MUST NOT change settlement behaviour and is purely an informational hint.

---

## 4. Response headers

### 4.1 `X-HDC-Cost`

A Provider that processes a request bearing `X-HDC-Token` MUST return this header on the corresponding response. The value is a single base64url-encoded JSON object conforming to the schema defined in Section 5.

```
X-HDC-Cost: <base64url(JSON cost record)>
```

If the request did not carry `X-HDC-Token`, the Provider MUST NOT emit `X-HDC-Cost`.

### 4.2 `X-HDC-Settlement-Tx`

For requests settled in `realtime` mode, the Provider MUST return the on-chain transaction hash of the settlement.

```
X-HDC-Settlement-Tx: 0x<32-byte hex>
```

For `deferred` mode, the Provider MUST instead return a settlement-batch identifier that will appear in a subsequent on-chain batch.

```
X-HDC-Settlement-Batch: <opaque string, max 64 chars>
```

A Provider MUST publish, at a stable URL discoverable from the HDC registry, a JSON endpoint mapping each `X-HDC-Settlement-Batch` value to the on-chain transaction hash that ultimately settled it. The mapping MUST become available no later than 24 hours after the settlement cadence closes.

---

## 5. Cost record schema

The JSON object encoded in `X-HDC-Cost` MUST conform to the following schema. All monetary values are denominated in United States dollars and serialized as decimal strings to avoid floating-point ambiguity.

```json
{
  "version": "hdc-1",
  "request_id": "string, opaque, provider-scoped",
  "model": "string, provider-scoped model identifier",
  "tokens": {
    "input": 0,
    "output": 0
  },
  "cost": {
    "energy_usd":        "0.000010",
    "environmental_usd": "0.000020",
    "premium_usd":       "0.001000",
    "total_usd":         "0.001030"
  },
  "energy": {
    "kwh":         "0.0000045",
    "region":      "us-west-2",
    "rate_source": "https://hdc.org/registry/energy/us-west-2/2026-04"
  },
  "environmental": {
    "carbon_share_usd": "0.000010",
    "water_share_usd":  "0.000010"
  },
  "hdc": {
    "share_usd":    "0.000010",
    "split":        {"creators": "0.80", "reviewers": "0.05", "operations": "0.15"},
    "token":        "0xA1B2...",
    "settlement":   "deferred"
  }
}
```

Field-by-field requirements:

- `version` MUST be the string `hdc-1` for this specification.
- `cost.total_usd` MUST equal the sum of `energy_usd`, `environmental_usd`, and `premium_usd`, computed in fixed-point arithmetic at six decimal places.
- `hdc.share_usd` MUST be at least one percent of `cost.premium_usd`, rounded up to the nearest 1e-6 USD.
- `hdc.split.creators + hdc.split.reviewers + hdc.split.operations` MUST equal `1.00` exactly.
- `energy.rate_source` MUST be a URL serving the per-region per-month kWh rate used by the Provider, in machine-readable form, retained for at least 24 months.
- All other fields are REQUIRED unless explicitly marked optional in a future revision.

A worked example for a 1,000-token blended request appears in Appendix A.

---

## 6. Settlement contract

A Provider that returns `X-HDC-Cost` MUST settle the corresponding amounts on-chain through the HDC Settlement Contract on Base, at the address published in the HDC registry. A single settlement transaction MAY aggregate any number of requests within one settlement cadence.

The contract atomically distributes the incoming amount as follows:

- `energy_usd` is retained by the Provider's own treasury address.
- `environmental.carbon_share_usd` is forwarded to the HDC Carbon Credit Fund contract.
- `environmental.water_share_usd` is forwarded to the HDC Water Credit Fund contract.
- `premium_usd minus hdc.share_usd` is forwarded to the Provider's treasury address.
- `hdc.share_usd` is forwarded to the HDC Distribution Contract, which further splits it 80/5/15 between the creator-attestation pool, the peer-reviewer pool, and the HDC operations multisig.

Any deviation from this distribution by a Provider that has emitted `X-HDC-Cost` constitutes a violation of the standard and is grounds for revocation of the Provider's BIT registration.

---

## 7. Backward compatibility

A Provider that does not implement HDC-1 is unaffected; existing clients continue to operate without change. A Client that does not implement HDC-1 is unaffected; the Provider simply does not route the request through the settlement contract. A Client that sends `X-HDC-Token` to a non-implementing Provider receives a normal response and MUST NOT treat the absence of `X-HDC-Cost` as an error, since intermediate proxies, load balancers, and pre-existing API gateways may strip unknown headers.

The standard adds zero required latency to the inference response path, since cost-record serialization is performed alongside normal billing-record emission and on-chain settlement is performed asynchronously in the deferred case.

---

## 8. Security considerations

### 8.1 Spoofed cost records

A malicious Provider could emit an `X-HDC-Cost` record that under-reports the true energy or environmental cost of the request. The standard mitigates this by requiring `energy.rate_source` to point at a publicly retained machine-readable rate document and by requiring on-chain settlement, which makes systematic under-reporting visible in the cumulative on-chain balance of the Provider's BIT. Auditors MAY sample requests, recompute the expected energy and environmental lines from the published rate, and compare against the on-chain settlement record.

### 8.2 Replay and double-billing

The `request_id` field is Provider-scoped and MAY be opaque, so the standard does not by itself prevent a Provider from settling the same request twice. The on-chain settlement contract SHOULD reject duplicate `(provider_address, request_id)` pairs within a moving 30-day window.

### 8.3 Attribution fraud

The creator-attestation pool is resolved against `attest` v3 records, which carry their own signature, timestamp, and registry-anchoring requirements. Identity fraud and prompt-laundering attacks against the attestation primitive are out of scope for this document and addressed in HDC-2 (forthcoming).

### 8.4 Privacy of the Client

The HDC headers carry no Client-identifying information beyond what the Provider already collects to bill the Client. Implementations MUST NOT log the request payload or model output to the public ledger; only the structured cost record described in Section 5 is settled on-chain, and that record contains no Client identity, no prompt content, and no model output.

---

## 9. IANA and registry considerations

This document defines four new HTTP headers, namely `X-HDC-Token`, `X-HDC-Settlement`, `X-HDC-Attribution`, and `X-HDC-Cost`. On formal acceptance the prefix SHOULD be migrated from `X-HDC-` to `HDC-` per RFC 6648 deprecation guidance.

The HDC registry MUST be a public, append-only, signed registry maintained at a stable URL under `hdc.org` and mirrored on-chain at a contract address published in this document's revision history. The registry maps each Provider to its registered BIT contract address, its energy rate-source endpoint, and its settlement-batch resolution endpoint.

---

## 10. Reference implementation

A reference implementation of the cost-record emitter, the on-chain settlement contract, and a conformance test suite is being prepared and will be published in this repository (`https://github.com/97115104/hdc-spec`) under a `reference/` subdirectory, MIT-licensed. The conformance suite issues a structured set of test requests against any HTTP inference endpoint, parses the returned `X-HDC-Cost` records, and verifies arithmetic, schema, and on-chain settlement correctness.

---

## 11. Acknowledgements

The structure of this document is modelled directly on the early IETF RFCs that defined TCP, IP, HTTP, and TLS, with the deliberate goal of being short, opt-in, and unowned. No claim is made that this document is the final or canonical form of the specification. Comments are solicited and will be tracked in the revision history.

---

## Appendix A. Worked example

A 1,000-token blended request (700 input + 300 output) against a Provider with a US$1.00 per million blended-token list price on `us-west-2`:

```http
POST /v1/messages HTTP/1.1
Host: api.example-provider.com
Content-Type: application/json
X-HDC-Token: 0xA1B2C3D4E5F60718293A4B5C6D7E8F90A1B2C3D4
X-HDC-Settlement: deferred
```

```http
HTTP/1.1 200 OK
Content-Type: application/json
X-HDC-Cost: eyJ2ZXJzaW9uIjoiaGRjLTEiLCJyZXF1ZXN0X2lkIjoicmVxX2FiYzEyMyIs...
X-HDC-Settlement-Batch: 2026-04-22T18:00Z-batch-7741
```

Decoded `X-HDC-Cost`:

```json
{
  "version": "hdc-1",
  "request_id": "req_abc123",
  "model": "example-llm-large",
  "tokens": {"input": 700, "output": 300},
  "cost": {
    "energy_usd":        "0.000010",
    "environmental_usd": "0.000020",
    "premium_usd":       "0.001000",
    "total_usd":         "0.001030"
  },
  "energy": {
    "kwh":         "0.0000045",
    "region":      "us-west-2",
    "rate_source": "https://example-provider.com/hdc/energy/us-west-2/2026-04"
  },
  "environmental": {
    "carbon_share_usd": "0.000010",
    "water_share_usd":  "0.000010"
  },
  "hdc": {
    "share_usd":  "0.000010",
    "split":      {"creators": "0.80", "reviewers": "0.05", "operations": "0.15"},
    "token":      "0xA1B2C3D4E5F60718293A4B5C6D7E8F90A1B2C3D4",
    "settlement": "deferred"
  }
}
```

At settlement cadence, the Provider submits a single transaction settling this and all other requests in batch `2026-04-22T18:00Z-batch-7741`. After confirmation, the Provider publishes:

```
GET https://example-provider.com/hdc/batches/2026-04-22T18:00Z-batch-7741
{"tx": "0x9f8e...e221", "block": 19234567, "settled_at": "2026-04-22T18:00:14Z"}
```

---

## Appendix B. Revision history

- **v0.1, 2026-04-22.** Initial draft circulated for comment to Karen Hao, Emily Bender, Sonia Ramos, Timnit Gebru, OpenAI, Anthropic, Coinbase Ventures, the office of the California State Assembly representative for Los Angeles County, and the academic peer-review circle.

---

> **attest v3.0** &nbsp;·&nbsp; `2026-04-22-hdc1-77bcdb`
>
> *Human–AI collaboration.*
>
> | Field | Value |
> | --- | --- |
> | **Content** | HDC-1: The Human Data Collective Inference Transparency Standard |
> | **Author** | A. Harshberger |
> | **AI collaborators** | Claude Opus 4.7 |
> | **Role** | collaborated (multi-prompt iterative authoring; human directed structure, argument, and final wording; AI assisted with drafting and formatting under human review) |
> | **Authorship** | collab |
> | **Prompt type** | multi-prompt |
> | **Prompt summary** | *RFC-style standards-track specification for HDC inference transparency headers* |
> | **Platform** | GitHub Copilot in VS Code |
> | **Timestamp** | 2026-04-22T05:10:00Z |
> | **Verify** | <https://attest.97115104.com/s/r11xzkrm> |

© 2026 Happy Stack Calculus LLC. Specification text licensed CC BY 4.0; reference implementation MIT.
