# Decomposing Widgets

## Project Setup

```bash
flutter create projectname
```

### Strip Down

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center (
      child: Text(
        "Hello Flutter!",
        textDirection: TextDirection.ltr,
      )
    )
  );
}
```


| Widget       | Type               | Purpose                                                 |
| ------------ | ------------------ | ------------------------------------------------------- |
| **`Text`**   | **Display widget** | Shows a line of text (“Hello, Flutter!”) on the screen. |
| **`Center`** | **Layout widget**  | Positions its child widget at the center of the screen. |


#### Widget Types

| Category              | Description                                    | Examples                              |
| --------------------- | ---------------------------------------------- | ------------------------------------- |
| **Stateless Widgets** | Do not change once built.                      | `Text`, `Icon`, `Center`, `Container` |
| **Stateful Widgets**  | Can update their appearance when data changes. | `Checkbox`, `Slider`, `TextField`     |


A StatelessWidget is a Flutter widget that does not change once it’s built — its appearance and data stay the same for the lifetime of the widget.

**Decompose to `StatelessWidget`**

Put in `lib/widgets/my_app.dart`;

```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello, Flutter!',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
```

Import as:

```dart
import 'widgets/my_app.dart';
```

### Exercise 2

1. Create a stateless widget called `footer`
2. Footer has a property called `text`
3. Put `Footer` after `TopBanner` using a component called `Column`:

```dart
body: Column([
    TopBanner(title: "My Cedula App"),
    Footer(text: "My footer text")
])
```
