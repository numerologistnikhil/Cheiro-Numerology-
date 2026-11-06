# Cheiro Numerology — Premium

Offline-first Flutter foundation for a professional self-service numerology application.

## Locked product decisions
- Cheiro compound framework: **1–52** (owner-confirmed; not 1–54, not 1–98).
- Self-service app; no consultation/appointment/numerologist dashboard.
- Customer data stays local by default; no customer cloud database.
- Pricing (owner-approved, 1 Nov 2026): the first report is a free sample; Rs 50 per detailed PDF report (download, print and share included); Rs 250 per year removes ads. All app features are free. Payments and ads are NOT implemented yet (see docs/STATUS.md).
- WhatsApp contact: 9210896940 (app UI footer only; not PDF).
- PDF watermark: @NikhilVGulatii.
- Architecture supports English/Hindi localization and future knowledge-pack updates.

## Important implementation note
This repository is a production-oriented foundation, not a claim that every requested knowledge interpretation is already exhaustive. The engine separates calculations from interpretation so the verified Cheiro/Chaldean knowledge pack can be expanded without rewriting the UI.

## Status
See `docs/STATUS.md` for an evidence-based list of what is written, pushed, built and tested on a device.

## Run
```bash
flutter pub get
flutter run
```
