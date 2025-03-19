class DriverModel {
  final int? id;
  final String? name; //added additionally
  final double? price;//added additionally
  final int? userId; // Store only user ID instead of UserModel
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final int carYear;
  final String carMake;
  final String carModel;
  final String carColour;
  final String licensePlate;
  final String otherInfo;
 // final String role;

  DriverModel({
    this.id,
    this.name, //added additionally
    this.price, //added additionally
    this.userId, // Only user ID
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.carYear,
    required this.carMake,
    required this.carModel,
    required this.carColour,
    required this.licensePlate,
    required this.otherInfo,
   // required this.role,
  });

  // Fetch current location asynchronously
  //static Future<DriverModel> fromJson(Map<String, dynamic> json) async {
  static DriverModel fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? 0,//added additionally
      userId: json['rider_id'] ?? 0, // Extract only user ID
      latitude: json['latitude'],
      longitude: json['longitude'],
      isAvailable: json['is_available'] == 1,
      carYear: json['car_year'] ?? 0,
      carMake: json['car_make'] ?? '',
      carModel: json['car_model'] ?? '',
      carColour: json['car_colour'] ?? '',
      licensePlate: json['license_plate'] ?? '',
      otherInfo: json['other_info'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //"id": id,
      //"name": name,
      //"price": price,
      "latitude": latitude,
      "longitude": longitude,
      "is_available": isAvailable ? 1 : 0,
      "car_year": carYear,
      "car_make": carMake,
      "car_model": carModel,
      "car_colour": carColour,
      "license_plate": licensePlate,
      "other_info": otherInfo,
    };
  }
}