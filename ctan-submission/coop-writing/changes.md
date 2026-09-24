# coop-writing — Version history

This file records the functional history of `coop-writing`. The version/date entries are derived from the documented source (`coop-writing.dtx`) and expanded here to make the evolution of the package clearer to users.

## v1.8 — 2026-09-23

A consolidated editorial-workflow release focused on making the package easier to use, test, document, and distribute.

### Added
- English quick reference: `quickref-en-us.tex`.
- Brazilian Portuguese quick reference: `quickref-pt-br.tex`.
- Maximal English example exercising the public API: `max-example-en-us.tex`.
- Maximal Brazilian Portuguese example: `max-exemplo-pt-br.tex`.
- Mode-dependent example fragments used by the maximal examples.
- Documentation smoke tests with **pdfLaTeX** and **LuaLaTeX**.
- Reproducible CTAN staging and archive generation.
- Explicit installation and maintainer information in the README.
- `changes.md` with the complete release history.
- `new.md` with only the current release notes.

### Changed
- The package is documented explicitly as an interface-independent editorial layer: editorial information remains in the LaTeX source and can be used from Overleaf, local editors, or Git-based workflows.
- Documentation sources are UTF-8 and no longer require `inputenc` with current LaTeX.
- CTAN packaging is generated from canonical project sources rather than maintained as an independent copy.
- The generated `coop-writing.sty` is regenerated from `coop-writing.dtx`/`coop-writing.ins` in the release workflow.
- Version-history entries in the documented source consistently use the `v` prefix.

### Fixed
- `\todo{...}` is the compact/default TODO form.
- `\todo[inline]{...}` is explicitly opt-in for the framed inline form.
- Unknown TODO options produce a warning and fall back to the default comment style.
- Corrected malformed conditional logic around automatic `hyperref` loading.
- Corrected the `cwavoidhyperref` option implementation.
- Removed the unnecessary `xstring` dependency from the TODO implementation path.

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
