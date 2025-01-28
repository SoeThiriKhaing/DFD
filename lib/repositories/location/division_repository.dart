import 'package:dailyfairdeal/interfaces/location/i_division_repository.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DivisionRepository implements IDivisionRepository {
  @override
  Future<List<Division>> getDivisionById(int countryId) async {
    return await ApiHelper.fetchList<Division>(
        endpoint: '${AppUrl.getDivisionById}/$countryId',
        fromJson: (data) {
           debugPrint('Raw data from API: $data'); 
         return Division.fromJson(data);
        });

    // Log the response
  }
}
