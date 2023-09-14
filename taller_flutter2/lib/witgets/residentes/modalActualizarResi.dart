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

  final TextEditingController correo = TextEditingController();

  String selectedGenero = 'M';

  final TextEditingController telefono = TextEditingController();


  @override
  void initState(){
    super.initState();
    _updateFields();

  }

  _updateFields(){
    nombre.text = widget.residente['nombre_residente'];
    apellido.text = widget.residente['apellido_residente'];
    selectedGenero = widget.residente['genero_residente'];
    tipoDocumento.text = widget.residente['tipo_documento_residente'];
    numeroDocumento.text = widget.residente['numero_documento_residente'];
    correo.text = widget.residente['correo'];
    telefono.text = widget.residente['telefono_residente'];
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
              enabled: false,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Apellido'),
              controller: apellido,
              enabled: false,
            ),
            TextField(
              enabled: false,
              decoration: const InputDecoration(labelText: 'Tipo de documento'),
              controller: tipoDocumento,
            ),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Número de documento'),
              controller: numeroDocumento,
              enabled: false,
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
            TextField( 
              decoration: const InputDecoration(labelText: 'Correo'),
              controller: correo,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Teléfono'),
              controller: telefono,
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
            final Map<String, dynamic> actualizacionresidente = {
              "_id": widget.residente['_id'],
              // "tipo_documento_residente": widget.residente['tipo_documento_residente'],
              // "numero_documento_residente": numeroDocumento.text,
              // "nombre_residente": nombre.text,
              // "apellido_residente": apellido.text,
              // "genero_residente": selectedGenero,
              // "tipo_residente": widget.residente['tipo_residente'],
              "correo": correo.text,
              "telefono_residente": telefono.text,
              // "residencia": "null",
              // "habita":true,
              // "estado": widget.residente['estado'],
              // "fecha_inicio": widget.residente['fecha_inicio'],
              // "fecha_nacimiento": widget.residente['fecha_nacimiento'],
              // "fecha_fin": widget
            };
            
            try {
              await registro.actualizarRegistro(actualizacionresidente,'residentes/');
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
