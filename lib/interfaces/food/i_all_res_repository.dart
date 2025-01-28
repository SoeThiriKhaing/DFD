import 'package:dailyfairdeal/models/food/all_res_model.dart';

abstract class IAllResRepository {
  Future<List<AllRestaurant>> getAllRestaurant();
}
