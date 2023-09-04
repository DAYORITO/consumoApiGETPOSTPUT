import 'package:http/http.dart' as http; // Asegúrate de tener esta línea
import 'dart:convert';

class ApiVisitantes {
  final String baseUrl = 'https://apptower-bk.onrender.com/api/visitantes/';

  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Manejo de errores más detallado
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  Future<void> agregarRegistro(Map<String, dynamic> nuevoRegistro) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'ContentType': 'application/json', // Aquí está corregido
      },
      body: jsonEncode(nuevoRegistro),
    );
    print(nuevoRegistro);
    if (response.statusCode == 201) {
    } else {
      print('Error: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Failed to add new visitor');
    }
  }
}
