import 'package:dailyfairdeal/interfaces/food/i_all_res_repository.dart';
import 'package:dailyfairdeal/models/food/all_res_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class GetAllResRepository implements IAllResRepository {
  @override
  Future<List<AllRestaurant>> getAllRestaurant() async {
    return await ApiHelper.fetchList<AllRestaurant>(
        endpoint: AppUrl.getAllRestaurant,
        fromJson: (data) {
          print("Raw data from API:$data");
          return AllRestaurant.fromJson(data);
        });

    // Log the response
  }
}
