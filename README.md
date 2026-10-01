# Cheiro Numerology — Flutter starter

This is a runnable Flutter prototype, not a finished Play Store release.

## Included
- Dark navy / gold UI
- Name and date-of-birth input
- Birth number, life-path number, and Chaldean-style name-number calculations
- Starter symbolic interpretations
- Name analysis screen
- Traditional guidance/remedies screen
- More tools screen with roadmap notes

## Run
1. Install Flutter and Android Studio.
2. From this directory run `flutter pub get`.
3. Run `flutter run` with an Android device or emulator connected.

## Important product notes
- This starter uses a simple digit-reduction method and a Chaldean-style letter mapping. It needs review against the exact Cheiro source rules before being marketed as an authoritative Cheiro implementation.
- The predictions, compatibility, Lo Shu grid, annual forecast automation, saved profiles, PDF export, bilingual localization, AI, payments, analytics, and backend are not implemented yet.
- Do not present numerology as scientifically validated or as guaranteed outcomes.
- Before publishing, add a privacy policy, data-handling disclosures, app icon, store assets, tests, and Google Play compliance checks.

## Build an Android test APK using a phone
This project includes `codemagic.yaml` for a cloud build. You can do the setup in a mobile browser:
1. Create/sign in to a GitHub account and create a new repository.
2. Upload the contents of this ZIP (not the ZIP itself) to the repository root. Keep `pubspec.yaml`, `codemagic.yaml`, `README.md`, and the `lib` folder at the root.
3. Create/sign in to Codemagic and connect the GitHub repository.
4. Start the `android-debug` workflow. It generates the Android platform folder, builds a debug APK, and makes the artifact available if the build succeeds.
5. Download the APK artifact to your Android phone and install it. You may need to allow installs from your browser or file manager.

This workflow is for testing only. A Play Store release requires a release build, signing, store listing, privacy disclosures, and Play policy review. Do not publish the debug APK.
