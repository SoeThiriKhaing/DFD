import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/repositories/food/get_all_res_repository.dart';
import 'package:dailyfairdeal/repositories/food/get_feat_res_repository.dart';

class FeatResService{
  final GetFeatResRepository repository;

FeatResService({required this.repository});

  Future<List<AllRestaurant>> fetchFeatureRes() async {
    return await repository.getFeatureRestaurant();
  }
}
