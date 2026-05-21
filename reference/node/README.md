# Reference Node

An AIISP-2 inference node serves category models on behalf of a contributor, the Collective, or another approved operator. The node adapter is responsible for publishing capabilities, serving eligible requests, and producing evidence that the router can settle.

## Manifest

Each node MUST publish a manifest conforming to [`../../spec/schemas/aiisp-2/node-manifest.schema.json`](../../spec/schemas/aiisp-2/node-manifest.schema.json).

The manifest includes:

- `node_id`
- `operator`
- `endpoint`
- `supported_categories`
- `supported_models`
- `settlement_wallet`
- `energy_region`
- `measurement_method`
- `software_version`
- optional `public_key`, `did_document`, `terms_url`, and `health_url`

## Serving Requirements

- Serve only registered models for categories listed in the node manifest.
- Expose a health endpoint suitable for router eligibility checks.
- Return serving evidence for completed inference work.
- Report measured or estimated environmental data using the manifest's declared measurement method.
- Sign serving evidence when the node has a public key or DID document.

## Serving Evidence

Serving evidence should include:

- router request identifier
- served model identifier
- node identifier
- token usage or settled unit count
- environmental line
- timestamp
- signature or equivalent authenticity proof

## Environmental Line

Every verified inference event or settled inference unit needs an environmental line conforming to [`../../spec/schemas/aiisp-2/environmental-line.schema.json`](../../spec/schemas/aiisp-2/environmental-line.schema.json). The node may provide measured values, model-benchmark values, node estimates, or registry defaults, but the method must be explicit.
