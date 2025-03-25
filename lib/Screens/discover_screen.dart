// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hotel_management_system/utils/app_colors.dart';

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
      backgroundColor: const Color.fromARGB(255, 218, 217, 217),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/ea/9a/4b/hotel-image.jpg?w=1200&h=-1&s=1"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          // ignore: deprecated_member_use
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: AppColors.primaryColor),
                          Text("Norway",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                              )),
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
                    "Hey Navodya! Tell us where you want to go",
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
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(195, 82, 79, 79)
                              .withOpacity(0.7),
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
                  ),
                ],
              ),
            )
          ],
        ),
        Text("The Most Relavant"),
        SizedBox(
          height: 350,
          child: ListView.builder(
              itemCount: 4,
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
                                ("https://i0.wp.com/theluxurytravelexpert.com/wp-content/uploads/2018/05/ANANTARA-KALUTARA.jpg?ssl=1"),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 30,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color:
                                        const Color.fromARGB(192, 71, 69, 69)),
                                child: Center(
                                  child: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tiny Home in NuwaraEliya"),
                              Row(
                                children: [Icon(Icons.star), Text("5.65(217)")],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FacilityItem(
                                facilityName: "4 guests",
                              ),
                              FacilityItem(
                                facilityName: "4 guests",
                              ),
                              FacilityItem(
                                facilityName: "4 guests",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ]),
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
