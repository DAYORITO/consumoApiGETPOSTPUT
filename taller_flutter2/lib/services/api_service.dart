import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class ApiVisitantes{
  final String baseUrl = 'https://apptower-bk.onrender.com/api/visitantes';
  Future<dynamic>fetchData(String endpoint)async{
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to load data');
    }
  }
  Future<void> agregarRegistro(Map<String, dynamic> nuevoRegistro) async {
    final response = await http.post(Uri.parse(baseUrl), 
      headers: {
        'ContentType': 'aplication/json'
      },
      body: jsonEncode(nuevoRegistro)
    );
    if (response.statusCode == 201) {
      
    } else {
      
      throw Exception('Failed to add new visitor');
    }
    
  }
}