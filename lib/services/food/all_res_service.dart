import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/repositories/food/get_all_res_repository.dart';

class AllResService {
  final GetAllResRepository repository;

  AllResService({required this.repository});

  Future<List<AllRestaurant>> fetchAllRestaurant() async {
    return await repository.getAllRestaurant();
  }
}
