# Basic Stateful Widgets

## Overview

A stateful widget is a component that manages the values of its own properties. If you need dynamic content that the user interacts with, we use a stateful widget.

**Example Stateful Form Widget**

```dart
class SimpleFormWidget extends StatefulWidget {
  const SimpleFormWidget({super.key});

  @override
  State<SimpleFormWidget> createState() => _SimpleFormWidgetState();
}

class _SimpleFormWidgetState extends State<SimpleFormWidget> {
  final controller = TextEditingController();

  void submit() {
    debugPrint("User input: ${controller.text}");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(controller.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: controller),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: submit,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
```

## Explanation

1. The main class requires an overridden `createState()` which returns an instance of `State<T>` where `T` is a class of the same type.

```dart
class SimpleFormWidget extends StatefulWidget {
  const SimpleFormWidget({super.key});

  @override
  State<SimpleFormWidget> createState() => _SimpleFormWidgetState();
}
```

2. The `State<T>` is also defined inside the same file.

```dart
class _SimpleFormWidgetState extends State<SimpleFormWidget> {
    // ...
}
```

3. We can define a custom function `submit` which is inside the `State` class:

```dart
void submit() {
debugPrint("User input: ${controller.text}");
ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text(controller.text)));
}
```

4. We also have an instance of a `TextEditingController` which will serve as the value of the `controller` of the textfield.

```dart
final controller = TextEditingController();
```

Hooked up to `TextField`:

```dart
TextField(controller: controller),
```
