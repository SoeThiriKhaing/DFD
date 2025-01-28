class AllRestaurant {
  final int id;
  final String name;
  final String restaurantType;
  final String openTime;
  final String closeTime;
  final String phNumber;
  final String userName;
  final String streetName;
  final String wardName;
  final String townshipName;
  final String cityName;
  AllRestaurant(
      {required this.id,
      required this.name,
      required this.restaurantType,
      required this.openTime,
      required this.closeTime,
      required this.cityName,
      required this.phNumber,
      required this.streetName,
      required this.townshipName,
      required this.userName,
      required this.wardName});
  factory AllRestaurant.fromJson(Map<String, dynamic> json) {
    return AllRestaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Bubble Shop',
      restaurantType: json['restaurantType'] ?? 'Chinese',
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      phNumber: json['phNumber'] ?? '',
      userName: json['userName'] ?? '',
      streetName: json['streetName'] ?? '',
      wardName: json['wardName'] ?? '',
      townshipName: json['townshipName'] ?? '',
      cityName: json['cityName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'restaurantType': restaurantType,
      'openTime': openTime,
      'closeTime': closeTime,
      'phNumber': phNumber,
      'userName': userName,
      'streetName': streetName,
      'townshipName': townshipName,
      'wardName': wardName,
      'cityName': cityName,
    };
  }
}
