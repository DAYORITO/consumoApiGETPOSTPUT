import 'package:flutter/material.dart';
import 'package:taller_flutter2/services/api_service.dart';
import 'package:taller_flutter2/witgets/residentes/cartasResidentes.dart';
import 'package:taller_flutter2/witgets/residentes/modalAgregarResi.dart';


class InterfazResidentes extends StatefulWidget {
  const InterfazResidentes({super.key});

  @override
  State<InterfazResidentes> createState() => _InterfazResidentesState();
}

class _InterfazResidentesState extends State<InterfazResidentes> {
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _cargarDatos();
  }

  Future<List<Map<String, dynamic>>> _cargarDatos() async {
    final datos = await ApiVisitantes().fetchData('residentes/');
    return List<Map<String, dynamic>>.from(datos['residentes']);
  }
  void actualizarDatos() {
    setState(() {
      futureData = _cargarDatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Residentes')),
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
            final List<Map<String, dynamic>> residentes =
                snapshot.data as List<Map<String, dynamic>>;
            return ConstruirListaDeCartasResi(informacion: residentes, actualizarDatos: actualizarDatos);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ModalAgregarResi();
            },
          ).then((value) => setState(() {
                futureData = _cargarDatos();
              }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
