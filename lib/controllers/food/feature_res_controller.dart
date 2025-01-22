import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/feat_res_service.dart';

class FeatureResController extends BaseController<AllRestaurant> {
  FeatureResController({required FeatResService service})
      : super(fetchItems: service.fetchFeatureRes);

  Future<List<Map<String, Object>>> loadFeatRestaurant() {
    return loadItems((featRes) => {
          'id': featRes.id.toString(),
          'name': featRes.name,
          'res_type': featRes.restaurantType,
          'openTime': featRes.openTime,
          'closeTime': featRes.closeTime,
        });
  }
}
