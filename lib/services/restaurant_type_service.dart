import 'package:dailyfairdeal/models/restaurant_type_model.dart';

import '../repositories/restaurant_type_repository.dart';

class RestaurantTypeService {
  final RestaurantTypeRepository repository;

  RestaurantTypeService({required this.repository});

  Future<List<RestaurantType>> fetchRestaurantTypes() async {
    return await repository.getRestaurantType();
  }
}
