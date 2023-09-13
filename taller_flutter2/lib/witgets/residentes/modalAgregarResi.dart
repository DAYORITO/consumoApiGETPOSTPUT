import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class ModalAgregarResi extends StatefulWidget {
  ModalAgregarResi({super.key});

  @override
  State<ModalAgregarResi> createState() => _ModalAgregarResiState();
}

class _ModalAgregarResiState extends State<ModalAgregarResi> {
  final registro = ApiVisitantes();

  final TextEditingController nombre = TextEditingController();

  final TextEditingController apellido = TextEditingController();

  TextEditingController tipoDocumento = TextEditingController();

  final TextEditingController numeroDocumento = TextEditingController();

  final TextEditingController sexo = TextEditingController();


  final List<String> opcionesGenero = ['M', 'F'];

  final TextEditingController correo = TextEditingController();

  String selectedGenero = 'M';

  final TextEditingController telefono = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateFields();
  }

  _updateFields() {
    tipoDocumento.text = "CC";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar residente'),
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
              enabled: false,
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
            final Map<String, dynamic> nuevoresidente = {
              "tipo_documento_residente": tipoDocumento.text,
              "numero_documento_residente": numeroDocumento.text,
              "nombre_residente": nombre.text,
              "apellido_residente": apellido.text,
              "genero_residente": selectedGenero,
              "tipo_residente": "ARRENDATARIO",
              "correo": correo.text,
              "telefono": telefono.text,
              "residencia": null,
              "habita":true,
              "estado": 'ACTIVO',
              "fecha_inicio": DateTime.now().toString(),
              "fecha_nacimiento":"1993-10-10T00:00:00.000Z",
              "fecha_fin": "2021-10-10T00:00:00.000Z",
            };

            try {
              await registro.agregarRegistro(nuevoresidente, 'residentes/');
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se agregó el registro correctamente'),
                ),
              );
              setState(() {});

              // Cierra el modal después de que la solicitud POST se complete con éxito
            } catch (e) {
              // Manejo de errores, muestra un mensaje de error si es necesario
              print('Error al agregar residente: $e');
              // Puedes mostrar un mensaje de error al usuario aquí si lo deseas
            }
          },
        ),
      ],
    );
  }
}
