import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';

class AllResController extends BaseController<AllRestaurant> {
  AllResController({required AllResService service})
      : super(fetchItems: service.fetchAllRestaurant);

  Future<List<Map<String, String>>> loadRestaurantList() async {
    final restaurantLists = await loadItems((allres) => {
          'id': allres.id.toString(),
          'name': allres.name,
          'restaurant_type': allres.restaurantType,
          'open_time': allres.openTime,
          'close_time': allres.closeTime,
          'City_Name': allres.cityName,
        });
    print(
        'Transformed restaurant list: $restaurantLists'); // Debug transformed list
    return restaurantLists;
  }
}
