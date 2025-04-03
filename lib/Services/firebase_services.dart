import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/Models/booking.dart';
import 'package:hotel_management_system/Models/hotel.dart';
import 'package:hotel_management_system/Models/notification.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:provider/provider.dart';

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
        id: hotelDoc.id,
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

  static getCurrentUserID() async {
    final user = FirebaseAuth.instance.currentUser;
    var currentUserEmail = user!.email;

    final collectionReference = FirebaseFirestore.instance.collection("users");

    QuerySnapshot<Map<String, dynamic>> documents = await collectionReference
        .where("email", isEqualTo: currentUserEmail)
        .get();

    String userDocId = documents.docs[0].id;
    return userDocId;
  }

  static addFavouriteHotel(
      {required String hotelId, required BuildContext context}) async {
    final collectionReference = FirebaseFirestore.instance.collection("users");
    final userDocId = await getCurrentUserID();

    var document = await collectionReference.doc(userDocId).get();

    //Check Existing Favourite Hotels & Add New Favourite Hotel
    try {
      if (document["favourite-hotels"] != null) {
        List<dynamic> favouriteHotels = document["favourite-hotels"];

        favouriteHotels.add(hotelId);

        collectionReference
            .doc(userDocId)
            .update({'favourite-hotels': favouriteHotels}).then((val) {
          context.read<HotelProvider>().addFavouriteHotelId(hotelId: hotelId);
        });
      }
    } catch (e) {
      collectionReference.doc(userDocId).update({
        'favourite-hotels': [hotelId]
      }).then((val) {});
    }
  }

  static Future<List<dynamic>> getCurrentUserFavouriteHotels() async {
    final collectionReference = FirebaseFirestore.instance.collection("users");
    final userDocid = await getCurrentUserID();

    var document = await collectionReference.doc(userDocid).get();
    try {
      if (document["favourite-hotels"] != null) {
        List<dynamic> favouriteHotels = await document["favourite-hotels"];

        print(favouriteHotels);
        return favouriteHotels;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static removeHotelFromFavourite(
      {required List<dynamic> updatedHotelList,
      required String removedItemId,
      required BuildContext context}) async {
    final collectionReference = FirebaseFirestore.instance.collection("users");
    final userDocId = await getCurrentUserID();

    var document = await collectionReference
        .doc(userDocId)
        .update({'favourite-hotels': updatedHotelList}).then((value) {
      context
          .read<HotelProvider>()
          .removeFavouriteHotelId(hotelId: removedItemId);
    });
  }

  static addABooking(Booking booking) async {
    final collectionReference =
        FirebaseFirestore.instance.collection("bookings");

    var documentReference = await collectionReference.add(
      {
        "hotel-id": booking.hotelId,
        "booking-type": booking.bookingType,
        "checking-date": booking.checkingDate,
        "checkout-date": booking.checkoutDate,
        "price": booking.price,
        "user-id": booking.userId,
        "payment-status": booking.paymentStatus,
      },
    );
  }

  static Future<List<NotificationData>> getNotification() async {
    //get data from firebase db
    CollectionReference notificationCollectionReference =
        FirebaseFirestore.instance.collection("notification");

    final notificationDocuments = await notificationCollectionReference.get();

    List<NotificationData> notifications = [];
    for (var notificationDoc in notificationDocuments.docs) {
      notifications.add(NotificationData(
        title: notificationDoc["title"],
        body: notificationDoc["body"],
        date: notificationDoc["date"],
      ));
    }
    return notifications; // Return the list of hotels
  }
}
