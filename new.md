# What is new in coop-writing v1.8

**Release date:** 2026-09-23

Version 1.8 consolidates `coop-writing` as a LaTeX editorial-workflow layer whose source remains independent of the editing interface. A project can keep comments, proposed changes, TODOs, draft material, anonymization rules, and mode-dependent content in LaTeX while being edited in Overleaf, locally, or through Git.

## Documentation and usability

The release adds concise quick references in English and Brazilian Portuguese and maximal examples in both languages. The maximal examples exercise the public command families and also act as smoke tests. The README now explains installation, supported workflows, maintainer information, and where to start.

All documentation sources are UTF-8. The documentation is automatically compiled with both **pdfLaTeX** and **LuaLaTeX**.

## TODO behavior

The default TODO behavior is intentionally compact:

```latex
\todo{Check this argument.}
```

creates the ordinary editorial TODO/comment form.

The large framed form is explicitly requested:

```latex
\todo[inline]{Rewrite this paragraph.}
```

Unknown TODO options generate a package warning and fall back to the compact/default behavior.

## hyperref fixes

The release fixes malformed TeX conditional logic in the code that handles `hyperref` loading. It also fixes the `cwavoidhyperref` package option, whose implementation previously missed the command escape and therefore did not reliably activate the intended boolean.

These are compatibility fixes; broader redesign of optional bookmark/PDF-comment behavior remains tracked separately in the project issues.

## Dependency cleanup

The TODO implementation no longer needs `xstring` for a simple option comparison. It now uses functionality already available through `etoolbox`, reducing unnecessary package dependencies.

## Reproducible CTAN packaging

The CTAN submission is generated rather than maintained as an independent source tree. The release workflow:

- regenerates `coop-writing.sty` from `coop-writing.dtx` and `coop-writing.ins`;
- compiles the manual and user documentation;
- stages only the files needed for CTAN;
- excludes easily generated `.sty` and ordinary build artifacts from the CTAN archive;
- creates a single-top-level-directory ZIP;
- removes stale ZIPs from previous versions.

This preserves the project rule that the documented source is authoritative.

## Release documentation

Two release-oriented files are maintained at the repository root:

- `new.md` — only the current release;
- `changes.md` — the complete version history from v1.0 onward.

For the full history, see [changes.md](changes.md).
