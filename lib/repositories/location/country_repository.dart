import 'package:dailyfairdeal/interfaces/location/i_country_repository.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/fetch_data.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class CountryRepository implements ICountryRepository {
  @override
  Future<List<Country>> getCountries() async {
    return await FetchData.fetchList(
      endpoint: AppUrl.getCountry,
      fromJson: Country.fromJson,
    );
  }
}
