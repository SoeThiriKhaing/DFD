import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/repositories/location/ward_repository.dart';

class WardService {
  final WardRepository repository;

  WardService({required this.repository});

  Future<List<Ward>> getWardById(int townshipId) async {
    return await repository.getWardById(townshipId);
  }

  Future<Ward> addWard(Ward ward) async {
    return await repository.addWard(ward);
  }

  Future<Ward> updateWard(Ward ward) async {
    return await repository.updateWard(ward);
  }

  Future<void> deleteWard(int wardId) async {
    return await repository.deleteWard(wardId);
  }
}