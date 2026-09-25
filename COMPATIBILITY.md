# Compatibility policy

`coop-writing` is an editorial layer, not a document-formatting layer. Compatibility therefore means that it can add editorial metadata and rendering without taking ownership of class-controlled structures such as headings, bibliography, page styles, ToC/LoF/LoT and floats.

## Supported — release blocking

These combinations are exercised automatically in CI with both pdfLaTeX and LuaLaTeX.

### Core classes

- `article`
- `report`
- `book`
- `memoir`
- KOMA-Script: `scrartcl`, `scrreprt`, `scrbook`

The core class checks are l3build regressions, not merely compile tests.

### UFRJ / COPPE / Poli

The compatibility workflow fetches the canonical class sources for every run instead of using copied snapshots:

- COPPE v5 compatibility class from `COPPE-UFRJ/CoppeTeX`, branch `V05-unificada`;
- UFRJ class from `COPPE-UFRJ/CoppeTeX`, branch `goufrj`;
- Poli v5 compatibility class from `COPPE-UFRJ/CoppeTeX`, branch `V05-unificada`;
- the current effective class in `xexeo/PoliTeX`.

These checks are intentionally outside the source tree so institutional class updates are detected rather than masked by stale local copies.

## Tested when available in the TeX Live image

The compatibility workflow also probes representative publisher/template families:

- `IEEEtran`
- `acmart`
- `elsarticle`
- `cas-sc`
- `llncs`
- `sn-jnl`
- MDPI
- `revtex4-2`
- `beamer`
- `iosart2x`
- the historical SBC template bundled in the repository when its class/style can be extracted

If a class is not installed, the job reports it as skipped. If it is installed and the coop-writing smoke document fails, the workflow fails.

## Dimensions checked

The regression and compatibility jobs jointly cover:

- editing/submit/publish/acceptingpublish;
- pdfLaTeX and LuaLaTeX;
- real UTF-8 text;
- comments, stable IDs and references;
- insertion/removal/replacement;
- compact and inline TODO;
- drafts and block revisions;
- anonymization and configurable marking;
- editorial lists without `tocloft`;
- headings/moving arguments;
- hyperref absent and present;
- bibliography-sensitive load order;
- semantic status, severity, filters, views, reports and export.

Every newly discovered incompatibility should add a regression case before the fix is merged.
