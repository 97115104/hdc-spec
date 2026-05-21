# Reference Contracts

The AIISP-2 contract reference design covers the HDCT token and a settlement contract that records accepted protocol events. The center of the design is duplicate-event rejection: one accepted AIISP-2 event may mint HDCT once, and only once.

## Contracts

| Contract | Role |
| --- | --- |
| `HDCTToken` | ERC-20-compatible token used by the reference stack on local chains and Base-compatible deployments. |
| `AIISPSettlement` | Settlement registry that accepts verified events, records event identifiers, emits settlement events, and mints HDCT. |
| `AIISPBatchWriter` | Optional helper that submits batch metadata and forwards accepted events into `AIISPSettlement`. |

## Required State

- `usedEventIds[event_id]` records every accepted event identifier.
- `batchTotals[batch_id]` records aggregate HDCT and event counts for public audit.
- `authorizedRouters[address]` limits settlement submission to approved routers or verifiers.
- `supportedEventTypes` is limited to `accepted_data_contribution`, `verified_inference_served`, `settled_inference_unit`, and `accepted_dpo_pair`.

## Settlement Rules

- The settlement contract MUST reject an event if `event_id` was already accepted.
- The settlement contract MUST reject an event type outside the AIISP-2 issuance set.
- The settlement contract MUST NOT mint for rejected data, rejected DPO pairs, failed inference, policy-blocked inference, or old data reuse.
- Public events MUST expose `event_id`, `event_type`, `category`, `contributor`, `hdct_amount`, and `batch_id`.
- Public events MUST NOT expose raw prompts, completions, private submissions, private DPO text, client secrets, or proprietary model weights.

## Minimal Interface

```solidity
function settleEvent(
    bytes32 eventId,
    bytes32 eventType,
    bytes32 category,
    address contributor,
    uint256 hdctAmount,
    bytes32 batchId,
    bytes32 subjectRef
) external;

function isEventSettled(bytes32 eventId) external view returns (bool);
```

## Test Requirements

- Settling the same `event_id` twice reverts.
- Unsupported `event_type` values revert.
- Authorized routers can settle events; unauthorized callers cannot.
- Zero-address contributors and zero HDCT amounts are rejected unless a future spec explicitly permits them.
- Batch totals match the sum of settled events.
- Contract logs contain only audit-safe identifiers and hashes.
