import 'package:dailyfairdeal/interfaces/location/i_township_repository.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class TownshipRepository implements ITownshipRepository {
  @override
  Future<List<Township>> getTownshipById() async {
    return await ApiHelper.fetchList<Township>(
        endpoint: AppUrl.getTownshipById(),
        fromJson: (data) {
          debugPrint("Township Raw data from API:$data");
          return Township.fromJson(data);
        });

    // Log the response
  }
}
