import 'package:dailyfairdeal/models/location/division_model.dart';

abstract class IDivisionRepository {
  Future<List<Division>> getDivisionById(); // Accept countryId
}
