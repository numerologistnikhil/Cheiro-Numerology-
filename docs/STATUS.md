# Ank Dhara: evidence-based status

Last checked: 5 Nov 2026, from the git history of `main` and the source code. GitHub Actions run numbers could not be read by the author, so build results are listed as "not verified" unless the owner confirmed them.

Legend: **Written** = code exists in a patch. **Pushed** = commit is on `main`. **Built** = a GitHub Actions run went green for that commit. **Device-tested** = the owner ran it on an Android phone and reported the result.

## Product rules (final)
- Cheiro compound range: 10 to 52 (roots 1 to 9).
- All features free; first report is a free sample; Rs 50 per report; Rs 250 per year removes ads.
- Owner-chosen PDF footer lines and PDF colour palettes are not changed by documentation or by new features.

## Feature status
| Feature | Written | Pushed (commit) | Built | Device-tested |
|---|---|---|---|---|
| 10 colour themes | yes | yes: 2ca5f5d, refined 49cfd5f | not verified | owner saw themes; look after 49cfd5f not reported |
| Lucky Number Kit and house/flat number | yes | yes: c3a35ea, 8896596 | a build with it ran on the owner's phone (screenshot, 1 Nov); run number not known | tile seen; calculations not reported |
| Heavy number 35 warning | yes | yes: 49cfd5f | not verified | no |
| Gemstone guide | yes | yes: e2ed6d5 | not verified | no |
| Rudraksha guide | yes | yes: 77b6a42 | not verified | no |
| Date Selection reasons, Learn lessons | yes | yes: 04b78d7 | not verified | no |
| Bilingual quiz | yes | yes: 2554c68 | not verified | no |
| Western chart, setup screen, health and precautions, famous people | yes | no (sent as fix26 to fix29, not yet pushed) | no | no |

## Payments, ads, security
| Item | Status |
|---|---|
| Google Play Billing | Not started. No billing library in `pubspec.yaml`; `Pricing.billingConnected = false`. |
| Purchase verification (server side) | Not started. No backend. |
| AdMob and consent form | Not started. No ads library, no app id. |
| Free-report and credit counters | Stored in SharedPreferences on the phone; can be reset by clearing data or reinstalling. Not a secure entitlement. |
| Client Vault encryption | Written and pushed (AES-256-GCM, random key in secure storage). No unit test. Not device-tested. |
| Profile (name, date of birth, mobile, house, vehicle) | Stored as plain text in SharedPreferences. Not encrypted. |
| PIN or fingerprint lock | Not implemented (the `local_auth` library is listed but not used). |

## Build and release
- Workflow `.github/workflows/android-build.yml` runs analyze, tests, builds a release APK and uploads the artifact `ankdhara-release` (`app-release.apk`).
- It builds an APK only. There is no AAB and no release signing. The APK is signed with `debug.keystore`, which is public in the repository.
- Latest verified successful build: not known to the author. Last confirmed green run on the Actions page seen by the reviewer: #39 (commit 67bab51, 28 Oct). The owner should open Actions, pick the newest green run and note its number.
- The Android folder in the repository only holds `MainActivity.kt`; the rest is generated in CI with `flutter create`, so the application id is not controlled by the repository.

## Release blockers
1. Release signing: create an upload key, keep it in GitHub Secrets, build an AAB.
2. Fix the application id (it must not be `com.example...`), and make `MainActivity.kt` match it.
3. Play Console developer account (US$25 card fee), identity check, and closed testing with 12 testers for 14 days.
4. Google Play Billing with server-side purchase verification, restore and expiry.
5. AdMob with the consent form, and no ads for subscribers.
6. Privacy policy page, Data safety form, account and data deletion information.
7. Move free-report and purchase state out of editable local storage.
8. Encrypt the profile, add vault tests, decide on PIN or fingerprint.
9. Verified green build for the newest commit, then testing on at least two real phones, including the PDF (English and Hindi) and print preview.
10. Content: compound-number texts are marked "traditional paraphrase" or "modern guidance", not verified Cheiro text. The store description must not promise accurate predictions.
11. Support contact decision (owner does not want to publish a personal email or number) and removing personal contact details from README if they should not be public.
12. Pin the Flutter version in the workflow so builds are repeatable.

## Update 7 Nov 2026 (fix34)
- Package name decided: `com.ankdhara.numerology` (set in CI after `flutter create`). Not yet verified by a green build.
- Upload key created (kept outside the repo by the owner). CI builds a signed AAB only when the 4 GitHub Secrets exist. Not yet verified.
- Privacy policy draft: docs/PRIVACY_POLICY.md (needs a public URL and a support email).
- Still open: Play Console account, AdMob, Billing, consent, encryption.
