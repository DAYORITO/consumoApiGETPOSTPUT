import 'package:flutter/material.dart';
import 'package:taller_flutter2/services/api_service.dart';
import 'package:taller_flutter2/witgets/vehiculos/cartasvehi.dart';

class ListarVehiculos extends StatefulWidget {
  const ListarVehiculos({super.key});

  @override
  State<ListarVehiculos> createState() => _ListarVehiculosState();
}

class _ListarVehiculosState extends State<ListarVehiculos> {
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ApiVisitantes().fetchData('vehiculo/');
    return List<Map<String, dynamic>>.from(datos['vehiculo']);
  }
  void actualizarDatos() {
    setState(() {
      futureData = _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehículos')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Map<String, dynamic>> vehiculos =
            snapshot.data as List<Map<String, dynamic>>;
            return ConstruirListaDeCartasVehi(vehiculos: vehiculos, actualizarDatos: actualizarDatos);
          }
        },
      ),
    );
  }
}
