# Reference Conformance

The AIISP-2 conformance suite should verify the protocol behavior that matters for interoperability, settlement safety, and public audit. It should be runnable against local reference components and against independent implementations.

## Schema Cases

- Every JSON file in [`../../examples/aiisp-2/`](../../examples/aiisp-2/) validates against the matching schema in [`../../spec/schemas/aiisp-2/`](../../spec/schemas/aiisp-2/).
- Invalid decimal quantities are rejected where schemas require decimal strings.
- Invalid event types are rejected.
- Inference events without environmental lines are rejected.
- Node manifests missing required capability fields are rejected.

## Router Cases

- `POST /v2/inference` without `X-AIISP-Category` returns `aiisp_category_required`.
- Unknown categories return `aiisp_category_unknown`.
- Models outside the requested category return `aiisp_model_not_in_category`.
- Unavailable or unhealthy nodes return `aiisp_node_unavailable`.
- Successful responses include category, model, node, settlement event, and settlement batch identifiers.

## Settlement Cases

- Duplicate `event_id` settlement attempts are rejected.
- Accepted data contributions mint once.
- Verified inference served events mint once.
- Settled inference units mint once.
- Accepted DPO pairs mint once.
- Rejected data, rejected DPO pairs, failed inference, and old data reuse do not mint.
- Batch totals equal the sum of contained events.

## Privacy Cases

Public settlement records must not contain:

- raw prompt text
- raw completion text
- private data submissions
- private DPO text
- private client identifiers
- API keys, bearer tokens, cookies, or other secrets
- proprietary model weights

## Minimum Command Shape

The eventual conformance runner should support:

```sh
aiisp-conformance validate-examples
aiisp-conformance test-router --base-url http://127.0.0.1:8080
aiisp-conformance test-settlement --rpc-url http://127.0.0.1:8545
```
