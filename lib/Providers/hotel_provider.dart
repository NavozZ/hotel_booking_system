import 'package:flutter/material.dart';
import 'package:hotel_management_system/Models/hotel.dart';

class HotelProvider extends ChangeNotifier {
  List<Hotel> _hotels = [];

  addHotels({required List<Hotel> hotels}) {
    _hotels = hotels;
    notifyListeners();
  }

  List<Hotel> get hotelsData => _hotels;
}
