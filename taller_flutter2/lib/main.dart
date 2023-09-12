import 'package:flutter/material.dart';
import 'package:taller_flutter2/screens/login.dart';
import 'package:taller_flutter2/themes/tema_principal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThema().lightTheme,
      home: const Scaffold(
        body: Login()
      ),
    );
  }
}
