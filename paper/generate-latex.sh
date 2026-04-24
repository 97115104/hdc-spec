#!/usr/bin/env bash
# generate-latex.sh — build human-data-collective.pdf from the .tex source.
# Usage: ./generate-latex.sh [basename]
#   basename defaults to "human-data-collective"
# Run from any directory; the script cd's to its own location.

set -euo pipefail

BASENAME="${1:-human-data-collective}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ ! -f "${BASENAME}.tex" ]]; then
  echo "error: ${BASENAME}.tex not found in ${SCRIPT_DIR}" >&2
  exit 1
fi

if ! command -v pdflatex >/dev/null 2>&1; then
  echo "error: pdflatex not found on PATH (install MacTeX or TeX Live)" >&2
  exit 1
fi

echo "==> cleaning aux files"
rm -f "${BASENAME}".{aux,toc,out,log,bbl,blg,fls,fdb_latexmk}

# The bibliography is embedded inline via \begin{thebibliography}, so bibtex is
# NOT needed. Three pdflatex passes resolve TOC + cross-references + citations.
for pass in 1 2 3; do
  echo "==> pdflatex pass ${pass}/3"
  pdflatex -interaction=nonstopmode -halt-on-error "${BASENAME}.tex" > "/tmp/${BASENAME}-pass${pass}.log" 2>&1 || {
    echo "error: pdflatex failed on pass ${pass}. Tail of log:" >&2
    tail -n 40 "/tmp/${BASENAME}-pass${pass}.log" >&2
    exit 1
  }
done

PAGES=$(pdfinfo "${BASENAME}.pdf" | awk '/^Pages:/ {print $2}')
ERRORS=$(grep -c '^! ' "${BASENAME}.log" || true)
UNDEF_CIT=$(grep -c -i 'Citation .* undefined' "${BASENAME}.log" || true)
UNDEF_REF=$(grep -c -i 'Reference .* undefined' "${BASENAME}.log" || true)
OVERFULL=$(grep -c 'Overfull \\hbox' "${BASENAME}.log" || true)

echo
echo "==> build ok: ${BASENAME}.pdf (${PAGES} pages)"
echo "    errors: ${ERRORS}  undefined cites: ${UNDEF_CIT}  undefined refs: ${UNDEF_REF}  overfull hboxes: ${OVERFULL}"

# Clean intermediates but keep .pdf and .log.
rm -f "${BASENAME}".{aux,toc,out,bbl,blg,fls,fdb_latexmk}
