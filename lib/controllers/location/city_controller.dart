import 'package:dailyfairdeal/controllers/base_controller.dart';
import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/services/location/city_service.dart';

class CityController extends BaseController<City> {
  final int divisionId;

  CityController({
    required CityService service,
    required this.divisionId,
  }) : super(fetchItems: () => service.getCityById(divisionId));

  Future<List> loadCityById(int i) {
    return loadItems((city) => {
          'id': city.id.toString(), // Convert id to String
          'name': city.name,
          'division_id': city.divisionId.toString(),
        });
  }
}
