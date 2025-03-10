import 'package:dailyfairdeal/models/location/division_model.dart';

abstract class IDivisionRepository {
  Future<List<Division>> getDivisionById(int countryId); // Accept countryId
}
