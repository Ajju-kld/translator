

import 'package:flutter/material.dart';
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
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Text Translation',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                     
                     Row(
                       children: [const Icon(Icons.sunny),

                         Switch(activeColor: Colors.orange,value: _isDarkmode, onChanged: (value){
                          setState(() {
                          _isDarkmode=value;   
                          });
                         }),
                       const Icon(Icons.dark_mode_outlined)
                       ],
                     ) ],
                    ),
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
                            // makeGetRequest();
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
