
import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:translator/utils.dart';


Future<Map<String, dynamic>> makeGetRequest() async {
  final url = Uri.parse(
      "https://google-translate1.p.rapidapi.com/language/translate/v2/languages");

  final response = await http.get(
    url,
 
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    print(data);

// Access the nested 'languages' list
    final languagesList = data['data']['languages'] as List<dynamic>;
    print(languagesList);
// Iterate over the 'languages' list and extract the 'language' value from each element
    final languageCodes = languagesList
        .map((language) => language['language'] as String)
        .toList();
Map<String, String?> country_to_language={};
// Print the language codes
  for (final code in languageCodes) {
  country_to_language[code]=Locale(code).countryCode;
  }
  print(country_to_language);
  return data;
  }
  // Return an empty dictionary if the response parsing fails or request fails
  return {};
}




Future<String?> getFlagUrl(String language) async {
  final countryCode=language_to_country[languageCodes[language]];
  final  response = await http.get(Uri.parse('https://restcountries.com/v3.1/alpha/$countryCode'));
if (response.statusCode==200) {
 
  final data=jsonDecode(response.body);
  final country_flag= data[0]['flags']['png'];
  print(country_flag);
  return country_flag.toString();
}
return null;
}  