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
  }

  Future<Ward> addWard(Ward ward) async {
    final response = await ApiHelper.request(
      endpoint: AppUrl.addWard,
      method: "POST",
      body: ward.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    debugPrint("Added ward: $response");
    return response;
  }

  Future<Ward> updateWard(Ward ward) async {
    final response = await ApiHelper.request(
      endpoint: '${AppUrl.updateWard}/${ward.id}',
      method: "PUT",
      body: ward.toJson().map((key, value) => MapEntry(key, value.toString())),
    );
    debugPrint("Updated ward: $response");
    return response;
  }

  Future<void> deleteWard(int wardId) async {
    await ApiHelper.request(
      endpoint: '${AppUrl.deleteWard}/$wardId',
      method: "DELETE",
    );
    debugPrint("Deleted ward with id: $wardId");
  }
}
