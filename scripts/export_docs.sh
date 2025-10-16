#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOCS_DIR="$ROOT_DIR/docs"
DIST_DIR="$ROOT_DIR/dist"

mkdir -p "$DIST_DIR"

PLAN_MD="$DOCS_DIR/Plan.md"
PLAN_HTML="$DIST_DIR/Plan.html"
PLAN_DOCX="$DIST_DIR/Plan.docx"
PLAN_PDF="$DIST_DIR/Plan.pdf"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc not found. Attempting to install via apt..." >&2
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y && sudo apt-get install -y pandoc
  else
    echo "apt-get not available; please install pandoc manually." >&2
    exit 1
  fi
fi

# Convert Markdown to HTML and DOCX
pandoc "$PLAN_MD" -o "$PLAN_HTML" --standalone --metadata title="LLMLearning Plan"
pandoc "$PLAN_MD" -o "$PLAN_DOCX" --standalone --metadata title="LLMLearning Plan"

# Try to create PDF via wkhtmltopdf if available
if command -v wkhtmltopdf >/dev/null 2>&1; then
  # Convert markdown → html (with basic CSS) then to PDF
  pandoc "$PLAN_MD" -o "$PLAN_HTML" --standalone --css=https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown.min.css || true
  wkhtmltopdf "$PLAN_HTML" "$PLAN_PDF" || true
else
  # Try weasyprint
  if command -v weasyprint >/dev/null 2>&1; then
    pandoc "$PLAN_MD" -o "$PLAN_HTML" --standalone || true
    weasyprint "$PLAN_HTML" "$PLAN_PDF" || true
  else
    echo "PDF skipped: neither wkhtmltopdf nor weasyprint available." >&2
  fi
fi

echo "Artifacts written to $DIST_DIR:" >&2
ls -l "$DIST_DIR"