import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
const default_fromLanguage='English';
const default_toLanguage='spanish';

// FUNCTION FOR RETREIIVING URL TO IMAGE FILE FOR SPECIFIC LANGUAGE
// PARMS FOR RETREIIVING URL TO IMAGE FILE FOR SPECIFIC

Future<String?> fetchCountryImageUrl(String language) async {
  final baseUrl = 'https://restcountries.com/v3.1/lang';
  final response = await http.get(Uri.parse('$baseUrl/$language'));
return null;

// end point is not created throwing exception

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final imageUrl = data[0]['flags']['png'];

    return imageUrl;
  } else {
    return null;
  }
}


