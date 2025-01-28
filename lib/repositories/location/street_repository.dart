import 'package:dailyfairdeal/interfaces/location/i_street_repository.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class StreetRepository implements IStreetRepository {
  @override
  Future<List<Street>> getStreetById(int wardId) async {
    return await ApiHelper.fetchList<Street>(
        endpoint: '${AppUrl.getStreetById}/$wardId',
        fromJson: (data) {
          debugPrint("Raw data from API:$data");
          return Street.fromJson(data);
        });

    // Log the response
  }
}
