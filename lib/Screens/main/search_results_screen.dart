import 'package:flutter/material.dart';

import 'package:hotel_management_system/widgets/custome_button.dart';
import 'package:hotel_management_system/widgets/entireroom_card.dart';
import 'package:hotel_management_system/widgets/room_card.dart';
import 'package:hotel_management_system/widgets/search_bar_widget.dart';

class SearchResultsScreen {
  botttomSheet(BuildContext context, int selectedIndex) {
    //Manually Added
    List RoomHotelCardList = [RoomCard(), RoomCard(), RoomCard(), RoomCard()];

    //Manually Added
    List EntireRoomHotelCardList = [
      EntireroomCard(),
      EntireroomCard(),
      EntireroomCard(),
      EntireroomCard()
    ];

    //Manually Added
    List AnyTypeotelCardList = [
      EntireroomCard(),
      RoomCard(),
      EntireroomCard(),
      RoomCard()
    ];

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              expand: true,
              initialChildSize: 1,
              minChildSize: 1,
              maxChildSize: 1,
              builder: (_, controller) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 232, 232),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Positioned(
                          bottom: 100,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black),
                            width: 30,
                            height: 5,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, right: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.black,
                            ),
                            const Text(
                              "Search",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Icon(Icons.tune, color: Colors.black),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: SearchBarWidget(
                          mainText: "Norway",
                          secondaryText: "18-21 Oct - 4 guests",
                          seachBarColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomeButton(
                              textvlaue: "Any type",
                              buttonColor: selectedIndex == 0
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              textvalueColor: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.black,
                              index: 0,
                              onTap: () => setModalState(() {
                                selectedIndex = 0;
                              }),
                            ),
                            CustomeButton(
                              textvlaue: "Room",
                              buttonColor: selectedIndex == 1
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              textvalueColor: selectedIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                              index: 1,
                              onTap: () => setModalState(() {
                                selectedIndex = 1;
                              }),
                            ),
                            CustomeButton(
                              textvlaue: "Entire Room",
                              buttonColor: selectedIndex == 2
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              textvalueColor: selectedIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                              index: 2,
                              onTap: () => setModalState(() {
                                selectedIndex = 2;
                              }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            switch (selectedIndex) {
                              case 1:
                                return ListView.builder(
                                  itemCount: 4,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: RoomHotelCardList[index],
                                    );
                                  },
                                );
                              case 2:
                                return ListView.builder(
                                  itemCount: 4,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: EntireRoomHotelCardList[index],
                                    );
                                  },
                                );
                              case 0:
                                return ListView.builder(
                                  itemCount: 4,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: AnyTypeotelCardList[index],
                                    );
                                  },
                                );
                              default:
                                return SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
