# HDC-1 v0.1 — Public review and comment thread

> **Specification:** [`hdc-1.md`](https://github.com/97115104/hdc-spec/blob/main/hdc-1.md) · **Rendered:** <https://97115104.github.io/hdc-spec/> · **Status:** Draft (v0.1, April 2026) · **Editor:** Austin Harshberger ([`x@97115104.com`](mailto:x@97115104.com)) · **License:** CC BY 4.0 (text), MIT (reference code)

This issue is the **primary public-comment thread** for HDC-1, the first specification in the Human Data Collective standards family. It defines a minimal, opt-in HTTP standard for declaring and settling the energy, environmental, and human-attribution components of a single LLM inference request.

The draft is published in the spirit of the early internet RFCs: short, composable, opt-in, and owned by no single party. It is **not** a ratified standard. It is a starting point that I am circulating openly so that the people most affected by its decisions can shape it before any frontier provider, regulator, or contributor pool is asked to commit to anything.

---

## How to comment

Please use the channel that fits your comment. All four are read.

| If you want to… | Use this |
| --- | --- |
| Add a general comment, question, or reaction | Reply on this thread |
| File a structured objection against a numbered section | [New **Comment** issue](https://github.com/97115104/hdc-spec/issues/new?template=comment.yml) |
| Propose a substantive amendment, new header, or new behaviour | [New **Amendment** issue](https://github.com/97115104/hdc-spec/issues/new?template=amendment.yml) |
| Report a typo, broken link, or arithmetic error | [New **Errata** issue](https://github.com/97115104/hdc-spec/issues/new?template=errata.yml) |
| Suggest specific text | Open a [Pull Request](https://github.com/97115104/hdc-spec/pulls) against `hdc-1.md` |
| Comment privately (conflict of interest, security) | Email the editor at [`x@97115104.com`](mailto:x@97115104.com) |

If you are commenting in a professional capacity or on behalf of an organization that would be affected by this standard (frontier provider, infrastructure operator, regulator, civil-society group, worker organization), please **disclose that affiliation in your comment**. The structured templates ask for this explicitly. See [`CONTRIBUTING.md`](https://github.com/97115104/hdc-spec/blob/main/CONTRIBUTING.md) and [`GOVERNANCE.md`](https://github.com/97115104/hdc-spec/blob/main/GOVERNANCE.md) for the full process.

---

## What HDC-1 specifies, in one paragraph

A Client opts a request into HDC settlement by sending an `X-HDC-Token` header carrying the Provider's Branded Inference Token (BIT) address. The Provider, on the response, returns a base64url-encoded JSON `X-HDC-Cost` record breaking the request's price into four named lines (energy, environmental, premium, total) plus a fifth `hdc.share_usd` line, and either settles the corresponding amounts on-chain immediately (`realtime`) or batches them at a published cadence (`deferred`). Distribution of the HDC share to creator, peer-reviewer, and operations pools happens atomically inside an on-chain settlement contract on Base. Providers that do not implement the standard are unaffected; clients that do not implement it are unaffected; the wire format is designed to be added to any existing HTTP inference API in a single afternoon.

Full normative text is in [`hdc-1.md`](https://github.com/97115104/hdc-spec/blob/main/hdc-1.md). A worked end-to-end example for a 1,000-token request is in Appendix A of the spec.

---

## Open questions where reviewer input is most needed

The draft has known gaps. Comments on any of the points below are explicitly invited; please file them as structured **Comment** or **Amendment** issues so they can be tracked and resolved into the next revision.

### 1. Consent and the people whose work is the subject of the spec

The motivating harms cited in the companion paper draw on documented cases in the Atacama desert, the Cerrillos community, and the Kenyan content-moderation workforce. The standard, as currently written, does not include a consent mechanism for the contributors and communities whose labour and resources it would route money to. **Should HDC-1 require, as a launch condition, an opt-in attestation from a contributor before any settlement is performed against work attributed to them, and what does that mechanism look like at scale?**

### 2. Who sets the 80 / 5 / 15 split

The `hdc.split` object in Section 5 is currently asserted at `creators 0.80 / reviewers 0.05 / operations 0.15`. These numbers were chosen by the editor. **The standard does not yet specify the body that has authority to change them.** Should the split be set by:

- a contributor-pool vote weighted by attested contributions,
- a multi-stakeholder body with reserved seats (worker organization, environmental organization, frontier implementer, OSS implementer, academic, editor) per the [`GOVERNANCE.md`](https://github.com/97115104/hdc-spec/blob/main/GOVERNANCE.md) plan,
- a specified standards body (W3C, IETF, DIF), or
- some combination?

### 3. Settlement-currency choice and global-south access

Settlement on Base in stablecoins is convenient for the editor and lowers gas, but it presupposes that a contributor or affected community has access to a Base-compatible wallet, on-ramp infrastructure, and either tax-resident status in a friendly jurisdiction or a willing intermediary. **For contributors and communities for whom that is not true, HDC-1 currently has no answer.** Comments are invited on (a) acceptable fiat-bridge architectures, (b) recipient-led grant pathways for the Water Credit Fund where no Water Restoration Certificate supply exists in the affected watershed, and (c) whether a non-crypto settlement track should be specified as an additional binding mode.

### 4. Recourse when a Provider misbehaves

Section 8.1 (spoofed cost records) contemplates audit by sampling. It does not yet specify a dispute mechanism, a revocation procedure for a Provider's BIT registration that has been due-process-tested, or the body that adjudicates disputes. **Comments on procedural fairness, evidentiary standards, and revocation pathways are invited.**

### 5. The forcing function

The draft asserts that the forcing function for adoption is the data, not the regulation, namely that providers will adopt because Collective-curated data is the only meaningfully fresh, attested, categorized supply. **This is a hypothesis. Reviewers who think it is wrong, or who think regulation, capital, or some other mechanism is the binding constraint, are encouraged to push back.**

### 6. Reference implementation and conformance

Section 10 commits to a reference implementation and a conformance suite, both pending. Comments on the test surface (which arithmetic checks, schema checks, on-chain settlement checks should be conformance-required versus advisory) are invited now so the test suite can be designed against community input.

---

## Comment window

This thread is open indefinitely. Substantive comments received **on or before 2026-06-22** will be reflected in HDC-1 v0.2, which will be circulated as a separate issue with a diff against v0.1. Earlier amendments may land in interim editorial drafts; see [`CHANGELOG.md`](https://github.com/97115104/hdc-spec/blob/main/CHANGELOG.md).

---

## Disclosure

The editor (Austin Harshberger) is the principal of Happy Stack Calculus LLC, which intends to operate the reference implementation of HDC-1 and to act as the initial on-chain settlement infrastructure operator. This is a present and ongoing conflict of interest. The medium-term plan, documented in [`GOVERNANCE.md`](https://github.com/97115104/hdc-spec/blob/main/GOVERNANCE.md), is to migrate ratification authority for HDC-1 v1.0 and beyond to a multi-stakeholder body before the standard is declared stable. The editor's compensation, once any settlement flows exist, will be published on the same on-chain ledger as contributor compensation.

---

## How to cite this draft

```bibtex
@misc{hdc1spec2026,
  author       = {Harshberger, Austin},
  title        = {HDC-1: The Human Data Collective Inference Transparency Standard},
  year         = {2026},
  month        = apr,
  howpublished = {\url{https://github.com/97115104/hdc-spec}},
  note         = {Draft v0.1; public review at \url{https://github.com/97115104/hdc-spec/issues/1}}
}
```

GitHub also surfaces a "Cite this repository" button via [`CITATION.cff`](https://github.com/97115104/hdc-spec/blob/main/CITATION.cff).

---

Thank you for reading. Pushback is the point.

— Austin
