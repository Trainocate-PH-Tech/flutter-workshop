import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  // Properties
  final String title;

  // Constructor
  const TopBanner({super.key, required this.title});

  // build function
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}