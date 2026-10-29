# Master Specification

## Product
Premium self-service numerology app; no consultation/appointment workflow.

## Calculation architecture
Calculation -> normalized result -> interpretation knowledge pack -> report renderer. Never mix hard-coded UI text with calculation logic.

## Locked framework
Cheiro compound framework 1–52 (owner-approved; roots 1–9 plus compound numbers 10–52). Do not implement 1–54 or 1–98. Raw totals remain available; interpretation mapping must be explicit rather than clamping a total into 1–52.

## Modules
Profile, Core Numbers, Compound Numbers, Lo Shu, Name Correction, Mobile, Vehicle, Business, Partnership Compatibility, Profession Intelligence, Date Selection, Baby Names, Predictions, Remedies, Gemstones, Q&A, AI Numerologist, Learn, Timeline, Report Builder, Client Vault, Privacy Vault, localization, signed knowledge updates.

## Privacy
Customer records local-only by default. No customer cloud database. Production encryption must use authenticated encryption with random nonce/IV per record and secure key storage. Raw PII should not be sent to a remote AI provider without explicit user consent.

## PDF
Page 1 premium cover/snapshot. Page 2 disclaimer + methodology. Subsequent pages are modular. YouTube page link for NikhilVGulatii. App WhatsApp number must not appear in PDF.

## Commercial model (updated 17 Oct 2026 to the latest owner-approved prices)
- Standard report: Rs 100 per PDF report.
- Annual subscription: Rs 250 per year, covering all app features plus unlimited PDF creation, download and printing during the active year.
- This replaces the earlier model (everything free, PDF Rs 50). Real payments are not implemented yet. When they are, they must use Google Play Billing with purchase verification, acknowledgement, restore and expiry handling; a client-side flag is never proof of payment.

## WhatsApp PDF Delivery
After a valid purchase (or active subscription) and generation of the professional PDF, the app must provide a direct "Send on WhatsApp" option. The generated PDF should be prepared as a local file and handed to the Android/iOS share system so WhatsApp can open with the PDF attached. The user must explicitly confirm/send the message. The app must not silently send WhatsApp messages or upload customer data to a cloud server.
