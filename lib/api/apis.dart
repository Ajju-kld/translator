
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:translator/utils.dart';


Future<List<String>> languages() async {
  final url = Uri.parse(
      "https://google-translate1.p.rapidapi.com/language/translate/v2/languages");

  final response = await http.get(
    url,
    headers: {
      'X-RapidAPI-Key': '--paste your api key',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com here'
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;

// Access the nested 'languages' list
    final languagesList = data['data']['languages'] as List<dynamic>;

// Iterate over the 'languages' list and extract the 'language' value from each element
    final List<String> languageCodes = languagesList
        .map((language) => language['language'] as String)
        .toList();

    return Future.delayed(Duration(seconds: 1), () => languageCodes);
  }
  // Return an empty dictionary if the response parsing fails or request fails
  return [];
}



Future<String?> getFlagUrl(String language) async {
  final countryCode = language_to_country[languageCodes[language]];
  final response = await http
      .get(Uri.parse('https://restcountries.com/v3.1/alpha/$countryCode'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final country_flag = data[0]['flags']['png'];
    print(country_flag);
    return country_flag.toString();
  }
  return null;
} 



Future<String?> translateText(
    String text, String toLanguage, String fromLanguage) async {
  final url = Uri.parse(
      'https://google-translate1.p.rapidapi.com/language/translate/v2');
final dio=Dio();
  final response = await dio.post(
    url.toString(),
    options: Options(
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
             'X-RapidAPI-Key': 'paste your API key here',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      },
    ),
    data: {
      'q': text,
      'target': toLanguage,
      'source': fromLanguage,
    },
  );

  if (response.statusCode == 200) {
    final translatedData = response.data as Map<String, dynamic>;
    final translatedText =
        translatedData['data']['translations'][0]['translatedText'] as String;
    return translatedText;
  } else {
    throw Exception(
        'Failed to translate text. Status code: ${response.statusCode}');
  }
}

