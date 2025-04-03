import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/Models/booking.dart';
import 'package:hotel_management_system/Models/hotel.dart';
import 'package:hotel_management_system/Providers/booking_provider.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:hotel_management_system/Services/firebase_services.dart';
import 'package:hotel_management_system/Services/payment_gateway_service/payment_gateway.dart';
import 'package:hotel_management_system/utils/app_colors.dart';
import 'package:hotel_management_system/widgets/custom_button.dart';
import 'package:hotel_management_system/widgets/facility_item.dart';
import 'package:hotel_management_system/widgets/hotel_booking_date_picker.dart';
import 'package:hotel_management_system/widgets/price_card.dart';
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
          child: Column(children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.isDiscoverScreen ? 40 : 15),
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
                                  currentHotelList.remove(widget.hotelData.id!);
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.hotelData.title!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.hotelData.rating}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.isDiscoverScreen) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.hotelData.amenities!.length,
                    (findex) => Padding(
                      padding: const EdgeInsets.only(right: 8), // Added spacing
                      child: FacilityItem(
                        facilityName: widget.hotelData.amenities![findex],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ]),
        ),
      ),
    );
  }

  hotelDetailBottomSheet({required Hotel hotel}) {
    List<PriceCard> priceCardList = [];
    int hotelTypeIndex = 0;
    hotel.prices!.forEach(
      (key, value) {
        priceCardList.add(
          PriceCard(
            priceName: key,
            price: value.toString(),
            index: hotelTypeIndex,
          ),
        );
        hotelTypeIndex++;
      },
    );

    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 8.0,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 700,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: hotel.otherImages!.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    hotel.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(hotel.rating.toString())
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotel.amenities!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            hotel.amenities![index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: priceCardList.length,
                    itemBuilder: (context, index) {
                      return priceCardList[index];
                    },
                  ),
                ),
                const HotelBookingDatePicker(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Price : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${context.watch<BookingProvider>().totalPrice} \$",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CustomButton(
                    btntext: "BOOK",
                    onTap: () {
                      // FirebaseServices.addABooking(
                      //   Booking(
                      //     bookingType:
                      //         context.read<BookingProvider>().bookingHotelType,
                      //     price:
                      //         context.read<BookingProvider>().bookingHotelPrice,
                      //     checkingDate:
                      //         context.read<BookingProvider>().checkingDate,
                      //     checkoutDate:
                      //         context.read<BookingProvider>().checkoutDate,
                      //     hotelId: hotel.id,
                      //     userId: FirebaseAuth.instance.currentUser!.email,
                      //     paymentStatus: false,
                      //   ),
                      // );

                      PaymentGateway.initPaymentSheet(
                        amount: context
                            .read<BookingProvider>()
                            .totalPrice
                            .substring(
                                0,
                                context
                                        .read<BookingProvider>()
                                        .totalPrice
                                        .length -
                                    2),
                      ).then((val) async {
                        await Stripe.instance.presentPaymentSheet();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
