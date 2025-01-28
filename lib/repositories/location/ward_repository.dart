import 'package:dailyfairdeal/interfaces/location/i_ward_repository.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class WardRepository implements IWardRepository {
  @override
  Future<List<Ward>> getWardById(int townshipId) async {
    return await ApiHelper.fetchList<Ward>(
        endpoint: '${AppUrl.getWardById}/$townshipId',
        fromJson: (data) {
          debugPrint("Raw data from API:$data");
          return Ward.fromJson(data);
        });

    // Log the response
  }
}
