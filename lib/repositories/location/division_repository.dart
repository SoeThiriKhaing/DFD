import 'package:dailyfairdeal/interfaces/location/i_division_repository.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class DivisionRepository implements IDivisionRepository {
  @override
  Future<List<Division>> getDivisionById(int countryId) async {
    try {
      final String endpoint = '${AppUrl.getDivisionById}/$countryId';
      final response = await ApiHelper.fetchList<Division>(
        endpoint: endpoint,
        fromJson: (data) => Division.fromJson(data),
      );

      // Log the response
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getDivisionById: $e");
      throw Exception("Failed to fetch divisions for country ID $countryId");
    }
  }
}
