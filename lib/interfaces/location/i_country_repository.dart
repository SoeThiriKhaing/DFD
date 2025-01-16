import 'package:dailyfairdeal/models/location/country_model.dart';

abstract class ICountryRepository {
  Future<List<Country>> getCountries();
}