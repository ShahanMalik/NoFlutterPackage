import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getCountryFromIP() async {
  try {
    // Step 1: Get the public IP address
    final ipResponse =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (ipResponse.statusCode == 200) {
      final Map<String, dynamic> ipData = json.decode(ipResponse.body);
      final String ip = ipData['ip'];

      // Step 2: Get the country information using the IP address
      final response =
          await http.get(Uri.parse('https://ipapi.com/ip_api.php?ip=$ip'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['country_name'] ?? 'Unknown';
      } else {
        return 'Failed to get country';
      }
    } else {
      return 'Failed to get IP address';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
