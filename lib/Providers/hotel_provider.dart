import 'package:flutter/material.dart';
import 'package:hotel_management_system/Models/hotel.dart';

class HotelProvider extends ChangeNotifier {
  List<Hotel> _hotels = [];

  List<dynamic> _favouriteHotelsIds = [];

  List<Hotel> _favouriteHotelList = [];

  addHotels({required List<Hotel> hotels}) {
    _hotels = hotels;
    notifyListeners();
  }

  addFavouriteHotelIds({required List<dynamic> favouriteHotelIds}) {
    _favouriteHotelsIds = favouriteHotelIds;

    notifyListeners();
  }

  addFavouriteHotelId({required String hotelId}) {
    favouriteHotelIds.add(hotelId);
    notifyListeners();
  }

  removeFavouriteHotelId({required String hotelId}) {
    favouriteHotelIds.remove(hotelId);
    notifyListeners();
  }

  getOnlyFavouriteHotels() {
    _favouriteHotelList.clear();
    for (var hotel in _hotels) {
      if (_favouriteHotelsIds.contains(hotel.id)) {
        _favouriteHotelList.add(hotel);
      }
    }
  }

  List<Hotel> get hotelsData => _hotels;
  List<dynamic> get favouriteHotelIds => _favouriteHotelsIds;
  List<Hotel> get favouriteHotels => _favouriteHotelList;
}
