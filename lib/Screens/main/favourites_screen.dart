import 'package:flutter/material.dart';
import 'package:hotel_management_system/Providers/hotel_provider.dart';
import 'package:hotel_management_system/widgets/hotel_card.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HotelProvider>().getOnlyFavouriteHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite Hotels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: context.read<HotelProvider>().favouriteHotels.length,
          itemBuilder: (BuildContext context, int index) {
            return HotelCard(
              hotelData: context.read<HotelProvider>().favouriteHotels[index],
              favouriteHotel: true,
              isDiscoverScreen: false,
            );
          },
        ),
      ),
    );
  }
}
