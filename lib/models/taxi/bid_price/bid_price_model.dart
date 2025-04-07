class BidPriceModel {
  final int id;
  final int travelId;
  final int taxiDriverId;
  final double price;
  final int? userId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  BidPriceModel({
    required this.id,
    required this.travelId,
    required this.taxiDriverId,
    required this.price,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to parse JSON data
  factory BidPriceModel.fromJson(Map<String, dynamic> json) {
    return BidPriceModel(
      id: json['id'] ?? 0, // Default to 0 if null
      travelId: json['travel_id'] ?? 0,
      taxiDriverId: json['taxi_driver_id'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,  // ✅ Convert int to double
      userId: json['user_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'travel_id': travelId,
      'taxi_driver_id': taxiDriverId,
      'price': price,
    };
  }
}
