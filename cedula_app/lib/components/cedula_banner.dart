import 'package:flutter/material.dart';

class CedulaBanner extends StatelessWidget {
  // constructor
  // class CedulaBanner --> CedulaBanner()
  const CedulaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Hello Flutter!",
        textDirection: TextDirection.ltr,
      )
    );
  }
}