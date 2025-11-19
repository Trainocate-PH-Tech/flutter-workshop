# Modal Dialogs

Modal dialogs are good for showing alerts or confirming actions from a user

**Full Example**

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showConfirmDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Action"),
          content: const Text("Are you sure?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("OK"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Confirmed!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cancelled")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modal Example")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Show Confirm Dialog"),
          onPressed: () => _showConfirmDialog(context),
        ),
      ),
    );
  }
}
```

1. The function receives a BuildContext

This is needed because:

* The dialog must appear on top of your current screen.
* Navigator.pop() needs a context to close the modal.

```dart
void _showConfirmDialog(BuildContext context)
```

2. `showDialog` displays a modal

```dart
showDialog<bool>(
  context: context,
  builder: (context) { ... }
)
```

* The <bool> tells Flutter the dialog will return a boolean (true/false).
* The builder returns the UI of the dialog.

3. Building the dialog (UI)

It uses an `AlertDialog`

```dart
return AlertDialog(
  title: Text("Confirm Action"),
  content: Text("Are you sure?"),
  actions: [...]
);
```

* `title` → the heading
* `content` → the message inside the modal
* `actions` → the buttons at the bottom

4. Buttons close the dialog with a chosen value

**Cancel Button**

```dart
Navigator.pop(context, false);
```

**OK Button**

```dart
Navigator.pop(context, true);
```

5. Handling the user’s choice with `.then()`

After the dialog closes, `.then()` gets the result:

```dart
.then((value) {
  if (value == true) {
    // user picked OK
  } else {
    // user picked Cancel or closed dialog
  }
});
```

## Exercise

* On submission of form for adding a contact, ask the user to confirm first.
* If Yes, add the contact to the list
* If No, close the dialog
