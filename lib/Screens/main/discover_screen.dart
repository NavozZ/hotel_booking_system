// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/Models/hotel.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:hotel_management_system/Services/firebase_services.dart';
import 'package:hotel_management_system/utils/app_colors.dart';
import 'package:hotel_management_system/widgets/hotel_card.dart';
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
    FirebaseServices.getCurrentUserFavouriteHotels().then((hotelIds) {
      context
          .read<HotelProvider>()
          .addFavouriteHotelIds(favouriteHotelIds: ["Em9QKkjkR37E5jbVvAeC"]);
    });
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
                          Colors.black.withOpacity(0.5), BlendMode.darken))),
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
                      InkWell(
                        onTap: () {
                          signout();
                        },
                        child: Icon(
                          Icons.logout,
                          color: AppColors.primaryColor,
                        ),
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
                      return HotelCard(
                          hotelData: allHotelData[index],
                          favouriteHotel: false);
                    });
          }),
        )
      ]),
    );
  }

  Future signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
