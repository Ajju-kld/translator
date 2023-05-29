import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isDisabled;
  final bool isDark;
  final Function(String) translate;

  const InputField(
      {super.key,
      required this.textEditingController,
      required this.isDisabled,
      required this.isDark,
      required this.translate});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int count = 0;

  @override
  void dispose() {

    super.dispose();
  }

  void _translation() {

    widget.translate(widget.textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle counterStyle = TextStyle(
        color: widget.isDark
            ? const Color.fromARGB(255, 112, 110, 110)
            : Colors.black,
        fontSize: 12);

    Color txtColor = widget.isDark ? Colors.white : Colors.black;

    return Container(
      width: 370,
      padding: const EdgeInsets.all(12),
      height: 195,
      decoration: BoxDecoration(
          color: widget.isDark
              ? const Color.fromARGB(255, 31, 31, 32)
              : const Color.fromARGB(255, 217, 216, 216),
          borderRadius: BorderRadius.circular(18)),
      child: TextField(
        maxLength: 2000,
        style: TextStyle(color: txtColor, fontSize: 18),
        maxLines: 7,
        controller: widget.textEditingController,
        onChanged: (_) => _translation(),
        enabled: !widget.isDisabled,
        cursorColor: txtColor,
        decoration: InputDecoration(
          hintText: widget.isDisabled ? '' : 'Type something here',
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
                '${widget.textEditingController.text.length}/2000',
                style: counterStyle,
              )),
        ),
      ),
    );
  }
}
