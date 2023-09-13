import 'package:flutter/material.dart';
import 'package:taller_flutter2/screens/residentes.dart';
import 'package:taller_flutter2/screens/vehiculos.dart';

import 'listar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Residentes', textAlign: TextAlign.center,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InterfazResidentes()),
                );
              },
            ),
            ListTile(
              title: const Text('Visitantes', textAlign: TextAlign.center,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UniversalApi()),
                );
              },
            ),
            ListTile(
              title: const Text('Vehiculos', textAlign: TextAlign.center,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListarVehiculos()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}