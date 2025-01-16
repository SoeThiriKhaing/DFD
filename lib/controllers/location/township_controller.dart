import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/services/location/township_service.dart';

class TownshipController {
  final TownshipService service;

  TownshipController({required this.service});

  Future<List<Map<String, String>>> loadTownshipById(int cityId) async {
    try {
      List<Township> townships = await service.getTownshipById(cityId);

      return townships.map((township) {
        return {
          'id': township.id.toString(), // Convert id to String
          'name': township.name,
          'city_id': township.cityId.toString(),
        };
      }).toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


}
