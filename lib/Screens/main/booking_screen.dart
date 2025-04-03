import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Add this for date formatting

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId =
      FirebaseAuth.instance.currentUser!.uid; // Get logged-in user

  Future<List<Map<String, dynamic>>> fetchBookedHotels() async {
    QuerySnapshot bookingSnapshot = await _firestore
        .collection("bookings")
        .where("userId", isEqualTo: userId) // Fetch only current user bookings
        .get();

    List<Map<String, dynamic>> bookings = [];

    for (var doc in bookingSnapshot.docs) {
      var bookingData = doc.data() as Map<String, dynamic>;

      // Fetch hotel details using hotelId
      DocumentSnapshot hotelSnapshot = await _firestore
          .collection("hotels")
          .doc(bookingData["hotelId"])
          .get();

      if (hotelSnapshot.exists) {
        var hotelData = hotelSnapshot.data() as Map<String, dynamic>;
        bookingData["hotelName"] = hotelData["title"];
        bookingData["hotelImage"] = hotelData["mainImage"];
      }

      bookings.add(bookingData);
    }

    return bookings;
  }

  // String formatDate(String date) {
  //   try {
  //     DateTime parsedDate = DateTime.parse(date);
  //     return DateFormat('yyyy-MM-dd').format(parsedDate);
  //   } catch (e) {
  //     return date;  // Return the original string if parsing fails
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: FutureBuilder(
        future: fetchBookedHotels(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings found."));
          }

          List<Map<String, dynamic>> bookedHotels = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: bookedHotels.length,
            itemBuilder: (context, index) {
              var booking = bookedHotels[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      booking["hotelImage"] ??
                          'https://via.placeholder.com/70', // Placeholder if image is null
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 70);
                      },
                    ),
                  ),
                  title: Text(
                    booking["hotelName"],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // children: [
                    //   Text("Booking Type: ${booking["bookingType"]}"),
                    //   Text("Check-in: ${formatDate(booking["checkingDate"])}"),
                    //   Text("Check-out: ${formatDate(booking["checkoutDate"])}"),
                    //   Text("Total Price: \$${booking["price"]}"),
                    //   Text(
                    //     booking["paymentStatus"] == true
                    //         ? "Paid ✅"
                    //         : "Pending ❌",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: booking["paymentStatus"] == true
                    //           ? Colors.green
                    //           : Colors.red,
                    //     ),
                    //   ),
                    // ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to hotel details page
                    // You can pass the hotel details if needed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailsScreen(
                          hotelId: booking["hotelId"],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HotelDetailsScreen extends StatelessWidget {
  final String hotelId;

  const HotelDetailsScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    // You can fetch hotel details and show them in this screen
    return Scaffold(
      appBar: AppBar(title: Text("Hotel Details")),
      body: Center(
        child: Text("Details for hotel with ID: $hotelId"),
      ),
    );
  }
}
