import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/models/restaurant_type_model.dart';
import '../interfaces/i_restaurant_type_repository.dart';
import '../util/appurl.dart';

class RestaurantTypeRepository implements IRestaurantTypeRepository {
  
  /// Fetch restaurant types specifically
  @override
  Future<List<RestaurantType>> fetchRestaurantTypes() async {
    return await ApiHelper.fetchList<RestaurantType>(
      endpoint: AppUrl.getResTypes,
      fromJson: (data) => RestaurantType.fromJson(data),
    );
  }
}
