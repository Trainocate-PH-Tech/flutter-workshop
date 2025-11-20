import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactList();
}

class _ContactList extends State<ContactList> {
  final List<Map<String, dynamic>> contacts = [
    { "id": 1, "firstName": "Raphael", "lastName": "Alampay", "mobileNumber": "123" },
    { "id": 2, "firstName": "Leonardo", "lastName": "Alampay", "mobileNumber": "345"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: Colors.blue,
            child: const Text(
              "Contacts",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child:ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return ListTile(
                  title: Text(contact["firstName"] + " " + contact["lastName"]),
                  subtitle: Text(contact["mobileNumber"])
                );
              }
            )
          )
        ]
      )
    );
  }
} 