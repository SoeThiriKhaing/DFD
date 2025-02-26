import 'package:dailyfairdeal/interfaces/location/i_township_repository.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class TownshipRepository implements ITownshipRepository {
  @override
  Future<List<Township>> getTownshipById(int cityId) async {
    return await ApiHelper.fetchList<Township>(
        endpoint: '${AppUrl.getTownshipById}/$cityId',
        fromJson: (data) {
          debugPrint("Raw data from API:$data");
          return Township.fromJson(data);
        });
  }

  Future<void> addTownship(Township township) async {
    await ApiHelper.request(
      endpoint: AppUrl.addTownship,
      method: "POST",
      body: township.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> updateTownship(Township township) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.updateTownship}/${township.id}',
      method: "PUT",
      body: township.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> deleteTownship(int townshipId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteTownship}/$townshipId',
      method: "DELETE",
    );
  }
}
