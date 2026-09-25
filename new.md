# What is new in coop-writing v1.8

**Release date:** 2026-09-23

Version 1.8 is the modernization release of `coop-writing`. It keeps the historical author/comment API source-compatible while adding a semantic editorial-workflow layer, reproducible releases, and regression-tested compatibility.

## Semantic editorial items

New work can use stable IDs and structured metadata:

```latex
\cwitem[id=method-1,type=comment,author=alice,severity=warning]
  {Explain the sampling strategy.}

\cwchange[id=method-change,author=alice]
  {old wording}{new wording}

\cwaccept{method-change}
\cwresolve{method-1}
```

Items can carry type, author, status, severity, parent/thread, style, layout, color, subtype, comment, date/version, source file/page, and PDF-backend policy.

The release adds selective accept/reject, resolve/reopen, author filtering, replies/threads, custom editorial types, named styles, long revision blocks, structured placeholders, document-state metadata, and named views independent from the editorial mode.

## Reports, reviewer response, errata, and tools

`\cwreport` provides detailed or summarized editorial reports and can filter by author, type, severity, and status.

Changes with stable IDs are written to a revision ledger for reviewer-response documents. The API includes `\cwloadrevisions`, `\cwrevisionref`, `\cwrevisionold`, `\cwrevisionnew`, and `\cwreviewresponse`.

Post-publication corrections use the same change infrastructure through `\cwerratum`. Errata can be persisted and loaded into a separate report document.

`\cwexport` writes versioned UTF-8 tabular metadata without requiring shell escape. `tools/cw-meta-to-json.py` converts that export to JSON. `tools/cw-materialize.py` creates a clean TeX source by accepting/rejecting semantic changes by ID, author, embedded status, or default policy; it supports dry-run diffs and never overwrites the source by default.

## Modes and configuration

The preferred package configuration is key/value based:

```latex
\usepackage[
  mode=editing,
  anonymize=false,
  comments=true,
  bookmarks=false
]{coop-writing}
```

Historical options remain aliases. Multiple main modes produce a warning and the last explicit mode wins.

Public predicates expose the active mode. `\cwsetup{...}` configures layout, theme, views, logging, placeholders, PDF annotation policies, author filters, document metadata, and colors.

Anonymization semantics and their editing-mode visual marking are now separate; `mark-anonymized=true|false` controls only the visual indication.

## Compatibility cleanup

`coop-writing` no longer loads `tocloft` or `hyperref`.

Editorial lists use package-private auxiliary files, eliminating the historical ordering/conflict problems with KOMA-Script, memoir, subfig, etoc, and publisher classes. `hyperref` integration is opportunistic when the document already loads it, and arbitrary comment mathematics is not copied into PDF bookmark strings.

The dependency audit also removed unnecessary `iflang`, `environ`, `csquotes`, `xstring`, and `verbatim` dependencies.

## TODOs, drafts, headings, and labels

`\todo{...}` is the compact default; `\todo[inline]{...}` is explicitly opt-in. Both participate in editorial lists, and `\listoftodos` is available.

`\cwdrafttext` and `\cwsaveforlater` complement the `cwdraft` environment. The Brazilian Portuguese `rascunho` environment is a real environment alias.

Labeled comments now reference their stable label text instead of the footnote number. `\cwheadingcomment` provides a safe heading/moving-argument form.

## Internationalization and UTF-8

Visible package strings are selected dynamically from symmetric English and Brazilian Portuguese tables. Sources are UTF-8, and both pdfLaTeX and LuaLaTeX are Tier-1 tested engines.

## Regression and compatibility testing

The repository now uses `l3build` with pdfTeX and LuaTeX, including development-kernel checks. Tests cover modes, semantic workflow, TODO/i18n, hyperref order and PDF strings, standard/memoir/KOMA classes, lists, filters, reports, views, errata, and external tools.

A separate compatibility workflow fetches the canonical UFRJ/COPPE/Poli classes on every run and probes representative publisher templates when available.

See:

- [Compatibility policy](COMPATIBILITY.md)
- [Dependency audit](DEPENDENCIES.md)
- [Issue-to-test resolution matrix](ISSUE-TEST-MATRIX.md)

## Canonical source and release process

`coop-writing.dtx` and `coop-writing.ins` are authoritative. CI regenerates the style from them before tests. `dist/`, PDFs, and CTAN staging are generated release artifacts. Historical duplicate source/style snapshots have been removed.

The CTAN workflow builds a single-top-level-directory submission archive and excludes the easily generated `.sty` from the CTAN ZIP when the `.dtx/.ins` pair is present.
