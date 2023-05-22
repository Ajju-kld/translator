import 'dart:ui';

import 'package:flutter/material.dart';

class Bottom_sheet extends StatefulWidget {
 final bool isDarkmode;
 final bool to_from;
  const Bottom_sheet({super.key, required this.isDarkmode,required this.to_from});

  @override
  State<Bottom_sheet> createState() => _Bottom_sheetState();
}
class _Bottom_sheetState extends State<Bottom_sheet> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  List<String> filteredLanguages=_languages.where((language)=>language.toLowerCase().contains(_searchQuery)).toList();

  
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
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          ClipRect(
            child: Container(
              decoration:  BoxDecoration(
                borderRadius:const  BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color:widget.isDarkmode?const Color(0xFF222426):Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: IgnorePointer(
                      child: Text(
                        widget.to_from ? 'To' : 'From',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 96, 95, 95),
                        ),
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
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(243, 95, 90, 90),
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
                          fillColor: Color.fromARGB(255, 29, 33, 46),
                          filled: true,
                          hintStyle: const TextStyle(
                            color: Colors.white,
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
                    child: IgnorePointer(
                      child: Text(
                        'All Languages',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 96, 95, 95),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredLanguages.length,
                      itemBuilder: (context, index) {
                        String language = filteredLanguages[index];
                        int startIndex = language
                            .toLowerCase()
                            .indexOf(_searchQuery.toLowerCase());
                        int endIndex = startIndex + _searchQuery.length;
                        TextStyle highlightStyle = TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        );

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: 65,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  child: Text('flag'),
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                RichText(
                                  text: TextSpan(
                                    text: language.substring(0, startIndex),
                                    style: TextStyle(
                                      color: widget.isDarkmode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: language.substring(
                                            startIndex, endIndex),
                                        style: highlightStyle,
                                      ),
                                      TextSpan(
                                        text: language.substring(endIndex),
                                        style: TextStyle(
                                          color: widget.isDarkmode
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
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: RichText(
                        text: TextSpan(
                          text: 'There are',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 96, 95, 95),
                          ),
                          children: [
                            TextSpan(
                              text: ' ${filteredLanguages.length} languages ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'with the',
                            ),
                            TextSpan(
                              text: ' Letter G ',
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