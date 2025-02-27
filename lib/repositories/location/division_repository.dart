import 'package:dailyfairdeal/interfaces/location/i_division_repository.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';
import 'package:flutter/material.dart';

class DivisionRepository implements IDivisionRepository {
  @override
  Future<List<Division>> getDivisionById() async {
    return await ApiHelper.fetchList<Division>(
      endpoint: AppUrl.getDivisionById(), // Corrected function usage
      fromJson: (data) {
        debugPrint(
            'Division Raw data from API for Country ID: $data');
        return Division.fromJson(data);
      },
    );
  }
}
