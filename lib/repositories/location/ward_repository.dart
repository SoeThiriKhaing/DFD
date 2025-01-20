import 'package:dailyfairdeal/interfaces/location/i_ward_repository.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class WardRepository implements IWardRepository {
  @override
  Future<List<Ward>> getWardById(int townshipId) async {
    try {
      final String endpoint = '${AppUrl.getWardById}/$townshipId';
      final response = await ApiHelper.fetchList<Ward>(
        endpoint: endpoint,
        fromJson: (data) => Ward.fromJson(data),
      );

      // Log the response
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getWardById: $e");
      throw Exception("Failed to fetch wards for township ID $townshipId");
    }
  }
}
