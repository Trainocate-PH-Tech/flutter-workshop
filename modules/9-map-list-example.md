# Map List Example

## `cedula_form.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './cedula_second_screen.dart';
import 'package:cedula_app/data.dart';

class CedulaForm extends StatefulWidget {
  const CedulaForm({super.key});

  @override
  State<CedulaForm> createState() {
    return _CedulaFormState();
  }
}

class _CedulaFormState extends State<CedulaForm> {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final grossInputController = TextEditingController();
  

  String firstName = "";
  String lastName = "";
  String? gender = "Male";
  String address = "";
  DateTime? dateOfBirth;
  double gross = 0.0;
  bool isEmployed = false;
  bool isProfessional = false;
  String? region = "";
  String? city = "";

  void submit(BuildContext context) {
    // String firstName = controller.text;
    setState(() {
      firstName = firstNameTextController.text;
      lastName = lastNameTextController.text;
      if (grossInputController.text.isNotEmpty) {
        gross = double.parse(grossInputController.text);
      } else {
        gross = 0.0;
      }
    });

    Map<String, dynamic> payload = {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "address": address,
      "isEmployed": isEmployed,
      "isProfessional": isProfessional,
      "gross": gross
    };
    debugPrint("Payload: $payload");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CedulaSecondScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return (
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstNameTextController,
              decoration: InputDecoration(
                labelText: "First Name",
              )
            ),
            SizedBox(height: 20),
            TextField(
              controller: lastNameTextController,
              decoration: InputDecoration(
                labelText: "Last Name"
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Gender"
              ),
              initialValue: gender,
              items: [
                DropdownMenuItem(value: "", child: Text("")),
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (value) => setState(() => gender = value),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Region"
              ),
              initialValue: region,
              items: toDropdownMenuItemList(
                toListFromKey(
                  List<Map<String, dynamic>>.from(locations["regions"]), "name"
                )
              ),
              onChanged: (value) => setState(() => region = value),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "City"
              ),
              initialValue: city,
              items: toDropdownMenuItemList(
                getCitiesFromRegion(region)
              ),
              onChanged: (value) => setState(() => city = value),
            ),
            SizedBox(height: 20),
            TextField(
              controller: grossInputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Gross"
              ),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text("Is Employed?"),
              value: isEmployed, 
              onChanged: (value) => setState(() => isEmployed = value!)
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text("Is Professional?"),
              value: isProfessional, 
              onChanged: (value) => setState(() => isProfessional = value)
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => submit(context),
              child: Text("Submit")
            )
          ]
        )
      )
    );
  }
}
```

## `data.dart`

```dart
import 'package:flutter/material.dart';

Map<String, dynamic> locations = {
  "regions": [
    { 
      "name": "NCR", 
      "cities": [
        "Manila",
        "QC",
        "Makati"
      ] 
    },
    {
      "name": "Region 1",
      "cities": [
        "Pampanga",
        "Bulacan"
      ]
    },
    {
      "name": "Region 2",
      "cities": [
        "Laguna",
        "Cavite"
      ]
    }
  ]
};

List<String> getCitiesFromRegion(String? region) {
  List<String> cities = [];

  for (Map<String, dynamic> item in locations["regions"]) {
    if (item["name"].toString() == region) {
      cities = item["cities"];
    }
  }

  return cities;
}

List<String> toListFromKey(List<Map<String, dynamic>> items, String key) {
  List<String> values = [];

  for (Map<String, dynamic> item in items) {
    values.add(item[key].toString());
  }

  return values;
}

List<DropdownMenuItem<String>> toDropdownMenuItemList(List<String> items) {
  List<DropdownMenuItem<String>> values = [];

  values.add(DropdownMenuItem(value: "", child: Text("")));

  for (String item in items) {
    values.add(DropdownMenuItem(value: item, child: Text(item)));
  }

  debugPrint("Items: " + values.length.toString());

  return values;
}
```
