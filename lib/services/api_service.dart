import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://kma.edu.vn";
  // verify on blockchain
  static Future<Map<String, dynamic>?> verifyCertificate(
      Map<String, dynamic> data) async {
    final url = Uri.parse(
        "$baseUrl/api/v1/blockchain/verify-batch-certificates");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      print("Backend error: ${response.statusCode}");
      return null;
    }
  }
  // link file PDF
  static String getPdfUrl(String certificateId) {
    return "$baseUrl/api/v1/certificates/file/$certificateId";
  }
}
