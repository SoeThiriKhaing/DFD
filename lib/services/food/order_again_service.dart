import 'package:dailyfairdeal/models/food/order_again_model.dart';
import 'package:dailyfairdeal/repositories/food/get_order_again_repository.dart';

class OrderAgainService {
  final GetOrderAgainRepository repository;

  OrderAgainService({required this.repository});

  Future<List<OrderAgain>> fetchOrderAgain() async {
    return await repository.getOrderAgain();
  }
}
