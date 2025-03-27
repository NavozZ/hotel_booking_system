class Hotel {
  String? title;
  num? rating;
  Map<String, dynamic>? prices;
  String? mainImage;
  List<dynamic>? otherImages;
  List<dynamic>? amenities;

  Hotel({
    this.title,
    this.rating,
    this.prices,
    this.mainImage,
    this.otherImages,
    this.amenities,
  });
}
