import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';

class AllResController extends BaseController<AllRestaurant> {
  AllResController({required AllResService service})
      : super(fetchItems: service.fetchAllRestaurant);

  Future<List<Map<String, Object>>> loadAllRestaurant() {
    return loadItems((res) => {
          'id': res.id.toString(),
          'name': res.name,
          'res_type': res.restaurantType,
          'openTime': res.openTime,
          'closeTime': res.closeTime,
        });
  }
}
