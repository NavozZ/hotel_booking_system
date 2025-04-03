import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  String updatedCheckingDate = DateTime.now().toString();
  String updatedCheckoutDate = DateTime.now().toString();
  String price = "0";
  String bookingType = "";
  String totalPrice = "0";
  updateCheckingDate({required String checkingDate}) {
    updatedCheckingDate = checkingDate;
    //getSelectedPackagePrice();
    notifyListeners();
  }

  updateCheckoutDate({required String checkoutDate}) {
    updatedCheckoutDate = checkoutDate;
    //getSelectedPackagePrice();
    notifyListeners();
  }

  updateHotelType({required String price, required String bookingType}) {
    this.price = price;
    this.bookingType = bookingType;
    //getSelectedPackagePrice();
    notifyListeners();
  }

  getSelectedPackagePrice() {
    int diffrenceDate = DateTime.parse(updatedCheckoutDate)
        .difference(DateTime.parse(updatedCheckingDate))
        .inDays;
    num calculatedPrice = diffrenceDate * double.parse(price);
    totalPrice = calculatedPrice.toString();
    notifyListeners();
  }

  String get checkingDate => updatedCheckingDate;
  String get checkoutDate => updatedCheckoutDate;
  String get bookingHotelPrice => price;
  String get bookingHotelType => bookingType;
  String get calculatedTotalPrice => totalPrice;
}
