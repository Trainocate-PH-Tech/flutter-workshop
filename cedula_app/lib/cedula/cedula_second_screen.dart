import 'package:flutter/material.dart';

class CedulaSecondScreen extends StatelessWidget {
  const CedulaSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Back to Home"),
          onPressed: () {
            Navigator.pop(context); // go back
          },
        ),
      ),
    );
  }
}