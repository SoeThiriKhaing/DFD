import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/services/location/division_service.dart';

class DivisionController extends BaseController<Division> {
  DivisionController({required DivisionService service, required int countryId})
      : super(fetchItems: () => service.getDivisionById(countryId));

  Future<List> loadDivisionById(int i) {
    return loadItems((division) => {
          'id': division.id.toString(),
          'name': division.name,
          'country_id': division.countryId.toString(),
        });
  }
}
