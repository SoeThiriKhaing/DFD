import 'package:dailyfairdeal/interfaces/food/i_feature_res_repository.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class GetFeatResRepository implements IFeatureResRepository {
  @override
  Future<List<AllRestaurant>> getFeatureRestaurant() async {
    return await ApiHelper.fetchList<AllRestaurant>(
        endpoint: AppUrl.getAllRestaurant,
        fromJson: (data) {
            debugPrint("Raw data from API:$data");
         return AllRestaurant.fromJson(data);
        });
  }
}
