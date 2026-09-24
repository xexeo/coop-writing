# CTAN release staging

This directory is generated/prepared for a CTAN update of `coop-writing`.

- `SUBMISSION.md` contains the fields for the CTAN upload form and is **not** included in the archive.
- `coop-writing/` is the unpacked package directory.
- `coop-writing-<version>.zip` is the upload archive and contains exactly one top-level directory, `coop-writing/`.
- `tools/build-ctan.sh` recreates the package directory and ZIP from the repository sources and freshly compiled documentation.

Do not edit files inside `ctan-submission/coop-writing/` manually. Make changes in the canonical project sources and rebuild the CTAN staging directory.
