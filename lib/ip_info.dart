library ip_info;

import 'dart:convert';

import 'package:http/http.dart' as http;

class IPInfo {
  static Uri _ipv4 = Uri.parse('https://api.ipify.org?format=text');
  static Uri _ipv6 = Uri.parse('https://api6.ipify.org?format=text');
  static String _locate = 'http://ip-api.com/json/';

  /// Returns [Future<String>] if there is an existing ipv4, else returns null
  static Future<String> get ipv4 async {
    var response = await http.get(_ipv4);
    if (response.statusCode == 200)
      return response.body;
    else
      return null;
  }

  /// Returns [Future<String>] if there is an existing ipv6, else returns null
  static Future<String> get ipv6 async {
    var response = await http.get(_ipv6);
    if (response.statusCode == 200)
      return response.body;
    else
      return null;
  }

  /// Returns [Future<String>] if is an valid location, else returns null
  static Future<String> get location async {
    var response = await http
        .get('$_locate${await ipv4}?fields=country,regionName,zip,city');
    if (response.statusCode != 200) return null;
    final json = Map<dynamic, dynamic>.from(jsonDecode(response.body));
    return '${json['country']}, ${json['regionName']}, ${json['city']}, ${json['zip']}';
  }

  /// Returns [Future<int>] hash from both ips
  static Future<int> get hash async {
    var v4 = await ipv4, v6 = await ipv6;
    if (v4 != null && v6 != null)
      return int.parse('${v4.hashCode}${v6.hashCode}');
    else
      return null;
  }
}
