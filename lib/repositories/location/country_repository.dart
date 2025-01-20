import 'package:dailyfairdeal/interfaces/location/i_country_repository.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class CountryRepository implements ICountryRepository {
  /// Fetch a list of countries from the API
  @override
  Future<List<Country>> getCountries() async {
    try {
      final response = await ApiHelper.fetchList<Country>(
        endpoint: AppUrl.getCountry,
        fromJson: (data) => Country.fromJson(data),
      );

      // Log the response for debugging
      print("API Response: ${response.toString()}");

      return response;
    } catch (e) {
      print("Error in getCountries: $e");
      throw Exception("Failed to fetch country list");
    }
  }
}
