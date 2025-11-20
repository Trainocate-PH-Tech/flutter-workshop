import 'package:flutter/material.dart';
import '../components/top_banner.dart';
import '../components/footer.dart';
import './cedula_form.dart';

class CedulaFormPage extends StatelessWidget {

  const CedulaFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: CedulaForm()
              )
            )
          ]
        )
      )
    );
  }
}