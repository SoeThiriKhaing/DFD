import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/location/country_service.dart';

class CountryController extends BaseController<Country> {
  CountryController({required CountryService service})
      : super(fetchItems: service.getCountries);

  Future<List> loadCountryList() {
    return loadItems((country) => {
          'id': country.id.toString(),
          'name': country.name,
        });
  }
}
