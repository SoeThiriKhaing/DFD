import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/repositories/location/street_repository.dart';

class StreetService {
  final StreetRepository repository;

  StreetService({required this.repository});

  Future<List<Street>> getStreetById(int wardId) async {
    return await repository.getStreetById(wardId);
  }

  Future<void> addStreet(Street street) async {
    await repository.addStreet(street);
  }

  Future<void> updateStreet(Street street) async {
    await repository.updateStreet(street);
  }

  Future<void> deleteStreet(int streetId) async {
    await repository.deleteStreet(streetId);
  }
}
