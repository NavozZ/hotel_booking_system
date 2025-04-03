import 'package:flutter/material.dart';
import 'package:hotel_management_system/Providers/booking_provider.dart';

import 'package:hotel_management_system/Providers/hotel_provider.dart';

import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    super.key,
    required this.priceName,
    required this.price,
    required this.index,
  });

  final String priceName;
  final String price;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HotelProvider>().updateSelectedHotelTypeIndex(index);
        context
            .read<BookingProvider>()
            .updateHotelType(price: price, bookingType: priceName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context.watch<HotelProvider>().index == index
                  ? const Color.fromARGB(155, 0, 0, 0)
                  : Colors.black,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Type : ${priceName.toUpperCase()}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Price : \$ $price",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
