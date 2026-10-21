# Changelog

## Batch 1 — engine, knowledge pack, tests, CI

Status: written, NOT yet run. Flutter was not available where this batch was written, so `flutter analyze`, `flutter test` and the APK build have not been executed. The GitHub Actions workflow now runs analyze and test before building, so the first push will show real results.

### Changed
- `lib/core/numerology_engine.dart`: rewritten. Same public API as before (`name`, `date`, `mobile`, `vehicle`, `root`, `total`, `hasCheiroCompound`, `compoundMeaning`), plus letter-by-letter breakdown, list of ignored characters, original input, reduction chain, and `birth()` for psychic (day) and destiny (full date) numbers. Raw totals are never clamped. Reason: the spec asks for transparent, explainable, testable calculations.
- `lib/core/knowledge_pack.dart`: compound range corrected from 10-52 to 10-54 (roots 1-9 plus compounds 10-54 make up the locked 1-54 framework). Every entry now has its own title, summary, strengths, cautions, relationships, work, money and advice. All "Same essential interpretation as N" placeholders are gone. Each entry carries a status: 10-31 are traditional paraphrases, 32-54 are modern editorial guidance. Nothing is marked verified, because the Cheiro edition has not been chosen or checked. Reason: the spec forbids repeated placeholders and fabricated certainty.
- `lib/core/pdf_report.dart`: fixed a missing closing parenthesis in the original file (it would not compile). Reformatted; behaviour is the same one-page stub. Found by a bracket-balance check, not by the compiler.
- `.github/workflows/android-build.yml`: added steps to delete the default generated widget test, run `flutter analyze` (fails on errors only) and run `flutter test`. APK build and upload are unchanged.
- `docs/MASTER_SPEC.md`, `README.md`: pricing updated to Rs 100 per report / Rs 250 per year, as per the latest approved prompt. The old Rs 50 / everything-free text conflicted with it.

### Added
- `test/numerology_engine_test.dart`, `test/knowledge_pack_test.dart`.
- `CHANGELOG.md`.

### Known open items (not changed in this batch)
- `lib/core/local_vault.dart` builds its key from the clock and is NOT secure. It must be replaced with real authenticated encryption before any sensitive data is stored.
- `lib/core/pdf_report.dart` is a one-page stub.
- 11 screens are still 7-line placeholders showing "Module foundation ready".
- Android package name in `MainActivity.kt` (`com.numerologistnikhil.cheironumerology`) may not match what `flutter create` generates in CI. Needs a check on a real build.
- Home screen UI does not yet show breakdowns or the new entry fields.

## Batch 1b
- Removed unused root app.dart (dark duplicate of lib/core/app.dart; its broken import failed flutter analyze).
Batch 3: real screens for all modules, encrypted Client Vault (AES-256-GCM), multi-page PDF report, tests.
