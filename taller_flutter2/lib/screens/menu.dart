import 'package:flutter/material.dart';
import 'package:taller_flutter2/screens/residentes.dart';

import 'listar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Residentes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InterfazResidentes()),
              );
            },
          ),
          ListTile(
            title: const Text('Visitantes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UniversalApi()),
              );
            },
          ),
        ],
      ),
    );
  }
}