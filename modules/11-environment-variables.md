# Environment Variables

* **Environment Variable**: Value used by the application but specified on compile or runtime and not hard coded
* **Usecase**: Have a variable (`API_BASE_URL`) to be injected a value based on some configuration (`.env`) to your flutter app

## Step 1: Add dependency

In your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

## Step 2: Add to `flutter` section as an asset:

```yaml
flutter:
  assets:
    - .env
```

Afterwards run:

```bash
flutter pub get
```

## Step 3: Create a `.env` file

```yaml
API_URL=http://localhost/todo/api.php
```

## Step 4: Load in Dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
```

## Step 5: Read Variable

```dart
final apiUrl = dotenv.env['API_URL'];
```
