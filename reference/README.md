# AIISP-2 Reference Design

This directory describes the MIT-licensed reference implementation target for AIISP-2. The code is not normative unless a later specification revision explicitly says so; the normative protocol text remains [`../spec/aiisp-2.md`](../spec/aiisp-2.md), and the normative Draft v0.1 schemas remain [`../spec/schemas/aiisp-2/`](../spec/schemas/aiisp-2/).

The reference design is split into four implementation surfaces:

| Surface | Purpose | Primary requirement |
| --- | --- | --- |
| [`contracts/`](./contracts/) | HDCT token and settlement contract behavior | mint once per accepted AIISP-2 event and reject duplicate `event_id` values |
| [`router/`](./router/) | HTTP request router, category selection, node dispatch, and batch writing | preserve ordinary model-call ergonomics while producing auditable AIISP-2 settlement records |
| [`node/`](./node/) | Inference-node adapter and manifest behavior | publish node capabilities, serve eligible category models, and sign serving evidence |
| [`conformance/`](./conformance/) | Schema, routing, duplicate-event, settlement, and privacy tests | verify implementations against AIISP-2 Draft v0.1 behavior |

## Implementation Sequence

1. Validate all examples in [`../examples/aiisp-2/`](../examples/aiisp-2/) against the JSON schemas.
2. Implement the router request path for `POST /v2/inference`.
3. Implement node manifests, health checks, and serving-evidence signatures.
4. Implement local-chain settlement with duplicate-event rejection.
5. Add conformance cases for schema validity, routing failures, settlement failures, and privacy redaction.
6. Run the same conformance suite against a local test chain and then Base Sepolia.

## Non-Normative Status

Reference code may make conservative implementation choices that are stricter than the specification. Conformant implementations should be judged against the active spec and schemas, not against incidental implementation details in this directory.
