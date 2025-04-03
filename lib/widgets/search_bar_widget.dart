import 'dart:ui';

import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String mainText;
  final String secondaryText;
  final Color seachBarColor;
  final Color textColor;
  const SearchBarWidget(
      {super.key,
      required this.mainText,
      required this.secondaryText,
      required this.seachBarColor,
      required this.textColor});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isPressed =  false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: widget.seachBarColor,
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: widget.textColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                isPressed
                    ? const SizedBox(width: 250, height: 30, child: TextField())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.mainText,
                            style: TextStyle(
                                color: widget.textColor, fontSize: 13),
                          ),
                          Text(
                            widget.secondaryText,
                            style: TextStyle(
                                color: widget.textColor.withOpacity(0.5),
                                fontSize: 11),
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
