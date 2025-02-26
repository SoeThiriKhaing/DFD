import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/repositories/location/division_repository.dart';

class DivisionService {
  final DivisionRepository repository;

  DivisionService({required this.repository});

  Future<List<Division>> getDivisionById(int countryId) async {
    return await repository.getDivisionById(countryId);
  }

  Future<void> addDivision(Division division) async {
    await repository.addDivision(division);
  }

  Future<void> updateDivision(Division division) async {
    await repository.updateDivision(division);
  }

  Future<void> deleteDivision(int divisionId) async {
    await repository.deleteDivision(divisionId);
  }
}
