import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:hotel_management_system/Models/hotel.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:hotel_management_system/Screens/main/search_results_screen.dart';
import 'package:hotel_management_system/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: const NetworkImage(
                        "https://images.unsplash.com/photo-1445019980597-93fa8acb246c?q=80&w=2074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.darken),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primaryColor,
                            ),
                            Text(
                              "Norway",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hey, Martin! Tell us where you want to go",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                        int selectedIndex = 0;
                        SearchResultsScreen()
                            .botttomSheet(context, selectedIndex);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade600.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                isPressed
                                    ? const SizedBox(
                                        width: 250,
                                        height: 30,
                                        child: TextField())
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Serach Places",
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Date Range and Number of geusts",
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Text("The Most Relavant"),
          SizedBox(
            height: 350,
            child: Consumer<HotelProvider>(builder: (context, hotels, child) {
              print(hotels.hotelsData);
              List<Hotel> allHotelData = hotels.hotelsData;
              return hotels.hotelsData.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: allHotelData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.primaryColor),
                            width: 300,
                            height: 250,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                          allHotelData[index].mainImage!),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 30,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color: const Color.fromARGB(
                                                87, 0, 0, 0)),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_outline,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(allHotelData[index].title!),
                                      Row(
                                        children: [
                                          const Icon(Icons.star),
                                          Text("${allHotelData[index].rating}")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        allHotelData[index].amenities!.length,
                                        (findex) => FacilityItem(
                                          facilityName: allHotelData[index]
                                              .amenities![findex],
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      });
            }),
          )
        ],
      ),
    );
  }
}

class FacilityItem extends StatelessWidget {
  const FacilityItem({super.key, required this.facilityName});

  final String facilityName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(facilityName)
      ],
    );
  }
}
