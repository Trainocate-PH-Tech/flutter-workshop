# Deployment

## Android App

For an installable file, run the command:

```bash
flutter build apk --release
```

**Output:**

```bash
build/app/outputs/flutter-apk/app-release.apk
```

For Google Play  App Bundle (AAB):

```bash
flutter build appbundle --release
```

**Output:**

```bash
build/app/outputs/bundle/release/app-release.aab
```

## iOS

Use `flutter build ios` to compile a signed, ready-to-distribute binary for devices.

```bash
flutter build ios --release
```

**Output:**

```bash
build/ios/iphoneos/Runner.app
```

For uploading to App Store Connect you can generate an archive or IPA:

```bash
flutter build ipa --release
```

**Output:**

```bash
build/ios/ipa/Runner.ipa
```

If you prefer, open the `Runner.xcworkspace` in Xcode after building to archive the app and export it with your provisioning profile.

## Web

Create an optimized bundle for any static hosting provider.

```bash
flutter build web --release
```

**Output:**

```bash
build/web/
```

The resulting folder contains `index.html`, compiled JS/CSS assets, and can be served by Firebase Hosting, GitHub Pages, Amazon S3, etc.
