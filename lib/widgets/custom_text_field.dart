import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldName;
  final String? errorText;
  final TextEditingController? controller;
  const CustomTextField(
      {super.key,
      required this.textFieldName,
      this.errorText,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            errorText: errorText,
            label: Text(textFieldName),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            )),
      ),
    );
  }
}
