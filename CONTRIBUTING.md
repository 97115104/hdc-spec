# Contributing to AIISP-1

Thank you for taking the time to comment on the Artificial Intelligence Inference Standards Protocol. This document is published for open review, and substantive feedback is the primary input that will shape later drafts.

This repository has **two things you can contribute to**: the **spec** (`aiisp-1.md`) and the **companion paper** (`paper/human-data-collective.md`). Each has its own preferred channel.

---

## Contributing to the spec (aiisp-1.md)

### 1. Discuss on issue #1

The primary public discussion thread for AIISP-1 v0.1 is **[issue #1](https://github.com/97115104/aiisp-spec/issues/1)**. Reply there with prose comments, questions, alternative framings, or links to related work. No permission needed.

### 2. File a structured issue

For comments that benefit from being tracked individually, open a new issue using one of the templates:

- **Comment** — a specific objection, question, or suggestion against a numbered section of the spec.
- **Amendment** — a proposal for a new feature, header, or behaviour.
- **Errata** — a typo, broken link, arithmetic error, or factual mistake in the published draft.

### 3. Submit a pull request against the spec

For textual changes to [`aiisp-1.md`](./spec/aiisp-1.md), open a pull request directly. Pull requests should:

- Touch only one logical change per PR (typo fixes can be batched).
- Include a short rationale in the PR description, ideally referencing the issue that motivated it.
- Preserve the existing prose voice (long, comma-stitched, declarative; RFC 2119 keywords in normative sections).
- Update the **Revision history** appendix if the change is substantive.

---

## Contributing to the companion paper

*The Human Data Collective* is the long-form motivation document for AIISP-1. Its source lives in [`paper/`](./paper/) so that editorial pull requests go through the same workflow as the spec.

### Option A — comment at humandatacollective.org (no GitHub account needed)

The paper is published with inline section-level comments at **<https://humandatacollective.org>**. Select any span of text on the page and a composer will appear. Comments are public and threaded. This is the lowest-friction path for readers who do not want to use GitHub.

### Option B — open a pull request

The canonical source of the paper is the LaTeX file [`paper/human-data-collective.tex`](./paper/human-data-collective.tex). **Prefer editing `.tex` for anything involving figures, tables, diagrams, equations, or citation formatting**, since those are much cleaner to express in LaTeX than in Markdown. If you are not familiar with LaTeX, editing [`paper/human-data-collective.md`](./paper/human-data-collective.md) is an acceptable fallback — the editor will reconcile the Markdown diff into the `.tex` source before merging.

Pull requests to the paper should:

- Include a short rationale explaining the change.
- Cite sources for any new factual claims.
- Keep changes focused; one logical change per PR is preferred.

#### Building the PDF locally

Requires a TeX Live or MacTeX distribution (any modern install). From the repository root:

```bash
cd paper
./generate-latex.sh
```

This runs `pdflatex` three times to resolve cross-references and produces `paper/human-data-collective.pdf`. Pass a different basename as an argument if you are working on a renamed file:

```bash
./generate-latex.sh my-draft
```

If `pdflatex` is not on your PATH, install it with:

```bash
# macOS
brew install --cask mactex-no-gui

# Debian / Ubuntu
sudo apt install texlive-latex-extra
```

### Option C — file an errata issue

Factual errors, broken citations, or arithmetic mistakes in the paper can be filed as an [Errata issue](https://github.com/97115104/aiisp-spec/issues/new?template=errata.yml). Please note in the issue body whether the erratum is in the spec or the paper.

---

## What "substantive" means (spec)

A change is substantive if it would alter the behaviour of a conformant implementation. Substantive changes require either:

- Consensus on the discussion issue with no unresolved objections from the editor, or
- A pull request approved by the editor with a public rationale.

Non-substantive changes (typos, formatting, broken links, citation polish) can be merged on sight.

## Review timeline

The editor commits to acknowledging every issue and pull request within 14 days. A response is not the same as a merge or a closed issue; some discussions will remain open for months while the design space is explored.

## Provenance and attestation

Every accepted change to `aiisp-1.md` will be attested under the [`attest` v3](https://attest.97115104.com) specification and recorded in the spec's revision history. By contributing you agree that your contribution may be redistributed under the spec's [CC BY 4.0](./LICENSE) license and that your name and contribution may be recorded in the public attestation chain.

## Code of conduct

This project follows the [Contributor Covenant v2.1](./CODE_OF_CONDUCT.md). Participation in any project channel constitutes agreement to the Code of Conduct.

## Conflicts of interest

If you are an employee, contractor, or paid representative of any party that would be affected by this standard (frontier model providers, cloud operators, carbon or water credit registries, or labour platforms), please disclose that affiliation in your first comment on any thread. Disclosure does not disqualify a contribution; non-disclosure does.

## Contact

For private comments or for issues that should not be discussed in public, contact the editor at `x@97115104.com`.
