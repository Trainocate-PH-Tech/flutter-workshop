# Environment Variables

* **Environment Variable**: Value used by the application but specified on compile or runtime and not hard coded
* **Usecase**: Have a variable (`API_BASE_URL`) to be injected a value based on some configuration (`.env`) to your flutter app

## Step 1: Add dependency

```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

## Step 2: Create a `.env` file

```yaml
API_URL=http://localhost/todo/api.php
```

## Step 3: Load in Dart

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
```

## Step 4: Read Variable

```dart
final apiUrl = dotenv.env['API_URL'];
```
