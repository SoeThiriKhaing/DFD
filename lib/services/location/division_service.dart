import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/repositories/location/division_repository.dart';

class DivisionService {
  final DivisionRepository repository;

  DivisionService({required this.repository});

  Future<List<Division>> getDivisionById(int countryId) async {
    return await repository.getDivisionById(countryId);
  }
}
