
import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:translator/utils.dart';


// Future<Map<String, dynamic>> makeGetRequest() async {
//   final url = Uri.parse(
//       "https://google-translate1.p.rapidapi.com/language/translate/v2/languages");

//   final response = await http.get(
//     url,
//     headers: {
//       'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
//       'X-RapidAPI-Key': '677c89c5a8mshc83a40096e71157p113e61jsnb328a28b24a2',
//     },
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body) as Map<String, dynamic>;
//     print(data);

// // Access the nested 'languages' list
//     final languagesList = data['data']['languages'] as List<dynamic>;
//     print(languagesList);
// // Iterate over the 'languages' list and extract the 'language' value from each element
//     final languageCodes = languagesList
//         .map((language) => language['language'] as String)
//         .toList();
// Map<String, String?> country_to_language={};
// // Print the language codes
//   for (final code in languageCodes) {
//   country_to_language[code]=Locale(code).countryCode;
//   }
//   print(country_to_language);
//   return data;
//   }
//   // Return an empty dictionary if the response parsing fails or request fails
//   return {};
// }




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


Future<String?> translateText(
    String text, String toLanguage, String fromLanguage) async {
  const String apiUrl =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';

  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'X-RapidAPI-Key': '677c89c5a8mshc83a40096e71157p113e61jsnb328a28b24a2',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  };

  final Map<String, String> body = {
    'q': text,
    'target': toLanguage,
    'source': fromLanguage,
  };

  final response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: body);

  if (response.statusCode == 200) {
    final translatedData = json.decode(response.body);
    final translatedText =
        translatedData['data']['translations'][0]['translatedText'];
    print('Translated Text: $translatedText');
    return translatedText;
  } else {
    print('Error: ${response.statusCode}');
    return null;
  }
}
