import 'package:flutter/material.dart';
import 'package:hotel_management_system/Providers/booking_provider.dart';
import 'package:provider/provider.dart';

class HotelBookingDatePicker extends StatefulWidget {
  const HotelBookingDatePicker({
    super.key,
  });

  @override
  State<HotelBookingDatePicker> createState() => _HotelBookingDatePickerState();
}

class _HotelBookingDatePickerState extends State<HotelBookingDatePicker> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          checkDatePicker(
            context,
            checkType: "CheckIn",
            date:
                "${checkInDate.year}-${checkInDate.month.toString().padLeft(2, '0')}-${checkInDate.day.toString().padLeft(2, '0')}",
            firstDate: DateTime.now(),
          ),
          checkDatePicker(
            context,
            checkType: "CheckOut",
            date:
                "${checkOutDate.year}-${checkOutDate.month.toString().padLeft(2, '0')}-${checkOutDate.day.toString().padLeft(2, '0')}",
            firstDate: checkInDate,
          ),
        ],
      ),
    );
  }

  Widget checkDatePicker(buildContext,
      {required String checkType,
      required String date,
      required DateTime firstDate}) {
    return InkWell(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: buildContext,
          firstDate: firstDate,
          lastDate: DateTime.parse("2999-12-12"),
        );
        if (selectedDate == null) return;
        if (checkType == "CheckIn") {
          setState(() {
            checkInDate = selectedDate;
            context.read<BookingProvider>().updateCheckingDate(
                checkingDate:
                    "${checkInDate.year}-${checkInDate.month.toString().padLeft(2, '0')}-${checkInDate.day.toString().padLeft(2, '0')}");
          });
        } else if (checkType == "CheckOut") {
          setState(() {
            checkOutDate = selectedDate;
            context.read<BookingProvider>().updateCheckoutDate(
                checkoutDate:
                    "${checkOutDate.year}-${checkOutDate.month.toString().padLeft(2, '0')}-${checkOutDate.day.toString().padLeft(2, '0')}");
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "$checkType: $date",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
