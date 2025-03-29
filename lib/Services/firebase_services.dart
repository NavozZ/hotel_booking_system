import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_management_system/Models/hotel.dart';

class FirebaseServices {
  //get example documents from Firebase DB and return Hotel type data
  static Future<List<Hotel>> getHotels() async {
    // get data from Firebase DB
    CollectionReference hotelCollectionReference =
        FirebaseFirestore.instance.collection('hotels');

    final hotelDocuments = await hotelCollectionReference.get();

    hotelCollectionReference.get().then((hotelDocuments) {});

    List<Hotel> hotels = [];
    for (var hotelDoc in hotelDocuments.docs) {
      hotels.add(Hotel(
        title: hotelDoc["title"],
        rating: hotelDoc["Rating"],
        prices: hotelDoc["Prices"],
        mainImage: hotelDoc["main-image"],
        otherImages: hotelDoc["other-images"],
        amenities: hotelDoc["amenities"],
      ));
    }
    return hotels; // Return the list of hotels
  }

  static addSignUpData(
      {required String email,
      required String name,
      required String adress,
      required String mobileNo}) {
    CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection('users');

    userCollectionReference.add({
      "email": email,
      "name": name,
      "adress": adress,
      "mobile_number": mobileNo
    });
  }
}
