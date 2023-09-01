import 'package:flutter/material.dart';
import 'package:taller_flutter2/services/api_service.dart';

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
      appBar: AppBar(
        title: const Text('Visitantes')
      ),
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
            final List<Map<String, dynamic>> visitantes = snapshot.data as List<Map<String, dynamic>>;
            return _construirListaDeCartas(visitantes);
          }
        },
      ),

    );
  }
  Widget _construirListaDeCartas(List<Map<String, dynamic>> visitantes) {
  return ListView.builder(
  itemCount: visitantes.length,
  itemBuilder: (context, index) {
    final visitante = visitantes[index]; // Suponiendo que visitantes es la lista de registros de la API

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('${visitante['nombre_visitante']} ${visitante['apellido_visitante']}'),
        subtitle: Text('Tipo de Visitante: ${visitante['tipo_visitante']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Abrir el modal de edición con los datos de visitante
                
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Eliminar el registro
                
              },
            ),
          ],
        ),
      ),
    );
  },
);
  }
}