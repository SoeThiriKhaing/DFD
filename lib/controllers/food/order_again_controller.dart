import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/order_again_model.dart';
import 'package:dailyfairdeal/services/food/order_again_service.dart';

class OrderAgainController extends BaseController<OrderAgain> {
  OrderAgainController({required OrderAgainService service})
      : super(fetchItems: service.fetchOrderAgain);
  Future<List<Map<String, Object>>> loadOrderAgain() {
    return loadItems((type) => {
          'id': type.id.toString(),
          'name': type.name,
        });
  }
}
