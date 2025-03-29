import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btn_text;
  final GestureTapCallback? onTap;

  const CustomButton({super.key, required this.btn_text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.black),
          child: Text(
            btn_text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
