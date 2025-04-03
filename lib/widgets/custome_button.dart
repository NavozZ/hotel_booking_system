import 'package:flutter/material.dart';

class CustomeButton extends StatefulWidget {
  final String textvlaue;
  final Color buttonColor;
  final Color textvalueColor;
  final int index;
  final VoidCallback onTap;
  const CustomeButton(
      {super.key,
      required this.textvlaue,
      required this.buttonColor,
      required this.textvalueColor,
      required this.index,
      required this.onTap});

  @override
  State<CustomeButton> createState() => _CustomeButtonState();
}

class _CustomeButtonState extends State<CustomeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap, // Call the passed function on tap
      child: Container(
        width: 105,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
          color:
              widget.buttonColor, // Color changes based on the selected index
        ),
        child: Center(
          child: Text(
            widget.textvlaue,
            style: TextStyle(
              color: widget.textvalueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
