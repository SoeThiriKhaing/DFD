class BidPriceModel {
  final int id;
  final int travelId;
  final int taxiDriverId;
  final double price;

  BidPriceModel({
    required this.id,
    required this.travelId,
    required this.taxiDriverId,
    required this.price,
  });

  // Factory constructor to parse JSON data
  factory BidPriceModel.fromJson(Map<String, dynamic> json) {
    return BidPriceModel(
      id: json['id'],
      travelId: json['travel_id'],
      taxiDriverId: json['taxi_driver_id'],
      price: (json['price'] as num).toDouble(), // ✅ Convert int to double
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'travel_id': travelId,
      'taxi_driver_id': taxiDriverId,
      'price': price,
    };
  }
}
