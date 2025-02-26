import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/repositories/location/township_repository.dart';

class TownshipService {
  final TownshipRepository repository;

  TownshipService({required this.repository});

  Future<List<Township>> getTownshipById(int cityId) async {
    return await repository.getTownshipById(cityId);
  }

  Future<void> addTownship(Township township) async {
    await repository.addTownship(township);
  }

  Future<void> updateTownship(Township township) async {
    await repository.updateTownship(township);
  }

  Future<void> deleteTownship(int townshipId) async {
    await repository.deleteTownship(townshipId);
  }
}
