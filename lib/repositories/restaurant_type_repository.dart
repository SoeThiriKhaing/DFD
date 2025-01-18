import 'package:dailyfairdeal/common_calls/fetch_data.dart';
import 'package:dailyfairdeal/models/restaurant_type_model.dart';
import '../interfaces/i_restaurant_type_repository.dart';
import '../util/appurl.dart';

class RestaurantTypeRepository implements IRestaurantTypeRepository {
  
  /// Fetch restaurant types specifically
  @override
  Future<List<RestaurantType>> fetchRestaurantTypes() async {
    return fetchData<RestaurantType>(
      endpoint: AppUrl.getResTypes, // Specific endpoint
      fromJson: (json) => RestaurantType.fromJson(json), // Specific JSON parser
    );
  }
}
