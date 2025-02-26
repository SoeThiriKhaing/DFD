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
  }

  Future<void> addStreet(Street street) async {
    await ApiHelper.request(
      endpoint: AppUrl.addStreet,
      method:"POST",
      body: street.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> updateStreet(Street street) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.updateStreet}/${street.id}',
      method: "PUT",
      body: street.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Future<void> deleteStreet(int streetId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteStreet}/$streetId',
      method: "DELETE",
    );
  }
}
