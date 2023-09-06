import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ModalEditar extends StatefulWidget {
  const ModalEditar({
    super.key,
    required this.visitante,
    required this.actualizarDatos,
  });
  final Map<String, dynamic> visitante;
  final Function actualizarDatos;

  @override
  State<ModalEditar> createState() => _ModalEditarState();

}

class _ModalEditarState extends State<ModalEditar> {
  final registro = ApiVisitantes();

  final TextEditingController nombre = TextEditingController();

  final TextEditingController apellido = TextEditingController();

  final TextEditingController tipoDocumento = TextEditingController();

  final TextEditingController numeroDocumento = TextEditingController();

  final TextEditingController sexo = TextEditingController();

  final TextEditingController permiso = TextEditingController();

  final List<String> opcionesGenero = ['M', 'F'];

  final List<String> opcionesPermiso = ['PERMITIDO', 'NO PERMITIDO'];

  String selectedGenero = 'M';

  String selectedPermiso = 'PERMITIDO';


  @override
  void initState(){
    super.initState();
    _updateFields();

  }

  _updateFields(){
    nombre.text = widget.visitante['nombre_visitante'];
    apellido.text = widget.visitante['apellido_visitante'];
    selectedGenero = widget.visitante['genero_visitante'];
    selectedPermiso = widget.visitante['permiso'];
    tipoDocumento.text = widget.visitante['tipo_documento_visitante'];
    numeroDocumento.text = widget.visitante['numero_documento_visitante'];

  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: const Text('Editar visitante'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              controller: nombre,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Apellido'),
              controller: apellido,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Tipo de documento'),
              controller: tipoDocumento,
            ),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Número de documento'),
              controller: numeroDocumento,
            ),
            DropdownButtonFormField<String>(
              value: selectedGenero,
              items: opcionesGenero.map((String genero) {
                return DropdownMenuItem<String>(
                  value: genero,
                  child: Text(genero),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedGenero = newValue;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedPermiso,
              items: opcionesPermiso.map((String permiso) {
                return DropdownMenuItem<String>(
                  value: permiso,
                  child: Text(permiso),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedPermiso = newValue;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Permiso',
                border: OutlineInputBorder(),
              ),
            ),

          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Guardar'),
          onPressed: () async {
            final Map<String, dynamic> nuevoVisitante = {
              "_id": widget.visitante['_id'],
              "tipo_documento_visitante": tipoDocumento.text,
              "numero_documento_visitante": numeroDocumento.text,
              "nombre_visitante": nombre.text,
              "apellido_visitante": apellido.text,
              "genero_visitante": selectedGenero,
              "permiso": selectedPermiso,

            };
            
            try {
              await registro.actualizarRegistro(nuevoVisitante);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se actualizó el registro correctamente'),
                ),
              );
              widget.actualizarDatos();
            } catch (e) {
              print('Error al agregar visitante: $e');
            }
          },
        ),
      ],
    );
  }
}
