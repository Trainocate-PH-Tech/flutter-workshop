# Setup

## Creating a new project

```bash
flutter create [projectname]
```

Example:

```bash
flutter create cedula_app
```

**Open Project in VSCode**

```bash
cd cedula_app
```


```bash
code .
```

If opening from VSCode, go to `Open Folder`

## Creating a Barebones Application

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    Center(
      child: Text(
        "Hello Flutter!",
        textDirection: TextDirection.ltr,
      )
    )
  );
}
```

* Functions start with small letter
* Classes start with capital letter
* Classes can have properties. Example:

```dart
Center(text: "test")
```

* `text`: property of class `Center`
* `test`: value of property `text`


```dart
Text("Hello Flutter", textDirection: TextDirection.ltr);
```

* `"Hello Flutter"`: Argument to the class
* `textDirection`: property of class `Text`
* `TextDirection.ltr`: value of `textDirection` property












