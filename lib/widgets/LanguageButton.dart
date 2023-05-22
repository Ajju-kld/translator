import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:translator/api/apis.dart';

import '../utils.dart';

class LanguageButton extends StatelessWidget {
  final String language;

  final bool isDarkmode;

  LanguageButton({super.key, required this.language, required this.isDarkmode});
  

  @override
  Widget build(BuildContext context) {
    final url = getFlagUrl(language);
    return Container(width: 160,height: 65,
   
      decoration: BoxDecoration(
        color: isDarkmode ? Color.fromARGB(255, 40, 40, 41) : Colors.white60,
      borderRadius: BorderRadius.circular(12)),
padding:const EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Row(
        children: [
          FutureBuilder<String?>(
              future: url,
              builder: (context, snapshot) {
               final image_url=snapshot.hasData&&snapshot.data!=null?snapshot.data!:'https://icon-library.com/images/milestone-icon/milestone-icon-21.jpg';

return CircleAvatar(backgroundImage: NetworkImage(image_url),child:null,);

              }),SizedBox(width: 10,)
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
