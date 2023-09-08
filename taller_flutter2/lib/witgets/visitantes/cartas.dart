import 'package:flutter/material.dart';
import 'package:taller_flutter2/witgets/visitantes/modalActualizar.dart';

import '../../services/api_service.dart';

class ConstruirListaDeCartas extends StatefulWidget {
  const ConstruirListaDeCartas({
    super.key,
    required this.visitantes,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> visitantes;
  final Function actualizarDatos;

  @override
  State<ConstruirListaDeCartas> createState() => _ConstruirListaDeCartasState();
}

class _ConstruirListaDeCartasState extends State<ConstruirListaDeCartas> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.visitantes.length,
      itemBuilder: (context, index) {
        final visitante = widget.visitantes[index]; 

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
                        return ModalEditar(
                          visitante: visitante,
                          actualizarDatos: widget.actualizarDatos,  
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eliminar visitante'),
                          content: const Text(
                              '¿Está seguro que desea eliminar este registro?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final registro = ApiVisitantes();
                                Map<String, dynamic> eliminacion = {
                                  '_id': visitante['_id']
                                };
                                await registro.eliminarRegistro(eliminacion,'visitantes/');
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Se eliminó el registro correctamente'),
                                  ),
                                );
                                widget.actualizarDatos();
                              },
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
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
