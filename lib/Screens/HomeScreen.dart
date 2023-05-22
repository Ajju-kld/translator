
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:translator/utils.dart';
import 'package:translator/widgets/Bottom.dart';
import 'package:translator/widgets/InputField.dart';
import 'package:translator/widgets/LanguageButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkmode = true;
  final fromLanguage = default_fromLanguage;
  final toLanguage = default_toLanguage;
  final _fromTranslate = TextEditingController();
  final _toTranslate = TextEditingController();
  
 
  


  @override
  void dispose() {
    // TODO: implement dispose
    _fromTranslate.dispose();
    _toTranslate.dispose();
    super.dispose();
  }

  void show_bottom_sheet(context, bool to_from) {
    

showModalBottomSheet(
      context: context,
isScrollControlled: true,
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      backgroundColor:  Color.fromARGB(221, 1, 1, 1),
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
      return Bottom_sheet(isDarkmode: _isDarkmode, to_from:to_from);
      },
    );

  }



Future<Map<String, dynamic>> makeGetRequest() async {
  final url = Uri.parse(
        "https://google-translate1.p.rapidapi.com/language/translate/v2/languages");

  final response = await http.get(
    url,
    headers: {
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
      'X-RapidAPI-Key': '677c89c5a8mshc83a40096e71157p113e61jsnb328a28b24a2',
    },
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

// Print the language codes
      print(languageCodes);
  }

  // Return an empty dictionary if the response parsing fails or request fails
  return {};
}



  @override
  Widget build(BuildContext context) {
    Color textColor = _isDarkmode ? Colors.white : Colors.black;
    Color backgroundColor =
        _isDarkmode ? Color.fromARGB(255, 15, 15, 15) : Colors.white;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Text Translation',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                   
                   Switch(value: _isDarkmode, onChanged: (value){
                    setState(() {
                    _isDarkmode=value;   
                    });
                   }) ],
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    thickness: 2,
                    color: _isDarkmode ? Colors.grey : Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show_bottom_sheet(context, false);
                            makeGetRequest();
                          },
                          child: LanguageButton(
                              language: fromLanguage, isDarkmode: _isDarkmode),
                        ),
                        Icon(
                          Icons.compare_arrows_rounded,
                          color: _isDarkmode ? Colors.grey : Colors.black,
                          size: 30,
                        ),
                        GestureDetector(
                          onTap: () => show_bottom_sheet(context, true),
                          child: LanguageButton(
                              language: toLanguage, isDarkmode: _isDarkmode),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 230, 0),
                    child: Text(
                      'Translate From [$fromLanguage]',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: InputField(
                        text_editing_controller: _fromTranslate,
                        is_disabled: false,
                        is_dark: _isDarkmode),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 230, 0),
                    child: Text(
                      'Translate To [$toLanguage]',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: InputField(
                        text_editing_controller: _toTranslate,
                        is_disabled: true,
                        is_dark: _isDarkmode),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
