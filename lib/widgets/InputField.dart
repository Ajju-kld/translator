import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController text_editing_controller ;
 final bool is_disabled;
 final bool is_dark;

  const InputField({super.key,required this.text_editing_controller,required this.is_disabled,required this.is_dark});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int count=0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

void _update_character() {setState(() {
  
    count = widget.text_editing_controller.text.length;
    print(count);
});
  }
  

  @override
  Widget build(BuildContext context) {

TextStyle counterStyle=TextStyle(color:widget.is_dark? Color.fromARGB(255, 112, 110, 110) :Colors.black,fontSize:12);

Color _txtColor=widget.is_dark?Colors.white:Colors.black;

    return Container(

      width:370,
      padding: EdgeInsets.all(12),
      height: 195,
      decoration: BoxDecoration(color: widget.is_dark? const Color(0xFF222426):Colors.white70,borderRadius:BorderRadius.circular(18)),
      child: TextField(
        maxLength: 2000,
        style: TextStyle(color:_txtColor ),
        maxLines:7,
        controller: widget.text_editing_controller,
        onChanged: (_)=>_update_character(),
        enabled: !widget.is_disabled,
        decoration: InputDecoration(hintText:widget.is_disabled?'':'type something here',
        hintStyle: TextStyle(color: _txtColor),
   disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ) ,
     enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.grey),
        ),
        counter: Align(alignment: Alignment.topLeft,child: Text('$count/2000',style: counterStyle,)),
        suffix: const SizedBox.shrink()),
      ),
    );
  }
}