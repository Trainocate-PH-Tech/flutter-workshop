import 'package:cedula_app/components/contact_list.dart';
import 'package:cedula_app/components/top_banner.dart';
import 'package:flutter/material.dart';
import 'cedula/cedula_form_page.dart';
import 'components/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _App();  
}

class _App extends State<App> {
  int _selectedIndex = 0;
  String _selectedItem = "home";


  List<Widget> get _views => [
    Home(),
    CedulaFormPage(),
    ContactList()
  ];

  Map<String, Widget> menu = {
    "home": Home(),
    "cedula-form-page": CedulaFormPage(),
    "contact-list": ContactList()
  };

  @override
  Widget build(BuildContext context) {
    return (
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              TopBanner(title: "My Cedula app"),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _views[_selectedIndex]
                  // child: menu[_selectedItem]
                )
              )
            ]
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {

              String tmpSelected = "home";

              if (index == 0) {
                tmpSelected = "home";
              } else if (index == 1) {
                tmpSelected = "cedula-form-page";
              } else if (index == 2) {
                tmpSelected = "contact-list";
              }

              debugPrint("Selected Index: " + index.toString());
              debugPrint("Selected Menu Item: " + tmpSelected);

              setState(() {
                _selectedIndex = index;
                _selectedItem = tmpSelected;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Form"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Contacts")
            ]
          ),
        )
      )
    );
  }
}

