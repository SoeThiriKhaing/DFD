import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/services/location/ward_service.dart';

class WardController {
  final WardService service;

  WardController({required this.service});

  Future<List<Map<String, String>>> loadWardById(int townshipId) async {
    try {
      List<Ward> wards = await service.getWardById(townshipId);

      // Convert List<Country> to List<Map<String, String>>
      return wards.map((ward) {
        return {
          'id': ward.id.toString(), // Convert id to String
          'name': ward.name,
          'township_id': ward.townshipId.toString(),      // Assuming name is already a String
        };
      }).toList();
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


}
