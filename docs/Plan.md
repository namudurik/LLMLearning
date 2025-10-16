---
# Project Plan: LLMLearning

## Title
LLMLearning – Hands-on Notebooks for Modern NLP

## Summary
LLMLearning is a set of practical Jupyter notebooks that teach foundational and applied NLP with large language models. This plan defines scope, milestones, and deliverables to publish a high-quality, exportable learning resource.

## Goals
- Deliver clear, runnable notebooks for core NLP topics
- Provide evaluation-driven exercises and solutions
- Make materials exportable as HTML, DOCX, and (best-effort) PDF
- Establish contribution and review workflows

## Non‑Goals
- Hosting a production API or web app
- Training massive models from scratch

## Success Metrics
- ≥ 5 notebooks pass CI execution without errors
- ≥ 80% of exercises include solutions
- Exportable formats generated on CI for each release tag

## Audience
- Practitioners with Python basics and interest in NLP/LLMs

## Scope & Deliverables
- Notebook series:
  1. Introduction to Language Models
  2. Text Classification (Classical + Transformer)
  3. Prompting & In‑Context Learning
  4. Retrieval‑Augmented Generation (RAG)
  5. Evaluation & Guardrails
- Repository docs:
  - README with quickstart
  - CONTRIBUTING guide
  - Changelog
- Export artifacts per release: HTML, DOCX, PDF (best‑effort)

## Milestones & Timeline
- M1 – Repo hygiene and baseline notebooks (Week 1)
- M2 – Add exercises + solutions and tests (Week 2)
- M3 – Export pipeline and release v0.1 (Week 3)

## Risks & Mitigations
- Dependency churn: Pin versions; cache builds.
- PDF rendering inconsistencies: Prefer HTML/DOCX; mark PDF as best‑effort.
- Notebook execution time: Use small datasets and caching.

## Architecture Overview
- Jupyter notebooks executed via nbconvert
- Export via Pandoc (md → html/docx, html → pdf when wkhtmltopdf/WeasyPrint available)
- Makefile/Script to orchestrate exports

## Workflows
- Development: Branch per feature, PR with CI run of notebooks
- CI: Execute notebooks (smoke), build exports, attach artifacts on tags

## Installation & Tooling
- Python 3.10+
- pandoc >= 3.1
- wkhtmltopdf (optional for PDF) or weasyprint (optional)

## Export Instructions
Use the provided script to generate artifacts:

```
bash scripts/export_docs.sh
```

Artifacts will be written to `dist/`.

## Open Questions
- Which PDF engine is more stable in CI? (wkhtmltopdf vs WeasyPrint)
- Should we include a minimal dataset snapshot?
