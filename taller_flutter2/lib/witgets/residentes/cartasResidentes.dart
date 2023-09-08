import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'modalActualizarResi.dart';

class ConstruirListaDeCartasResi extends StatefulWidget {
  const ConstruirListaDeCartasResi({
    super.key,
    required this.informacion,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> informacion;
  final Function actualizarDatos;

  @override
  State<ConstruirListaDeCartasResi> createState() => _ConstruirListaDeCartasResiState();
}

class _ConstruirListaDeCartasResiState extends State<ConstruirListaDeCartasResi> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.informacion.length,
      itemBuilder: (context, index) {
        final residente = widget.informacion[index]; 

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
                '${residente['nombre_residente']} ${residente['apellido_residente']}'),
            subtitle: Text(
                'Tipo de residente: ${residente['tipo_residente']}\nTipo de documento: ${residente['tipo_documento_residente']}\nNúmero de documento: ${residente['numero_documento_residente']}\nSexo: ${residente['genero_residente']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ModalEditarResi(
                          residente: residente,
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
                          title: const Text('Eliminar residente'),
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
                                  '_id': residente['_id']
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
