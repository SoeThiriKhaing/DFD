import 'package:dailyfairdeal/models/location/city_model.dart';

abstract class ICityRepository {
  Future<List<City>> getCityById(int divisionId);
}