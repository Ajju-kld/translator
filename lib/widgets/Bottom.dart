import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:translator/api/apis.dart';
import 'package:translator/utils.dart';

class Bottom_sheet extends StatefulWidget {
  final bool isDarkmode;
  final bool to_from;
  final Function(String) onPressed;
  const Bottom_sheet(
      {super.key,
      required this.isDarkmode,
      required this.to_from,
      required this.onPressed});

  @override
  State<Bottom_sheet> createState() => _Bottom_sheetState();
}

class _Bottom_sheetState extends State<Bottom_sheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _languages = [];
  var done;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    done = initializeLanguages();
    check(done);
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  void check(param) {
    if (param == false) {
      setState(() {
        done = true;
        _languages = languageCodes.keys.toList();
      });

      return;
    }
    return;
  }

  Future<bool> initializeLanguages() async {
    try {
        final languageCode = await languages();
      if (languageCode.isEmpty) {
        return false;
      }
      final list = findKeysByValues(languageCodes, languageCode);

      setState(() {
        _languages = list;
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  List<String> findKeysByValues(Map<String, String> map, List<String> values) {
    return values.map((value) {
      for (var entry in map.entries) {
        if (entry.value == value) {
          return entry.key;
        }
      }
      return '';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredLanguages = _languages
        .where((language) => language.toLowerCase().contains(_searchQuery))
        .toList();
    Color textColor = widget.isDarkmode ? Colors.white : Colors.black;
    Color specific = widget.isDarkmode
        ? const Color.fromARGB(255, 175, 172, 172)
        : Colors.black;
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
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: widget.isDarkmode
                    ? Color.fromARGB(255, 30, 30, 31)
                    : Colors.white,
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
                          color: specific,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 350,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: TextStyle(color: textColor),
                        cursorColor: textColor,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: specific,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:BorderSide(color:Colors.grey.shade500), 
                          borderRadius: BorderRadius.circular(10)
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
                          fillColor: widget.isDarkmode
                              ? const Color(0xFF222426)
                              : Colors.white,
                          filled: true,
                          hintStyle: TextStyle(
                            color:
                                widget.isDarkmode ? Colors.white : Colors.black,
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
                          color: specific,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: FutureBuilder(
                          future: done,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data == true) {
                              return ListView.builder(
                                itemCount: filteredLanguages.length,
                                itemBuilder: (context, index) {
                                  String language = filteredLanguages[index];
                                  int startIndex = language
                                      .toLowerCase()
                                      .indexOf(_searchQuery.toLowerCase());
                                  int endIndex =
                                      startIndex + _searchQuery.length;

                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Country_tile(
                                        language: language,
                                        startIndex: startIndex,
                                        endIndex: endIndex,
                                        is_dark: widget.isDarkmode,
                                        onPressed: widget.onPressed),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                  child: Container(
                                child: const CircularProgressIndicator(),
                              ));
                            }
                          }),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: _searchQuery.isEmpty
                          ? null
                          : RichText(
                              text: TextSpan(
                                text: 'There are',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        ' ${filteredLanguages.length} languages ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'with the',
                                  ),
                                  TextSpan(
                                    text: ' Letters ${_searchController.text} ',
                                    style: const TextStyle(
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
  const Country_tile(
      {super.key,
      required this.onPressed,
      required this.language,
      required this.is_dark,
      required this.startIndex,
      required this.endIndex});

  @override
  State<Country_tile> createState() => _Country_tileState();
}

class _Country_tileState extends State<Country_tile> {
  bool is_selected = false;
  static final customeCache_manager =
      CacheManager(Config('cacheKey', stalePeriod: const Duration(days: 10)));
  String imageurl = '';
bool isMounted = false;
  @override
  void initState() {
    // TODO: implement initState
    assignImageUrl();
    isMounted = true;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isMounted=false;
   super.dispose(); 
  }

  void assignImageUrl() async {
    String? imageUrlFromFuture = await getFlagUrl(widget.language);
    if(isMounted){
    setState(() {
      imageurl = imageUrlFromFuture!;
    }); // Assigns an empty string if the value is null
    }
  }
  @override
  Widget build(BuildContext context) {
    Color txtColor = widget.is_dark ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        setState(() {
          is_selected = true;
        });
        widget.onPressed(widget.language);

        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: (is_selected)
              ? Colors.orange
              : (widget.is_dark)
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 219, 219, 220),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 65,
        child: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageurl,
                cacheManager: customeCache_manager,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 50, // Set your desired width
                height: 50,
                fit: BoxFit.cover, // Set your desired height
              ),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                text: widget.language.substring(0, widget.startIndex),
                style: TextStyle(
                  color: widget.is_dark ? Colors.white : Colors.black,
                ),
                children: [
                  TextSpan(
                    text: widget.language
                        .substring(widget.startIndex, widget.endIndex),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
                  TextSpan(
                    text: widget.language.substring(widget.endIndex),
                    style: TextStyle(
                      color: widget.is_dark ? Colors.white : Colors.black,
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
