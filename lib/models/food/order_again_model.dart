import 'package:dailyfairdeal/models/food/all_res_model.dart';

class OrderAgain extends AllRestaurant {
  final String orderDetail;

  OrderAgain({
    required super.id,
    required super.name,
    required super.restaurantType,
    required super.openTime,
    required super.closeTime,
    required super.cityName,
    required super.phNumber,
    required super.streetName,
    required super.townshipName,
    required super.userName,
    required super.wardName,
    required this.orderDetail,
  });

  factory OrderAgain.fromJson(Map<String, dynamic> json) {
    return OrderAgain(
      id: json['id'],
      name: json['name'],
      restaurantType: json['restaurantType'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      phNumber: json['phNumber'],
      userName: json['userName'],
      streetName: json['streetName'],
      wardName: json['wardName'],
      townshipName: json['townshipName'],
      cityName: json['cityName'],
      orderDetail: json['orderDetail'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['orderDetail'] = orderDetail;
    return json;
  }
}
