# AIISP-2: Contributor-Aligned Inference Routing and Settlement Protocol

- **Status:** Draft v0.1, May 2026
- **Author:** Austin Harshberger, Happy Stack Calculus LLC, `x@97115104.com`
- **Category:** Standards Track
- **Repository:** <https://github.com/97115104/aiisp-spec>
- **License:** CC BY 4.0 (specification text); reference implementation MIT.

---

## Abstract

AIISP-2 specifies a contributor-aligned inference routing and settlement protocol for the Human Data Collective v2 proposal. It defines a client-facing inference endpoint, category-specific model routing, contributor-operated inference nodes, accepted human data contributions, accepted DPO feedback pairs, event-based HDCT issuance, environmental accounting, and public settlement records.

AIISP-2 replaces the AIISP-1 assumption that a centralized frontier provider is the primary settlement counterparty. AIISP-1 remains a historical and provider-facing draft for request-cost disclosure. AIISP-2 is the active HDC v2 draft for routing work through a network of category models and settling accepted contribution events.

HDCT issuance under this specification is event-based only. A recorded event cannot be reminted. Valid issuance events are limited to accepted data contributions, verified inference served or settled inference units, and accepted DPO pairs. AIISP-2 does not define, permit, or reintroduce recurring royalty mechanics for prior data use.

---

## Status of this memo

This memo is a draft specification for public comment. It is not a ratified standard of any standards-development organization. Distribution is unlimited.

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119 and RFC 8174 when they appear in all capitals.

---

## 1. Scope

AIISP-2 defines:

- the roles that participate in a contributor-aligned inference network;
- the HTTP interface used by clients to request category-specific inference;
- the routing records created by an AIISP-2 Router;
- the settlement event types that can mint HDCT;
- environmental accounting lines attached to inference;
- JSON schemas for request, response, contribution, node, and settlement records;
- the minimum behavior expected from reference contracts, routers, nodes, and conformance tests.

AIISP-2 does not define model-training methodology, contribution-review policy, price discovery, exchange listing policy, contributor identity governance, or the full social governance of the Human Data Collective. Those topics may be specified by later AIISP drafts or by Collective governance.

---

## 2. Normative components

### 2.1 Actors

- **Client.** An application, service, agent, or human-operated tool issuing an inference request.
- **AIISP-2 Router.** A service that receives client requests, selects nodes and models, returns responses, and creates settlement records.
- **Inference Node.** A contributor-operated or Collective-operated compute endpoint serving model requests.
- **Category Model.** A named model snapshot associated with a bounded category such as writing, software, learning, creative arts, legal-aid forms, or another category admitted by the registry.
- **Contributor.** A wallet, DID, legal entity, or other registry subject supplying accepted data, accepted DPO feedback, or compute.
- **Verifier.** A reviewer, committee, automated validation process, or hybrid process that accepts or rejects contributions.
- **Settlement Contract.** An on-chain contract that records work events and mints HDCT.
- **HDCT.** The Human Data Collective Token, represented as an ERC-20 token on Base or on a local test chain in the reference implementation.
- **Settlement Batch.** A group of events settled together.
- **Environmental Line.** A carbon, water, energy, and remediation allocation attached to inference.

### 2.2 Event vocabulary

The only valid HDCT issuance event types are:

1. `accepted_data_contribution`
2. `verified_inference_served`
3. `settled_inference_unit`
4. `accepted_dpo_pair`

An implementation MAY use `verified_inference_served` for a single served request or `settled_inference_unit` for an aggregated unit of verified inference work. In either case, the settlement contract MUST map the event to one non-reusable event identifier and MUST NOT mint more than once for that identifier.

The settlement contract MUST reject duplicate `event_id` values. Routers, nodes, and verifiers MUST treat `event_id` as globally unique within the AIISP-2 chain or registry domain.

### 2.3 Non-recurring issuance rule

HDCT issuance is based on accepted work events, not on perpetual reuse claims. A data contribution MAY receive HDCT once when accepted. A DPO pair MAY receive HDCT once when accepted. An inference node MAY receive HDCT once for a verified inference event or settled inference unit. A later inference request that benefits from a prior data contribution MUST NOT remint HDCT for that prior contribution merely because the trained model used it.

---

## 3. Category routing model

Each AIISP-2 request is associated with exactly one category. The category determines the eligible model set, policy filters, evaluation benchmarks, and environmental accounting defaults.

A category identifier MUST be a lowercase ASCII slug matching `^[a-z0-9][a-z0-9-]{1,63}$`. Examples include `writing`, `software`, `learning`, `creative-arts`, and `legal-aid-forms`.

The router MUST select a Category Model from the category's registry entry unless the client requests a specific model and that model is permitted for the category. A model identifier MUST include enough information to resolve a stable snapshot, for example:

```text
writing/hsc-small-2026-05-01@sha256:8d7c...
```

The router SHOULD record the following routing facts for settlement and audit:

- request identifier;
- category;
- selected model snapshot;
- selected node;
- routing policy version;
- time accepted;
- time completed;
- token or unit counts;
- environmental line;
- settlement batch identifier.

The router MUST NOT publish prompt text, model output text, private client identity, or secrets to the public settlement record.

---

## 4. HTTP API

### 4.1 `POST /v2/inference`

`POST /v2/inference` is the client-facing inference endpoint. The request body SHOULD remain OpenAI-compatible where practical so existing clients can adapt by adding AIISP-2 headers rather than rewriting their payload format.

Required request header:

```http
X-AIISP-Category: writing
```

Optional request headers:

```http
X-AIISP-Settlement: batch
X-AIISP-Node: did:pkh:eip155:8453:0x1234...
X-AIISP-Client-DID: did:example:client-123
X-AIISP-Idempotency-Key: client-generated-opaque-key
```

Header requirements:

- `X-AIISP-Category` is REQUIRED and MUST identify the bounded category for routing.
- `X-AIISP-Settlement` MAY be `batch` or `realtime`. If absent, the default is `batch`.
- `X-AIISP-Node` MAY request a preferred node. The router MAY reject or ignore the preference if the node is unavailable, ineligible for the category, fails policy checks, or fails health checks.
- `X-AIISP-Client-DID` is OPTIONAL and MUST NOT be written to a public settlement record unless the client has explicitly opted into public attribution.
- `X-AIISP-Idempotency-Key` is OPTIONAL. If present, the router SHOULD use it to avoid duplicate request processing after retries.

The request body MUST be a JSON object. It SHOULD support the following OpenAI-compatible fields:

```json
{
  "model": "optional category model id",
  "messages": [
    {"role": "user", "content": "Draft a short grant summary."}
  ],
  "input": "Optional alternate input form.",
  "temperature": 0.2,
  "max_tokens": 512,
  "stream": false,
  "metadata": {
    "client_request_id": "req-client-001"
  }
}
```

The body MUST contain either `messages` or `input`. If `model` is absent, the router MUST select an eligible Category Model. If `model` is present, the router MUST verify that the requested model is registered for the category before routing.

Successful responses SHOULD remain compatible with ordinary model-response objects and MUST include an `aiisp` object or equivalent response headers that identify the settlement record.

Required response headers for a successful non-streaming response:

```http
X-AIISP-Category: writing
X-AIISP-Model: writing/hsc-small-2026-05-01@sha256:8d7c...
X-AIISP-Node: did:pkh:eip155:8453:0x1234...
X-AIISP-Settlement-Event: evt_01j...
X-AIISP-Settlement-Batch: batch_2026-05-01T12-00Z_001
```

If `X-AIISP-Settlement: realtime` was honored, the response MUST include:

```http
X-AIISP-Settlement-Tx: 0x<transaction-hash>
```

If the response is streamed, the router MUST deliver the same settlement identifiers in response headers, a terminal stream event, or both.

### 4.2 Inference errors

AIISP-2 error responses MUST use a JSON body with an `error.code` field. The following codes are reserved:

| Code | HTTP status | Meaning |
| --- | ---: | --- |
| `aiisp_category_required` | 400 | Missing `X-AIISP-Category`. |
| `aiisp_category_unknown` | 404 | Category not registered. |
| `aiisp_model_not_in_category` | 400 | Requested model is not eligible for the category. |
| `aiisp_node_unavailable` | 503 | Requested or selected node cannot serve the request. |
| `aiisp_settlement_unavailable` | 503 | Settlement cannot be recorded under the requested mode. |
| `aiisp_policy_rejected` | 403 | Category, node, model, or content policy rejected the request. |

Example:

```json
{
  "error": {
    "code": "aiisp_category_unknown",
    "message": "Category 'medical-diagnosis' is not registered for this router.",
    "category": "medical-diagnosis"
  }
}
```

### 4.3 Contribution intake records

AIISP-2 does not require every implementation to expose public contribution intake endpoints. If an implementation exposes HTTP intake, the following logical records MUST be produced after verification:

- `accepted_data_contribution` records conforming to `spec/schemas/aiisp-2/contribution.schema.json`;
- `accepted_dpo_pair` records conforming to `spec/schemas/aiisp-2/dpo-pair.schema.json`.

A verifier MUST sign or otherwise authenticate the acceptance decision. Rejected data and rejected DPO pairs MUST NOT mint HDCT.

### 4.4 Settlement batch lookup

Routers MUST publish settlement batch records at a stable endpoint. The path is implementation-defined, but the following shape is RECOMMENDED:

```http
GET /v2/settlement/batches/{batch_id}
```

The response MUST conform to `spec/schemas/aiisp-2/settlement-batch.schema.json`. For batch settlement, the public batch record MUST become available no later than 24 hours after the batch closes.

---

## 5. Settlement event format

Every event submitted to the Settlement Contract MUST conform to `spec/schemas/aiisp-2/settlement-event.schema.json`.

Required fields include:

- `version`, fixed to `aiisp-2`;
- `event_id`, globally unique and non-reusable;
- `event_type`, one of the valid issuance event types;
- `category`;
- `contributor`;
- `verifier`;
- `subject_ref`, a content-addressed or registry-addressed reference to the accepted work or served inference unit;
- `hdct_amount`, serialized as a decimal string;
- `occurred_at`;
- `accepted_at`;
- `batch_id`, when included in a batch;
- `environmental_line`, when the event is inference-related.

`subject_ref` MUST NOT expose private prompt text, private model output, undisclosed contributor personal data, or proprietary model weights. It SHOULD be a content hash, registry identifier, or encrypted reference whose public metadata is sufficient for audit without exposing protected content.

---

## 6. Settlement contract behavior

The Settlement Contract MUST:

- expose the HDCT token address or minting authority;
- accept settlement events from authorized routers, verifiers, or batch submitters;
- reject duplicate `event_id` values;
- record enough event metadata to audit event type, category, contributor, amount, and batch membership;
- mint HDCT exactly once for each accepted event;
- emit an on-chain event containing `event_id`, `event_type`, `category`, `contributor`, `hdct_amount`, and `batch_id`;
- support Base deployment and local test-chain deployment in the reference implementation.

The Settlement Contract MUST NOT:

- mint HDCT for recurring royalties;
- mint HDCT again because a prior contribution was reused by a model;
- mint HDCT for rejected data, rejected DPO pairs, unverified inference, or duplicate event identifiers;
- require prompt text or model output to be stored on-chain.

---

## 7. Inference node behavior

An Inference Node MUST publish a machine-readable manifest conforming to `spec/schemas/aiisp-2/node-manifest.schema.json`.

The manifest MUST include:

- node identifier;
- operator contributor identifier;
- supported categories;
- supported model snapshots;
- service endpoint;
- settlement wallet;
- public key or DID document reference;
- energy region;
- measurement method for environmental accounting;
- software version.

An Inference Node MUST return signed serving evidence to the router. The serving evidence MUST bind at least the request identifier, category, model snapshot, node identifier, completed-at timestamp, and usage units. The router or verifier MAY reject evidence that is unsigned, late, inconsistent with observed response data, or inconsistent with node registration.

---

## 8. Environmental accounting

Every verified inference event or settled inference unit MUST include an Environmental Line conforming to `spec/schemas/aiisp-2/environmental-line.schema.json`.

An Environmental Line MUST include:

- `energy_kwh`;
- `carbon_kg_co2e`;
- `water_liters`;
- `region`;
- `measurement_method`;
- `remediation_usd`;
- `remediation_targets`.

Values MUST be serialized as decimal strings where fractional precision matters. The method used to estimate or measure energy, carbon, and water MUST be named. Routers SHOULD prefer measured node telemetry when available and MAY use category/model benchmarks when direct telemetry is unavailable.

Environmental lines are accounting records. They do not by themselves prove that remediation has occurred. Implementations that route funds to remediation programs SHOULD publish separate remittance records linking batch identifiers to fund transfers or grants.

---

## 9. Public settlement records

Public settlement records MUST make the following information auditable:

- which event identifiers were settled;
- which event type each identifier represents;
- which category each event belongs to;
- which contributor received HDCT;
- how much HDCT was minted;
- which verifier accepted the event;
- which batch included the event;
- which environmental line was attached to inference events.

Public settlement records MUST NOT include raw prompts, raw completions, private client identifiers, private contributor documents, private review notes, or secrets. If a regulator, auditor, or governance process requires access to protected material, that access MUST be handled outside the public settlement record.

---

## 10. JSON schemas

The JSON schemas under `spec/schemas/aiisp-2/` are normative for AIISP-2 Draft v0.1:

- `inference-request.schema.json`
- `inference-response.schema.json`
- `settlement-event.schema.json`
- `settlement-batch.schema.json`
- `environmental-line.schema.json`
- `node-manifest.schema.json`
- `contribution.schema.json`
- `dpo-pair.schema.json`

Examples under `examples/aiisp-2/` SHOULD validate against these schemas.

---

## 11. Compatibility with AIISP-1

AIISP-1 remains in this repository as a historical and provider-facing draft for request-cost disclosure by centralized inference providers. AIISP-2 is not a minor revision of AIISP-1. It changes the counterparty model from provider disclosure to contributor-aligned routing and settlement.

An implementation MAY support both AIISP-1 and AIISP-2. If both are supported, the implementation MUST NOT mix AIISP-1 recurring creator-share language into AIISP-2 HDCT issuance records. AIISP-2 issuance remains event-based only.

---

## 12. Security and abuse considerations

### 12.1 Duplicate minting

Duplicate minting is the primary settlement failure mode. The settlement contract MUST reject duplicate `event_id` values, and routers SHOULD derive event identifiers from stable inputs such as chain domain, event type, category, contributor, subject reference, and verifier acceptance record.

### 12.2 Node fraud

A node may claim work it did not serve or misreport usage. Routers SHOULD bind serving evidence to observed request and response data, sample node outputs, maintain node reputation, and require verifiable signatures. Conformance tests SHOULD include duplicate evidence and malformed evidence cases.

### 12.3 Contribution fraud

Accepted data and DPO records depend on verifier quality. Verifiers SHOULD check rights, consent, category fit, duplicate submissions, policy compliance, and data quality. AIISP-2 only specifies the settlement consequence of acceptance; it does not make every accepted record legally or scientifically valid.

### 12.4 Privacy

Public settlement is intentionally narrow. Implementations MUST NOT store raw prompts, raw completions, private data submissions, or DPO text on-chain. Hashes and registry references SHOULD be used where auditability is needed.

### 12.5 Environmental claims

Environmental lines can be gamed by optimistic telemetry, stale regional factors, or unsupported remediation claims. Implementations SHOULD publish methodology versions, rate sources, and batch-level remediation remittance records.

---

## 13. Reference implementation expectations

The reference implementation directories in this repository describe the MIT-licensed implementation targets:

- `reference/contracts/` for the HDCT token and settlement contract;
- `reference/router/` for the HTTP router and batch writer;
- `reference/node/` for a minimal inference-node adapter;
- `reference/conformance/` for schema, duplicate-mint, routing, and settlement tests.

The reference implementation SHOULD target Base Sepolia or a local test chain first, then Base mainnet only after public review.

---

## Appendix A. Minimal inference example

```http
POST /v2/inference HTTP/1.1
Host: router.example.hdc
Content-Type: application/json
X-AIISP-Category: writing
X-AIISP-Settlement: batch
```

```json
{
  "messages": [
    {"role": "user", "content": "Draft a short grant summary."}
  ],
  "temperature": 0.2,
  "max_tokens": 512
}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json
X-AIISP-Category: writing
X-AIISP-Model: writing/hsc-small-2026-05-01@sha256:8d7c...
X-AIISP-Node: did:pkh:eip155:8453:0x1234...
X-AIISP-Settlement-Event: evt_01jv2writing0001
X-AIISP-Settlement-Batch: batch_2026-05-01T12-00Z_001
```

```json
{
  "id": "chatcmpl_aiisp2_001",
  "object": "chat.completion",
  "model": "writing/hsc-small-2026-05-01@sha256:8d7c...",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "This project will..."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 12,
    "completion_tokens": 64,
    "total_tokens": 76
  },
  "aiisp": {
    "version": "aiisp-2",
    "category": "writing",
    "node": "did:pkh:eip155:8453:0x1234...",
    "settlement_event": "evt_01jv2writing0001",
    "settlement_batch": "batch_2026-05-01T12-00Z_001"
  }
}
```

---

## Appendix B. Revision history

### Draft v0.1 - May 2026

Initial AIISP-2 draft for the HDC v2 proposal. Defines contributor-aligned routing, inference nodes, category models, accepted contribution events, verified inference served events, settled inference units, DPO events, environmental lines, and event-based HDCT issuance.
