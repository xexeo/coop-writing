# coop-writing LaTeX package v1.5.5

Copyright (c) 2024–2026 Geraldo Xexéo

**coop-writing** is a LaTeX package for managing the editorial life cycle of a document independently of the editing interface. Comments, proposed insertions/removals/replacements, TODOs, draft material, anonymization, and mode-dependent content remain in the LaTeX source, so the same workflow can be used in Overleaf, a local editor, or a Git-based collaboration process.

The package is designed around editorial modes such as `editing`, `submit`, `publish`, and `acceptingpublish`. The source remains authoritative while the generated document changes according to the stage of the editorial process.

## Documentation

For first use, start with:

- [Quick Reference — English (EN-US)](quickref-en-us.tex)
- [Maximal Example — English (EN-US)](max-example-en-us.tex)

Portuguese documentation:

- [Referência Rápida — Português do Brasil (PT-BR)](quickref-pt-br.tex)
- [Exemplo Máximo — Português do Brasil (PT-BR)](max-exemplo-pt-br.tex)

The full documented source/manual is available as [coop-writing.pdf](coop-writing.pdf), generated from [coop-writing.dtx](coop-writing.dtx).

## Minimal use

```latex
\usepackage[editing]{coop-writing}

\cwnamedef{alice}{blue}{Alice}

This sentence \alice{Please check this claim.} is being reviewed.

\aliceswap[Improve precision]
  {old wording}
  {new wording}
```

For a clean submission or publication build, change the main package mode rather than deleting editorial commands from the source.

## UTF-8 and engines

Project sources should be UTF-8. Current LaTeX uses UTF-8 as its default input encoding. The project is being organized to test **pdfLaTeX** and **LuaLaTeX** explicitly and to avoid deprecated interfaces where current LaTeX provides a maintained alternative.

## Repository layout

The root contains the current development source. Historically, `dist/`, `CTAN/`, and `tests/` have also contained generated or copied package files. The project is moving toward a single canonical source and reproducible generated artifacts; see the project issues for the proposed release/test refactoring.

## Development and compatibility

Compatibility with document classes is a primary project requirement. The proposed test matrix covers the standard LaTeX classes, `memoir`, KOMA-Script, major publisher templates, and the UFRJ/COPPE/Poli classes maintained on GitHub.

Please report incompatibilities with a minimal example and include:

- coop-writing version;
- LaTeX engine and TeX distribution;
- document class and version;
- package mode;
- the smallest source that reproduces the problem.

## Issues, suggestions, and discussions

Repository: https://github.com/xexeo/coop-writing

Issues: https://github.com/xexeo/coop-writing/issues

Discussions: https://github.com/xexeo/coop-writing/discussions

## License

This package is distributed under the MIT License.
