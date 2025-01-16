import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/services/location/street_service.dart';

class StreetController {
  final StreetService service;

  StreetController({required this.service});

  Future<List<Map<String, String>>> loadStreetById(int wardId) async {
    try {
      List<Street> streets = await service.getStreetById(wardId);

      // Convert List<Country> to List<Map<String, String>>
      return streets.map((street) {
        return {
          'id': street.id.toString(), // Convert id to String
          'name': street.name,
          'ward_id': street.wardId.toString(),
        };
      }).toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


}
