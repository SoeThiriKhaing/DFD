import 'package:dailyfairdeal/models/food/res_type_model.dart';

abstract class IRestaurantTypeRepository {
  Future<List<RestaurantType>> fetchRestaurantTypes();
}