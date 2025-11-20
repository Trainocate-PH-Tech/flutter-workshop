import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './cedula_second_screen.dart';

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