import 'package:dailyfairdeal/interfaces/location/i_street_repository.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class StreetRepository implements IStreetRepository {
  @override
  Future<List<Street>> getStreetById(int wardId) async {
    try {
      final String endpoint = '${AppUrl.getStreetById}/$wardId';
      final response = await ApiHelper.fetchList<Street>(
        endpoint: endpoint,
        fromJson: (data) => Street.fromJson(data),
      );

      // Log the response
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getStreetById: $e");
      throw Exception("Failed to fetch streets for ward ID $wardId");
    }
  }
}
