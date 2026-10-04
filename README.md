# Cheiro Numerology — Premium

Offline-first Flutter foundation for a professional self-service numerology application.

## Locked product decisions
- Cheiro compound framework: **1–54** (not 1–98).
- Self-service app; no consultation/appointment/numerologist dashboard.
- Customer data stays local by default; no customer cloud database.
- Numerology features are free; professional downloadable PDF is the paid product (₹100).
- WhatsApp contact: 9210896940 (app UI footer only; not PDF).
- PDF watermark: @NikhilVGulatii.
- Architecture supports English/Hindi localization and future knowledge-pack updates.

## Important implementation note
This repository is a production-oriented foundation, not a claim that every requested knowledge interpretation is already exhaustive. The engine separates calculations from interpretation so the verified Cheiro/Chaldean knowledge pack can be expanded without rewriting the UI.

## Run
```bash
flutter pub get
flutter run
```
