import 'package:flutter/material.dart';
import 'package:taller_flutter2/witgets/modalActualizar.dart';

class ConstruirListaDeCartas extends StatelessWidget {
  const ConstruirListaDeCartas({
    super.key,
    required this.visitantes,
  });

  final List<Map<String, dynamic>> visitantes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: visitantes.length,
      itemBuilder: (context, index) {
        final visitante = visitantes[
            index]; // Suponiendo que visitantes es la lista de registros de la API

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
                '${visitante['nombre_visitante']} ${visitante['apellido_visitante']}'),
            subtitle: Text(
                'Tipo de Visitante: ${visitante['tipo_visitante']}\nTipo de documento: ${visitante['tipo_documento_visitante']}\nNúmero de documento: ${visitante['numero_documento_visitante']}\nSexo: ${visitante['genero_visitante']}\nPermiso: ${visitante['permiso']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ModalEditar(visitante: visitante,);
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    
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
