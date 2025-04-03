import 'package:flutter/material.dart';

import 'package:hotel_management_system/utils/app_colors.dart';

class EntireroomCard extends StatefulWidget {
  const EntireroomCard({
    super.key,
  });

  @override
  State<EntireroomCard> createState() => _EntireroomCardState();
}

class _EntireroomCardState extends State<EntireroomCard> {
  bool isaddfavourite = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: 310, //310
        height: 315, //100
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                      "https://images.pexels.com/photos/667838/pexels-photo-667838.jpeg",
                      fit: BoxFit.fill,
                      height: 230,
                      width: 350),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color.fromARGB(87, 0, 0, 0)),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isaddfavourite = !isaddfavourite;
                        });
                      },
                      child: Center(
                        child: Icon(
                          isaddfavourite == false
                              ? Icons.favorite_outline
                              : Icons.favorite,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Citrus",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                      ),
                      Text("3.9 (98)",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13))
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              child: Row(
                children: [
                  FacilityItem(facilityName: "2 guest "),
                  FacilityItem(facilityName: "1 bedrooms "),
                  FacilityItem(facilityName: "1 beds "),
                  FacilityItem(facilityName: "1 bathroom ")
                ],
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  PriceTags(
                      PreviousPrice: "246", NightPrice: "54", TotalPrice: "300")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Faculty_Item
class FacilityItem extends StatelessWidget {
  const FacilityItem({super.key, required this.facilityName});

  final String facilityName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          facilityName,
          style: TextStyle(fontSize: 13),
        )
      ],
    );
  }
}

//Price_Tag
class PriceTags extends StatelessWidget {
  const PriceTags(
      {super.key,
      required this.PreviousPrice,
      required this.NightPrice,
      required this.TotalPrice});

  final String PreviousPrice;
  final String NightPrice;
  final String TotalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.euro,
          size: 14,
          color: Colors.black.withOpacity(0.6),
        ),
        Text(PreviousPrice,
            style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.lineThrough,
                color: Colors.black.withOpacity(0.6))),
        const SizedBox(width: 3),
        Icon(Icons.euro, size: 13, color: Colors.black.withOpacity(0.6)),
        Text(NightPrice, style: TextStyle(fontSize: 13)),
        const SizedBox(width: 3),
        Text("night", style: TextStyle(fontSize: 13)),
        SizedBox(width: 3),
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.6)),
        ),
        const SizedBox(width: 3),
        Icon(Icons.euro, size: 14, color: Colors.black.withOpacity(0.5)),
        Text(TotalPrice,
            style:
                TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6))),
        const SizedBox(width: 3),
        Text("total",
            style:
                TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.5)))
      ],
    );
  }
}
