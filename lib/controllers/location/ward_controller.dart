import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/services/location/ward_service.dart';

class WardController extends BaseController<Ward> {
  WardController({required WardService service, required int townshipId})
      : super(fetchItems: () => service.getWardById(townshipId));

  Future<List<Map<String, Object>>> loadWardById(int i) {
    return loadItems((ward) => {
          'id': ward.id.toString(),
          'name': ward.name,
          'township_id': ward.townshipId.toString(),
        });
  }
}
