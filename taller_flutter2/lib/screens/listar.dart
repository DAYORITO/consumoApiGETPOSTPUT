import 'package:flutter/material.dart';
import 'package:taller_flutter2/services/api_service.dart';
import 'package:taller_flutter2/witgets/modalAgregar.dart';

import '../witgets/cartas.dart';

class UniversalApi extends StatefulWidget {
  const UniversalApi({super.key});

  @override
  State<UniversalApi> createState() => _UniversalApiState();
}

class _UniversalApiState extends State<UniversalApi> {
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ApiVisitantes().fetchData("");
    return List<Map<String, dynamic>>.from(datos['visitantes']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visitantes')),
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
            final List<Map<String, dynamic>> visitantes =
                snapshot.data as List<Map<String, dynamic>>;
            return ConstruirListaDeCartas(visitantes: visitantes);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalAgregar();
      },
    );
  },
  child: const Icon(Icons.add),
),
    );
  }
}
