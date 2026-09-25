# coop-writing — Version history

This file records the functional history of `coop-writing`. The version/date entries are derived from the documented source (`coop-writing.dtx`) and expanded here to make the evolution of the package clearer to users.

## v1.8 — 2026-09-23

A consolidated modernization of the complete editorial workflow.

### Added
- Structured semantic editorial items with stable IDs, type, author, status, severity, source location, relationships, style/layout and backend metadata.
- Selective accept/reject and resolve/reopen decisions, persisted by ID.
- Author include/exclude and accept/reject/hide policies.
- Threads/replies and long revision blocks.
- User-defined editorial types and named reusable styles.
- Structured placeholders with configurable final-mode policy.
- Named views/profiles independent from the main editorial mode.
- Document status/submission/restriction metadata.
- Detailed and summary editorial reports with filters.
- Pending-item logging policies.
- Optional PDF annotation policies with global, type and item precedence.
- Cross-document revision ledger and reviewer-response commands.
- Persistent post-publication errata ledger and standalone errata reporting.
- Versioned UTF-8 metadata export plus JSON conversion tool.
- External UTF-8 source materializer with ID/author decisions and dry-run mode.
- Automatic deterministic collaborator colors and centralized color configuration.
- `\listoftodos`, author-specific TODOs, `\cwdrafttext`, `\cwsaveforlater`, `\cwinline`, current-file helpers, mode predicates, and safe heading comments.
- English and Brazilian Portuguese quick references and maximal executable examples.
- `l3build` regression suite for pdfTeX/LuaTeX plus development-kernel checks.
- Automated compatibility matrix for standard/memoir/KOMA classes, canonical UFRJ/COPPE/Poli classes, and publisher templates when installed.
- Reproducible `dist/` and CTAN staging generation.
- `changes.md`, `new.md`, `DEPENDENCIES.md`, `COMPATIBILITY.md`, and issue-to-test traceability.

### Changed
- Preferred configuration uses key/value package options and `\cwsetup`; historical options remain compatible aliases.
- Main modes are formalized as editing, submit, publish, and acceptingpublish. Conflicting explicit modes warn; the last one wins.
- Presentation is separated from semantic type through layout/theme/style/backend configuration.
- Anonymization and editing-mode anonymization marking are independent controls.
- Visible strings use dynamic symmetric EN/PT-BR localization.
- Editorial lists are package-private and no longer modify the class's ToC/LoF/LoT machinery.
- Generated style/distribution/CTAN artifacts derive from canonical `coop-writing.dtx` + `coop-writing.ins`.
- Historical duplicate CTAN/source/style snapshots are removed from active development/testing.

### Fixed
- `\todo{...}` is compact by default; `\todo[inline]{...}` is explicit.
- Unknown TODO options warn instead of silently changing layout.
- TODOs and citation-needs participate in the appropriate editorial lists.
- Labeled comments reference the semantic label rather than the footnote number.
- `hyperref` is no longer auto-loaded, avoiding bibliography/template side effects.
- Comment mathematics is not serialized into unsafe PDF bookmark strings.
- Removed the mandatory `tocloft` dependency and its conflicts with KOMA-Script, memoir, subfig, etoc and publisher classes.
- Removed unnecessary `iflang`, `environ`, `csquotes`, `xstring`, and dead `verbatim` dependencies.
- Corrected `cwavoidhyperref` legacy handling and prior conditional errors.
- Portuguese `rascunho` is a complete environment alias.
- UTF-8 documentation and examples are tested in both supported engines.

## v1.5.5 — 2026-09-23

Release-preparation update immediately preceding the v1.8 consolidation.

- Fixed the default TODO behavior so that inline TODO boxes are not the default.
- Fixed `hyperref` conditional handling.
- Fixed the `cwavoidhyperref` option typo.
- Updated the documentation setup for UTF-8 and current LaTeX engines.
- Added the first reproducible CTAN release staging workflow and release documentation.
- Removed the TODO code path's dependency on `xstring`.

## v1.5.4 — 2025-06-16

- Added inline TODO entries to the list of comments, so inline tasks participate in the editorial overview.

## v1.5.3 — 2024-11-18

- Added editing-mode color handling to `\cwinput` and `\cwinclude` so mode-dependent included material is visually identifiable while editing.

## v1.5.2 — 2024-11-18

- Fixed the option-name clash with publisher/class options such as MDPI's `submit`.
- Improved behavior when options that should normally be exclusive are encountered together.
- Reworked nested conditional handling.
- Improved the package's `hyperref` interaction.

## v1.5.1 — 2024-02-09

- Restricted the text-color helper functionality to editing mode, preventing editorial coloring from leaking into clean builds.

## v1.5 — 2024-02-09

- Added commands to change text color temporarily and restore the previous color.
- Introduced the `\cwcolor` / save / restore color workflow used by later mode-dependent features.

## v1.4.4 — 2024-02-09

- Replaced the obsolete `soulutf8` dependency with current `soul`, improving compatibility with modern LaTeX and UTF-8 handling.

## v1.4.3 — 2022-06-17

- Added default editorial comments to suggestion and removal commands, making those operations usable without always supplying an explicit comment.

## v1.4.2 — 2022-06-17

- Added editing-mode visual marking for citations that will be anonymized in blind-submission mode.

## v1.4.1 — 2022-06-14

- Added editing-mode visual marking for ordinary text that will be anonymized, allowing authors to see what will disappear or be replaced in a blind submission.

## v1.4 — 2022-06-12

- Added mode-dependent file inclusion.
- Introduced the `\cwinput` and `\cwinclude` family so different source fragments can be selected for editing, submission, and publication builds.
- Added specialized editing/submit/publish input/include commands.

## v1.3.3 — 2022-06-06

- Changed option precedence so explicit `anonymize` / `noanonymize` choices are stronger than the defaults implied by editorial modes.

## v1.3.2 — 2022-06-06

- Fixed anonymized citation behavior.

## v1.3.1 — 2022-05-13

- Fixed interaction between TODOs and publication mode.

## v1.3 — 2022-04-21

- Added `\cwblind`, allowing a command to expand differently in normal and anonymized contexts.
- Strengthened support for blind-review workflows.

## v1.2.4 — 2022-01-13

- Applied corrections required for the CTAN distribution.

## v1.2.3 — 2021-06-09

- Added compatibility work for **CoppeTeX**, particularly around the way lists of figures/tables interact with the table of contents through `tocloft`.

## v1.2.2 — 2021-06-06

- Added compatibility work for the **memoir** class and classes built on it, including the ABNT-oriented ecosystem.
- Added defensive handling around `tocloft` behavior emulated by memoir.

## v1.2.1 — 2021-06-05

- Fixed editorial footnote-mark coloring.
- Restored the document/class footnote-mark behavior after coop-writing comments, avoiding permanent interference with `\@makefnmark`.

## v1.2.0 — 2021-05-30

- Added `\cwmain` for explicitly marking the main idea of a paragraph.
- Added configuration for the visual treatment of the main-idea marker.

## v1.1.2 — 2021-05-30

- Added/adjusted handling for limitations of full UTF-8 content in PDF bookmarks.

## v1.1.1 — 2021-05-30

- Fixed early package bugs.
- Restored anonymization behavior in the manual/documentation workflow.

## v1.1 — 2021-05-30

- Added support for an additional configurable symbol before comment superscript numbers, making editorial comments more visible.

## v1.0 — 2021-05-29

Initial public version.

Core functionality established in the first release included the basic editorial-comment workflow that later evolved into the current package: comments embedded in the LaTeX source, collaborator-oriented review, clean publication output, and support for collaborative academic writing.

---

The canonical implementation history remains in `coop-writing.dtx`. This file is the user-facing release history and may contain expanded explanations of the terse `\changes` entries in the documented source.
