library ip_info;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform_detect/platform_detect.dart' as pd;

class IPInfo {
  static Uri _ipv4 = Uri.parse('https://api.ipify.org?format=text');
  static Uri _ipv6 = Uri.parse('https://api6.ipify.org?format=text');
  static Uri _locate = Uri.parse('https://ipapi.co/json/');

  /// Returns [Future<String>] if there is an existing ipv4, else returns null
  static Future<String> get ipv4 async {
    try {
      var response = await http.get(_ipv4);
      if (response.statusCode == 200) return response.body;
    } catch (e) {}
    return null;
  }

  /// Returns [Future<String>] if there is an existing ipv6, else returns null
  static Future<String> get ipv6 async {
    try {
      var response = await http.get(_ipv6);
      if (response.statusCode == 200) return response.body;
    } catch (e) {}
    return null;
  }

  /// Returns [Future<String>] if there is no error , else returns null
  static Future<String> get location async {
    var response = await http.get(_locate);
    if (response.statusCode != 200) return null;
    final json = Map<dynamic, dynamic>.from(jsonDecode(response.body));
    return '${json['country_name']}, ${json['region']}, ${json['city']}, ${json['postal']}';
  }

  ///<Beta> Returns fingerprint for the current user as hashvalue [int].
  static int fingerprint(BuildContext context) {
    final fingerprint =
        '${pd.browser}${pd.operatingSystem}${DateTime.now().timeZoneName}${MediaQuery.of(context).size.height}${MediaQuery.of(context).size.width}${MediaQuery.of(context).size.aspectRatio}';
    return fingerprint.hashCode;
  }
}
