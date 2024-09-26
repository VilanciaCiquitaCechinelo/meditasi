import 'dart:convert';
import 'package:http/http.dart' as http;

final String token = 'BQBrc4uGec3kUD1KZaC_boju-CqCoykqtGUzGiusEdjMTkuKOTBkBIqxSgAJfO6NsU2OP-PFYhEL9uysCPcuNSWUaehlcwYTHlvvpHCZprgptUwaaQQA4h24Cx68y_UXIRXspGuF-2yFhUNzEq4GDqFLFcw1_grrlyMOFPUOgcO70V_NU9jEVS7acSBchGQcRHogUItz9Yg3goAuraVBhIwVkcGzLU7SoFPCEu8COiaZ1dNPY05uFLeS0yXXSuSbBHtIVPRBgpA6c4ahjiUKk2Oy';

Future<Map<String, dynamic>> fetchWebApi(String endpoint, String method, dynamic body) async {
  final response = await http.get(
    Uri.parse('https://api.spotify.com/$endpoint'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
