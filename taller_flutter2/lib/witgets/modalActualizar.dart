import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ModalEditar extends StatefulWidget {
  ModalEditar({
    super.key,
    required this.visitante
  });
  final Map<String, dynamic> visitante;

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
            _buildDropdown("Permiso", selectedPermiso, opcionesPermiso, (String? newValue) {
              if (newValue != null) {
                selectedPermiso = newValue;
              }
            }),
            _buildDropdown("Género", selectedGenero, opcionesGenero, (String? newValue) {
              if (newValue != null) {
                selectedGenero = newValue;
              }
            }),
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
              await registro.actualizarRegistro(nuevoVisitante);
              Navigator.of(context).pop();
              
                
              
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
Widget _buildDropdown(String title, String selectedValue, List<String> items, ValueChanged<String?> onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      DropdownButton<String>(
        value: selectedValue,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}