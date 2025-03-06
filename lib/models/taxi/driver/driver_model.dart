class DriverModel {
  int driverId;
  String driverName;
  String carNo;
  double price;
  double lat;
  double long;

  DriverModel({required this.driverId, required this.driverName, required this.carNo, required this.price, required this.lat, required this.long});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      driverId: json['driverId'],
      driverName: json['driverName'],
      carNo: json['carNo'],
      price: json['price'].toDouble(),
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'driverName': driverName,
      'carNo': carNo,
      'price': price,
      'lat': lat,
      'long': long,
    };
  }
}
