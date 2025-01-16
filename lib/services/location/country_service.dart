import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/repositories/location/country_repository.dart';

class CountryService {
  final CountryRepository repository;

  CountryService({required this.repository});

  Future<List<Country>> getCountries() async {
    return await repository.getCountries();
  }
}
