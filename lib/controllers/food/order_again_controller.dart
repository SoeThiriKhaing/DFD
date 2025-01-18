import 'package:dailyfairdeal/models/food/order_again_model.dart';
import 'package:dailyfairdeal/services/food/order_again_service.dart';


class OrderAgainController{
  final OrderAgainService service;
  List<OrderAgain> orderAgain = [];

  OrderAgainController({required this.service});

  Future<List<Map<String, Object>>> loadOrderAgain() async {
    try {
      orderAgain = await service.fetchOrderAgain();
      return orderAgain
          .map((type) => {'id': type.id ?? '', 'name': type.name })
          .toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
