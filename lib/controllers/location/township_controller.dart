import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/services/location/township_service.dart';

class TownshipController extends BaseController<Township> {
  TownshipController({required TownshipService service, required int cityId})
      : super(fetchItems: () => service.getTownshipById(cityId));

  Future<List<Map<String, Object>>> loadTownshipById(int i) {
    return loadItems((township) => {
          'id': township.id.toString(),
          'name': township.name,
          'city_id': township.cityId.toString(),
        });
  }
}
