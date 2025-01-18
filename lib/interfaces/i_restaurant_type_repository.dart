import 'package:dailyfairdeal/models/restaurant_type_model.dart';

abstract class IRestaurantTypeRepository {
  Future<List<RestaurantType>> fetchRestaurantTypes();
}