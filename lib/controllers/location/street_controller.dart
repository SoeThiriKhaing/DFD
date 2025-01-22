import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/services/location/street_service.dart';

class StreetController extends BaseController<Street> {
  StreetController({required StreetService service, required int wardId})
      : super(fetchItems: () => service.getStreetById(wardId));

  Future<List<Map<String, Object>>> loadStreetById(int i) {
    return loadItems((street) => {
          'id': street.id.toString(),
          'name': street.name,
          'ward_id': street.wardId.toString(),
        });
  }
}
