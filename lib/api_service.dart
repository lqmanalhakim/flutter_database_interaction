import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<void> createDonor(Map<String, dynamic> donor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/donors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(donor),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create donor');
    }
  }

  // Add more API methods as needed
}
