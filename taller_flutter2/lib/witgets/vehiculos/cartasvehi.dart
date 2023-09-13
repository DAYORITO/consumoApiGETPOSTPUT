import 'package:flutter/material.dart';

class ConstruirListaDeCartasVehi extends StatefulWidget {
  const ConstruirListaDeCartasVehi({
    super.key,
    required this.vehiculos,
    required this.actualizarDatos,
  });

  final List<Map<String, dynamic>> vehiculos;
  final Function actualizarDatos;

  @override
  State<ConstruirListaDeCartasVehi> createState() => _ConstruirListaDeCartasVehiState();
}

class _ConstruirListaDeCartasVehiState extends State<ConstruirListaDeCartasVehi> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.vehiculos.length,
      itemBuilder: (context, index) {
        final vehiculo = widget.vehiculos[index]; 

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
                '${vehiculo['placa']} - ${vehiculo['tipo_dueño']}'),
            subtitle: Text(
                'Dueño: ${vehiculo['dueño']}\nEspacio asignado: ${vehiculo['espacio']}\nEstado: ${vehiculo['estado']}'),
          ),
        );
      },
    );
  }
}