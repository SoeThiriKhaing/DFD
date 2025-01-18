import 'package:dailyfairdeal/models/food/res_type_model.dart';
import 'package:dailyfairdeal/repositories/food/get_res_type_repository.dart';

class RestaurantTypeService {
  final RestaurantTypeRepository repository;

  RestaurantTypeService({required this.repository});

  Future<List<RestaurantType>> getRestaurantTypes() async {
    return await repository.fetchRestaurantTypes();
  }
}

