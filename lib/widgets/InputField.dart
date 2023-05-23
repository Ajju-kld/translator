import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController text_editing_controller;
  final bool is_disabled;
  final bool is_dark;
  final Function(String) translate;

  const InputField(
      {super.key,
      required this.text_editing_controller,
      required this.is_disabled,
      required this.is_dark,
      required this.translate});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int count = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _update_character() {
    setState(() {
      count = widget.text_editing_controller.text.length;
      print(count);
    });
widget.translate(widget.text_editing_controller.text);
  
  }

  @override
  Widget build(BuildContext context) {
    TextStyle counterStyle = TextStyle(
        color:
            widget.is_dark ? const Color.fromARGB(255, 112, 110, 110) : Colors.black,
        fontSize: 12);

    Color txtColor = widget.is_dark ? Colors.white : Colors.black;

    return Container(
      width: 370,
      padding: const EdgeInsets.all(12),
      height: 195,
      decoration: BoxDecoration(
          color: widget.is_dark ? const Color.fromARGB(255, 31, 31, 32) : const Color.fromARGB(255, 217, 216, 216),
          borderRadius: BorderRadius.circular(18)),
      child: TextField(
        maxLength: 2000,
        style: TextStyle(color: txtColor,fontSize: 18),
        maxLines: 7,
        controller: widget.text_editing_controller,
        onChanged: (_) => _update_character(),
        enabled: !widget.is_disabled,
        cursorColor: txtColor,
        decoration: InputDecoration(
            hintText: widget.is_disabled ? '' : 'Type something here',
            hintStyle: TextStyle(color: txtColor),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            counter: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '$count/2000',
                  style: counterStyle,
                )),
           ),
      ),
    );
  }
}
