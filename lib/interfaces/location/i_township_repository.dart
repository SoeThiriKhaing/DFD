

import 'package:dailyfairdeal/models/location/township_model.dart';

abstract class ITownshipRepository {
  Future<List<Township>> getTownshipById();
}