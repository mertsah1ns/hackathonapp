import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    required this.myIcon,
    required this.labelText,
    required this.hintText
  });
  final Icon myIcon;
  final TextEditingController textController;
  final String labelText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: myIcon,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(38, 65, 125, 1))),
        ));
  }
}
