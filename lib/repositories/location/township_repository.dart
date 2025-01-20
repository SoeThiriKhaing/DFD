import 'package:dailyfairdeal/interfaces/location/i_township_repository.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class TownshipRepository implements ITownshipRepository {
  @override
  Future<List<Township>> getTownshipById(int cityId) async {
    return await ApiHelper.fetchList<Township>(
        endpoint: '${AppUrl.getTownshipById}/$cityId',
        fromJson: (data) {
          print("Raw data from API:$data");
          return Township.fromJson(data);
        });

    // Log the response
  }
}
