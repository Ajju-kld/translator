import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/utils.dart';
import 'package:translator/widgets/Bottom.dart';
import 'package:translator/widgets/InputField.dart';
import 'package:translator/widgets/LanguageButton.dart';

import '../api/apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkmode = true;
  String fromLanguage = default_fromLanguage;
  String toLanguage = default_toLanguage;
  final _fromTranslate = TextEditingController();
  final _toTranslate = TextEditingController();

  void update_from_language(String language) {
    setState(() {
      fromLanguage = language;
    });
  }

  void update_to_language(String language) {
    setState(() {
      toLanguage = language;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fromTranslate.dispose();
    _toTranslate.dispose();
    super.dispose();
  }

  void show_bottom_sheet(
      context, bool to_from, Function(String) onLanguageChanged) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
   backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Bottom_sheet(
            isDarkmode: _isDarkmode,
            to_from: to_from,
            onPressed: onLanguageChanged);
      },
    );
  }

  void translate(String source) {
    var to_language = languageCodes[toLanguage];
    var from_language = languageCodes[fromLanguage];
    var translate_text = translateText(source, to_language!, from_language!);

    
   
      setState(() {
        _toTranslate.text = translate_text.toString();
      });
   
  }


void _exchange(){
String temp= fromLanguage;
setState(() {
  fromLanguage=toLanguage;
  toLanguage=temp;
});

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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Text Translation',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.sunny,
                              color: textColor,
                            ),
                            Switch(
                                activeColor: Colors.orange,
                                value: _isDarkmode,
                                onChanged: (value) {
                                  setState(() {
                                    _isDarkmode = value;
                                  });
                                }),
                            Icon(
                              Icons.dark_mode_outlined,
                              color: textColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    thickness: 2,
                    color: _isDarkmode ? Colors.grey : Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            show_bottom_sheet(
                                context, false, update_from_language);
                            // makeGetRequest();
                          },
                          child: LanguageButton(
                              language: fromLanguage, isDarkmode: _isDarkmode),
                        ),
                        IconButton(
                          onPressed: () => _exchange(),
                          icon: Icon(
                            Icons.compare_arrows_rounded,
                            color: _isDarkmode ? Colors.grey : Colors.black,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => show_bottom_sheet(
                              context, true, update_to_language),
                          child: LanguageButton(
                              language: toLanguage, isDarkmode: _isDarkmode),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Translate From [$fromLanguage]',
                          style: TextStyle(color: textColor, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: _fromTranslate.text));
                              Fluttertoast.showToast(
                                  msg: "copied",
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            icon: Icon(
                              Icons.copy,
                              color: textColor,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: InputField(
                      text_editing_controller: _fromTranslate,
                      is_disabled: false,
                      is_dark: _isDarkmode,
                      translate: translate,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Translate To [$toLanguage]',
                          style: TextStyle(color: textColor),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: _toTranslate.text));
                              Fluttertoast.showToast(
                                  msg: "copied",
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            icon: Icon(
                              Icons.copy,
                              color: textColor,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: InputField(
                      text_editing_controller: _toTranslate,
                      is_disabled: true,
                      is_dark: _isDarkmode,
                      translate: (p0) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
