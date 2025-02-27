import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/repositories/location/street_repository.dart';

class StreetService {
  final StreetRepository repository;

  StreetService({required this.repository});

  Future<List<Street>> getStreetById() async {
    return await repository.getStreetById();
  }
}
