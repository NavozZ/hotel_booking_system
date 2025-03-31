import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/Models/hotel.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:hotel_management_system/Services/firebase_services.dart';
import 'package:hotel_management_system/utils/app_colors.dart';
import 'package:hotel_management_system/widgets/facility_item.dart';
import 'package:provider/provider.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({
    super.key,
    required this.hotelData,
    required this.favouriteHotel,
    this.isDiscoverScreen = true,
  });

  final Hotel hotelData;
  final bool favouriteHotel;
  final bool isDiscoverScreen;

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  @override
  Widget build(BuildContext context) {
    bool favouriteHotelCard = context
        .watch<HotelProvider>()
        .favouriteHotelIds
        .contains(widget.hotelData.id);
    return InkWell(
      onTap: () {
        hotelDetailBottomSheet(hotel: widget.hotelData);
      },
      child: Padding(
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
                    borderRadius: BorderRadius.circular(
                        widget.isDiscoverScreen ? 40 : 15),
                    child: Image.network(
                      (widget.hotelData.mainImage!),
                    ),
                  ),
                  if (widget.isDiscoverScreen) ...[
                    Positioned(
                      top: 20,
                      right: 30,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: const Color.fromARGB(192, 71, 69, 69)),
                        child: Center(
                          child: InkWell(
                            onTap: favouriteHotelCard
                                //Remove Favourite Hotel
                                ? () {
                                    var currentHotelList = context
                                        .read<HotelProvider>()
                                        .favouriteHotelIds;
                                    currentHotelList
                                        .remove(widget.hotelData.id!);
                                    FirebaseServices.removeHotelFromFavourite(
                                      updatedHotelList: currentHotelList,
                                      removedItemId: widget.hotelData.id!,
                                      context: context,
                                    );
                                    Fluttertoast.showToast(
                                      msg: "Remove From Favorite",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor:
                                          const Color.fromARGB(139, 0, 0, 0),
                                      textColor: Colors.redAccent,
                                      fontSize: 16.0,
                                    );
                                  }
                                //Add Favourite Hotel
                                : () {
                                    FirebaseServices.addFavouriteHotel(
                                      hotelId: widget.hotelData.id!,
                                      context: context,
                                    );
                                    Fluttertoast.showToast(
                                        msg: "Add to Favorite",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            const Color.fromARGB(139, 0, 0, 0),
                                        textColor: Colors.green,
                                        fontSize: 16.0);
                                  },
                            child: Icon(
                              context
                                      .watch<HotelProvider>()
                                      .favouriteHotelIds
                                      .contains(widget.hotelData.id)
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.hotelData.title!),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Text("${widget.hotelData.rating}")
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.isDiscoverScreen) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        widget.hotelData.amenities!.length,
                        (findex) => FacilityItem(
                          facilityName: widget.hotelData.amenities![findex],
                        ),
                      )),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  hotelDetailBottomSheet({required Hotel hotel}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled:
          true, // Ensure bottom sheet height adjusts dynamically
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider with adjusted image width
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0, autoPlay: true, enlargeCenterPage: true),
                    items: hotel.otherImages!.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              image,
                              height: 200,
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Make image width fit screen
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // Floating Close Button
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the bottom sheet
                      },
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  hotel.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.black),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(hotel.rating.toString())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Entire Room",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text("Hosted by isabelle"),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.person,
                        size: 50,
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),

              // Amenities section - Each amenity in its own box (In a Row)
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topic Style
                    Text(
                      "Amenities",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black, // Add color for the header
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Create a row for each amenity
                    Wrap(
                      spacing: 10.0, // Add space between each amenity
                      runSpacing: 10.0, // Add space between lines of amenities
                      children: hotel.amenities!.map((amenity) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 83, 79,
                                79), // Light background color for readability
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(202, 0, 0, 0),
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price and Date section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "18.oct.3 Nights",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            "\$300",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),

                      // Book Now Button
                      InkWell(
                        onTap: () {
                          // Add functionality here for booking
                          print("Book Now button clicked");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:
                                Colors.orange, // You can adjust the color here
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
