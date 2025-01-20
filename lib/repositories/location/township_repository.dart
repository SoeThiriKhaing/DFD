import 'package:dailyfairdeal/interfaces/location/i_township_repository.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class TownshipRepository implements ITownshipRepository {
  @override
  Future<List<Township>> getTownshipById(int cityId) async {
    try {
      final String endpoint = '${AppUrl.getTownshipById}/$cityId';
      final response = await ApiHelper.fetchList<Township>(
        endpoint: endpoint,
        fromJson: (data) => Township.fromJson(data),
      );

      // Log the response
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getTownshipById: $e");
      throw Exception("Failed to fetch townships for city ID $cityId");
    }
  }
}
