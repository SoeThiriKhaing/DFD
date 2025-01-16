import 'package:dailyfairdeal/models/location/ward_model.dart';

abstract class IWardRepository {
  Future<List<Ward>> getWardById(int townshipId);
}