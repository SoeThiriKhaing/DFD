import 'package:dailyfairdeal/models/food/order_again_model.dart';

abstract class IOrderAgain {
  Future<List<OrderAgain>> getOrderAgain();
}
