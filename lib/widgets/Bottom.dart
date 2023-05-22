import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:translator/api/apis.dart';
import 'package:translator/utils.dart';


class Bottom_sheet extends StatefulWidget {
 final bool isDarkmode;
 final bool to_from;
   final Function(String) onPressed;
  const Bottom_sheet({super.key, required this.isDarkmode,required this.to_from,required this.onPressed});

  @override
  State<Bottom_sheet> createState() => _Bottom_sheetState();
}
class _Bottom_sheetState extends State<Bottom_sheet> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _languages =languageCodes.keys.toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  List<String> filteredLanguages=_languages.where((language)=>language.toLowerCase().contains(_searchQuery)).toList();
Color text_color=widget.isDarkmode?Colors.white:Colors.black;
  Color specific=widget.isDarkmode?const Color.fromARGB(255, 175, 172, 172):Colors.black;
    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          ClipRect(
            child: Container(
              decoration:  BoxDecoration(
                borderRadius:const  BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color:widget.isDarkmode?Color.fromARGB(255, 20, 20, 21):Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      widget.to_from ? 'To' : 'From',
                      style: TextStyle(
                        fontSize: 18,
                        color:specific,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 350,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style:TextStyle(color: text_color),
                        cursorColor:text_color,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon:  Icon(
                            Icons.search,
                            color: specific,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.isDarkmode
                                  ? Colors.white
                                  : Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: widget.isDarkmode? const Color(0xFF222426)
                              :Colors.white,
                          filled: true,
                          
                          hintStyle:  TextStyle(
                            color:widget.isDarkmode?Colors.white: Colors.black,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.isDarkmode
                                  ? Colors.white
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      'All Languages',
                      style: TextStyle(
                        fontSize: 18,
                        color:specific,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll){
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: ListView.builder(
                      
                        itemCount: filteredLanguages.length,
                        itemBuilder: (context, index) {
                          String language = filteredLanguages[index];
                          int startIndex = language
                              .toLowerCase()
                              .indexOf(_searchQuery.toLowerCase());
                          int endIndex = startIndex + _searchQuery.length;
                         
                      
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child:Country_tile(language: language, startIndex: startIndex, endIndex: endIndex,is_dark: widget.isDarkmode,onPressed:widget.onPressed),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:_searchQuery.isEmpty?null:RichText(
                        text: TextSpan(
                          text: 'There are',
                          style: TextStyle(
                            fontSize: 15,
                            color:text_color,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${filteredLanguages.length} languages ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:text_color,
                              ),
                            ),
                            TextSpan(
                              text: 'with the',
                            ),
                            TextSpan(
                              text: ' Letters ${_searchController.text} ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Country_tile extends StatefulWidget {
  final String language;
  final int startIndex;
  final int endIndex;
   final Function(String) onPressed;
  final bool is_dark;
   Country_tile({super.key,required this.onPressed,required this.language,required this.is_dark,required this.startIndex,required this.endIndex});

  @override
  State<Country_tile> createState() => _Country_tileState();
}

class _Country_tileState extends State<Country_tile> {
   bool is_selected=false;

  @override
  Widget build(BuildContext context) {
    Color txt_color = widget.is_dark ? Colors.white : Colors.black;
    final url=getFlagUrl(widget.language);
    return  GestureDetector(
      onTap: () {

        setState(() {
          is_selected=true;
        });
      widget.onPressed(widget.language);
     
     Navigator.of(context).pop();
     
      },

      child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                              color:(is_selected)?Colors.orange:(widget.is_dark)?Color.fromARGB(255, 0, 0, 0):Color.fromARGB(255, 219, 219, 220),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              height: 65,
                              child: Row(
                                children: [ 
                                   FutureBuilder<String?>(
                  future: url,
                  builder: (context, snapshot) {
                    final image_url = snapshot.hasData && snapshot.data != null
                        ? snapshot.data!
                        : 'https://icon-library.com/images/milestone-icon/milestone-icon-21.jpg';
    
                    return CircleAvatar(radius: 35,
                      backgroundImage: NetworkImage(image_url),
                      child: null,
                    );
                
                  }),
                                  const SizedBox(width: 10),
                                 RichText(
                                    text: TextSpan(
                                      text: widget.language.substring(0, widget.startIndex),
                                      style: TextStyle(
                                        color: widget.is_dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: widget.language.substring(
                                              widget.startIndex, widget.endIndex),
                                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color:txt_color,
                          ) ,
                                        ),
                                        TextSpan(
                                          text: widget.language.substring(widget.endIndex),
                                          style: TextStyle(
                                            color: widget.is_dark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
    );
  }
}