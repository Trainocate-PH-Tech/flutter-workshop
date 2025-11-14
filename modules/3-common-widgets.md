# Common Widgets

## Example Form

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CommonFormPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CommonFormPage extends StatefulWidget {
  const CommonFormPage({super.key});

  @override
  State<CommonFormPage> createState() => _CommonFormPageState();
}

class _CommonFormPageState extends State<CommonFormPage> {
  final _textController = TextEditingController();

  String? _dropdownValue;
  bool _checked = false;
  bool _switchValue = false;
  double _sliderValue = 20;
  String _radioValue = "A";
  DateTime? _selectedDate;

  void _handleSubmit() {
    final Map<String, dynamic> formValues = {
      "textField": _textController.text,
      "dropdown": _dropdownValue,
      "checkbox": _checked,
      "switch": _switchValue,
      "slider": _sliderValue,
      "radio": _radioValue,
      "date": _selectedDate?.toIso8601String(),
    };

    debugPrint("=== FORM VALUES ===");
    debugPrint(formValues.toString());
    debugPrint("====================");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Form Submitted! Check debugPrint output.")),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDate: now,
    );

    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Common Form Widgets")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TextField
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Select an option",
                border: OutlineInputBorder(),
              ),
              value: _dropdownValue,
              items: const [
                DropdownMenuItem(value: "Apple", child: Text("Apple")),
                DropdownMenuItem(value: "Banana", child: Text("Banana")),
                DropdownMenuItem(value: "Orange", child: Text("Orange")),
              ],
              onChanged: (value) => setState(() => _dropdownValue = value),
            ),

            const SizedBox(height: 20),

            // Checkbox
            CheckboxListTile(
              title: const Text("I agree to terms"),
              value: _checked,
              onChanged: (value) => setState(() => _checked = value!),
            ),

            const SizedBox(height: 20),

            // Switch
            SwitchListTile(
              title: const Text("Enable notifications"),
              value: _switchValue,
              onChanged: (value) => setState(() => _switchValue = value),
            ),

            const SizedBox(height: 20),

            // Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Volume: ${_sliderValue.toInt()}"),
                Slider(
                  min: 0,
                  max: 100,
                  value: _sliderValue,
                  onChanged: (value) =>
                      setState(() => _sliderValue = value),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Radio Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Choose a Group:"),
                RadioListTile(
                  title: const Text("Option A"),
                  value: "A",
                  groupValue: _radioValue,
                  onChanged: (value) =>
                      setState(() => _radioValue = value!),
                ),
                RadioListTile(
                  title: const Text("Option B"),
                  value: "B",
                  groupValue: _radioValue,
                  onChanged: (value) =>
                      setState(() => _radioValue = value!),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Date Picker
            Row(
              children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? "No date selected"
                      : "Selected: ${_selectedDate!.toLocal()}".split(' ')[0],
                ),
              ),
              ElevatedButton(
                onPressed: _pickDate,
                child: const Text("Pick Date"),
              ),
            ]),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
```

## `TextField`

```dart
TextField(
  controller: _textController,
  decoration: const InputDecoration(
    labelText: "Enter text",
    border: OutlineInputBorder(),
  ),
)
```

## `DropdownButtonFormField`

```dart
DropdownButtonFormField<String>(
  decoration: const InputDecoration(
    labelText: "Select an option",
    border: OutlineInputBorder(),
  ),
  value: _dropdownValue,
  items: const [
    DropdownMenuItem(value: "Apple", child: Text("Apple")),
    DropdownMenuItem(value: "Banana", child: Text("Banana")),
    DropdownMenuItem(value: "Orange", child: Text("Orange")),
  ],
  onChanged: (value) => setState(() => _dropdownValue = value),
)
```

## `Checkbox`

```dart
CheckboxListTile(
  title: const Text("I agree to terms"),
  value: _checked,
  onChanged: (value) => setState(() => _checked = value!),
)
```

## `Switch`

```dart
SwitchListTile(
  title: const Text("Enable notifications"),
  value: _switchValue,
  onChanged: (value) => setState(() => _switchValue = value),
)
```

## `Slider`

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Volume: ${_sliderValue.toInt()}"),
    Slider(
      min: 0,
      max: 100,
      value: _sliderValue,
      onChanged: (value) => setState(() => _sliderValue = value),
    ),
  ],
)
```

## `Radio Button`

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text("Choose a Group:"),
    RadioListTile(
      title: const Text("Option A"),
      value: "A",
      groupValue: _radioValue,
      onChanged: (value) => setState(() => _radioValue = value!),
    ),
    RadioListTile(
      title: const Text("Option B"),
      value: "B",
      groupValue: _radioValue,
      onChanged: (value) => setState(() => _radioValue = value!),
    ),
  ],
)
```

## `DatePicker`

```dart
Row(
  children: [
    Expanded(
      child: Text(
        _selectedDate == null
            ? "No date selected"
            : "Selected: ${_selectedDate!.toLocal()}".split(' ')[0],
      ),
    ),
    ElevatedButton(
      onPressed: _pickDate,
      child: const Text("Pick Date"),
    ),
  ],
)
```
