import 'package:dailyfairdeal/models/food/all_res_model.dart';

abstract class IFeatureResRepository {
  Future<List<AllRestaurant>> getFeatureRestaurant();
}
