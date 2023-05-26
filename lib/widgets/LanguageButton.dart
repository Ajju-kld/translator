

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


import 'package:translator/utils.dart';



class LanguageButton extends StatelessWidget {
  final String language;

  final bool isDarkmode;

  const LanguageButton({super.key, required this.language, required this.isDarkmode});
  
  static final customeCache_manager =
      CacheManager(Config('cacheKey', stalePeriod: const Duration(days: 10)));
  @override
  Widget build(BuildContext context) {
     final countryCode = language_to_country[languageCodes[language]]!.toLowerCase();
    final url='https://flagcdn.com/w320/$countryCode.png';
    return Container(width: 160,height: 65,
   
      decoration: BoxDecoration(
        color: isDarkmode ? const Color.fromARGB(255, 31, 31, 32) : const Color.fromARGB(255, 195, 192, 192),
      borderRadius: BorderRadius.circular(12)),
padding:const EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Row(
        children: [
       ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    key: UniqueKey(),
                    cacheKey: url,
                    cacheManager: customeCache_manager,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    width: 40, // Set your desired width
                    height: 40,
                    fit: BoxFit.cover, // Set your desired height
                  ),
                )

              ,const SizedBox(width: 10,)
          ,Text(
            language,
            style: TextStyle(
                color: isDarkmode ? Colors.white : Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
