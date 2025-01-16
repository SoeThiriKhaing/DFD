import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/services/location/division_service.dart';

class DivisionController {
  final DivisionService service;

  DivisionController({required this.service});

  Future<List<Map<String, String>>> loadDivisionById(int countryId) async {
    try {
      List<Division> divisions = await service.getDivisionById(countryId);

      // Convert List<Country> to List<Map<String, String>>
      return divisions.map((division) {
        return {
          'id': division.id.toString(), // Convert id to String
          'name': division.name,
          'country_id': division.countryId.toString(),      // Assuming name is already a String
        };
      }).toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


}
