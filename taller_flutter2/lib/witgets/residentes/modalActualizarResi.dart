import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class ModalEditarResi extends StatefulWidget {
  const ModalEditarResi({
    super.key,
    required this.residente,
    required this.actualizarDatos,
  });
  final Map<String, dynamic> residente;
  final Function actualizarDatos;

  @override
  State<ModalEditarResi> createState() => _ModalEditarResiState();

}

class _ModalEditarResiState extends State<ModalEditarResi> {
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
    nombre.text = widget.residente['nombre_residente'];
    apellido.text = widget.residente['apellido_residente'];
    selectedGenero = widget.residente['genero_residente'];
    selectedPermiso = widget.residente['permiso'];
    tipoDocumento.text = widget.residente['tipo_documento_residente'];
    numeroDocumento.text = widget.residente['numero_documento_residente'];

  }

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: const Text('Editar residente'),
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
            final Map<String, dynamic> nuevoresidente = {
              "_id": widget.residente['_id'],
              "tipo_documento_residente": tipoDocumento.text,
              "numero_documento_residente": numeroDocumento.text,
              "nombre_residente": nombre.text,
              "apellido_residente": apellido.text,
              "genero_residente": selectedGenero,
              "permiso": selectedPermiso,

            };
            
            try {
              await registro.actualizarRegistro(nuevoresidente,'residentes/');
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se actualizó el registro correctamente'),
                ),
              );
              widget.actualizarDatos();
            } catch (e) {
              print('Error al agregar residente: $e');
            }
          },
        ),
      ],
    );
  }
}
