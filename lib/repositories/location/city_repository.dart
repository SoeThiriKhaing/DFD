import 'package:dailyfairdeal/interfaces/location/i_city_repository.dart';
import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class CityRepository implements ICityRepository {
  @override
  Future<List<City>> getCityById(int divisionId) async {
    try {
      final String endpoint = '${AppUrl.getCitiesById}/$divisionId';
      final response = await ApiHelper.fetchList<City>(
        endpoint: endpoint,
        fromJson: (data) => City.fromJson(data),
      );

      // Log the response
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getCityById: $e");
      throw Exception("Failed to fetch cities for division ID $divisionId");
    }
  }
}
