# Reference Router

The AIISP-2 router is the HTTP boundary between ordinary model clients, registered category models, inference nodes, verifiers, and settlement. It should make AIISP-2 usable without forcing clients to learn a new model-response format.

## Request Path

1. Receive `POST /v2/inference`.
2. Require `X-AIISP-Category`.
3. Validate the request body against [`../../spec/schemas/aiisp-2/inference-request.schema.json`](../../spec/schemas/aiisp-2/inference-request.schema.json).
4. Resolve the category to an eligible model and inference node.
5. Dispatch the request to the node.
6. Receive model output and serving evidence.
7. Create a settlement event and add it to the current settlement batch.
8. Return an ordinary model-response object with AIISP-2 headers and/or an `aiisp` response object.

## Required Headers

| Header | Direction | Meaning |
| --- | --- | --- |
| `X-AIISP-Category` | request and response | Category selected for routing and settlement. |
| `X-AIISP-Model` | response | Category model served. |
| `X-AIISP-Node` | response | Inference node that served the request. |
| `X-AIISP-Settlement-Event` | response | Event identifier for settlement. |
| `X-AIISP-Settlement-Batch` | response | Batch identifier containing the event. |

## Failure Cases

- Missing category returns `aiisp_category_required`.
- Unknown category returns `aiisp_category_unknown`.
- Requested model outside category returns `aiisp_model_not_in_category`.
- Unavailable node returns `aiisp_node_unavailable`.
- Failed settlement returns `aiisp_settlement_unavailable`.
- Policy rejection returns `aiisp_policy_rejected`.

## Privacy Requirements

The router MUST NOT write raw prompts, completions, private client identifiers, secrets, or undisclosed contributor data into public settlement records. Public settlement records should use hashes, content-addressed references, registry identifiers, or encrypted references.

## Batch Writer

The batch writer should publish records conforming to [`../../spec/schemas/aiisp-2/settlement-batch.schema.json`](../../spec/schemas/aiisp-2/settlement-batch.schema.json). For AIISP-2 Draft v0.1, a batch record should become public no later than 24 hours after the batch closes.
