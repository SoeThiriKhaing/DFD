import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/res_type_model.dart';
import 'package:dailyfairdeal/services/food/res_type_service.dart';

class RestaurantTypeController extends BaseController<RestaurantType> {
  RestaurantTypeController({required RestaurantTypeService service})
      : super(fetchItems: service.getRestaurantTypes);

  Future<List<Map<String, Object>>> loadRestaurantTypes() {
    return loadItems((resType) => {
          'id': resType.id.toString(), // Convert id to String
          'name': resType.name, // Assuming name is already a String
        });
  }
}
