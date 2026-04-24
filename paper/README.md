# Paper

This directory mirrors the source of the public-comment paper for the **Human
Data Collective** and the **AIISP-1** standard, so that editorial pull requests
against the paper itself can be opened here in the same repository as the spec.

Files:

- `human-data-collective.pdf` — typeset, primary
- `human-data-collective.tex` — LaTeX source
- `human-data-collective.md`  — Markdown companion (kept in parity with the .tex)
- `generate-latex.sh`         — `pdflatex × 3` build script

The paper's public home, with section-by-section commentary, is
<https://humandatacollective.org>.

## Editorial PRs

Open a PR against this directory for prose, citation, or structural
suggestions. For substantive specification changes that affect AIISP-1 itself,
prefer a PR against `../aiisp-1.md` or the
[tracking issue](https://github.com/97115104/aiisp-spec/issues/1).

## Building

```bash
./generate-latex.sh human-data-collective
```

Requires a TeX Live distribution that includes `pdflatex` and the standard
`tikz`, `amsmath`, `natbib`, and `hyperref` packages.

## Licence

Paper content: CC BY 4.0. The build script and any code helpers: MIT.
