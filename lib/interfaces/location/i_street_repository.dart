import 'package:dailyfairdeal/models/location/street_model.dart';

abstract class IStreetRepository {
  Future<List<Street>> getStreetById(int wardId);
}