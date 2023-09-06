import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ModalAgregar extends StatefulWidget {
  ModalAgregar({
    super.key
  });

  @override
  State<ModalAgregar> createState() => _ModalAgregarState();
}

class _ModalAgregarState extends State<ModalAgregar> {
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
              "tipo_documento_visitante": tipoDocumento.text,
              "numero_documento_visitante": numeroDocumento.text,
              "nombre_visitante": nombre.text,
              "apellido_visitante": apellido.text,
              "genero_visitante": selectedGenero,
              "tipo_visitante": "FRECUENTE",
              "anfitrion": "null",
              "permiso": selectedPermiso,

            };
            
            try {
              await registro.agregarRegistro(nuevoVisitante);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se agregó el registro correctamente'),
                ),
              );
              setState(() {
                
              });
              
                
              
               // Cierra el modal después de que la solicitud POST se complete con éxito
            } catch (e) {
              // Manejo de errores, muestra un mensaje de error si es necesario
              print('Error al agregar visitante: $e');
              // Puedes mostrar un mensaje de error al usuario aquí si lo deseas
            }
          },
        ),
      ],
    );
  }
}

