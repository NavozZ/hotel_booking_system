import 'package:flutter/material.dart';
import 'package:hotel_management_system/utils/app_colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(195, 82, 79, 79).withOpacity(0.7),
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
            isPressed
                ? SizedBox(
                    width: 250,
                    height: 30,
                    child: TextField(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Search Places",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          )),
                      Text("Date Range and Number of guests",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ))
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
