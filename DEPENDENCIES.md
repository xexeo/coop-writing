# Dependency policy

`coop-writing.dtx` and `coop-writing.ins` are the canonical sources. Dependencies are kept only when they implement a feature that is part of the package itself; integrations with external PDF/navigation packages are opt-in.

## Required packages

| Package | Why it remains |
|---|---|
| `xcolor` | collaborator colors, configurable editorial colors, anonymization highlighting and themes |
| `soul` | short inline highlighting used by the legacy comment/subject API |
| `ulem` | strikeout rendering for legacy removals and editing-mode changes |
| `etoolbox` | compatibility layer used by the historical API for empty/string/command checks |
| `mdframed` | inline TODO boxes, draft blocks and long-form revision blocks |

All five are exercised through the regression suite and/or maximal examples.

## No longer required

The v1.8 modernization removes mandatory use of:

- `tocloft`: editorial lists now use private auxiliary files and do not modify the class ToC/LoF/LoT implementation;
- `hyperref`: never loaded automatically; integration is opportunistic when the document loads it;
- `iflang`: translated strings are selected dynamically by the package's own EN/PT-BR table;
- `environ`: body-capturing environments use the LaTeX kernel document-command interface;
- `csquotes`: it was not required by the package implementation;
- `xstring`: TODO option handling no longer needs it;
- `verbatim`: the only package-loading branch was unreachable.

## Optional integrations

- `hyperref`: safe bookmarks and hyperlink helpers, only when already loaded by the document.
- `pdfcomment`: PDF annotation backend, only when explicitly loaded/requested. A missing backend degrades to normal rendering with a package warning rather than forcing a dependency.

## Policy

New mandatory dependencies require a regression test showing the functionality they provide. The package must not load a package merely to modify global document formatting; the document class remains authoritative for headings, page styles, bibliography, ToC/LoF/LoT and floats.
