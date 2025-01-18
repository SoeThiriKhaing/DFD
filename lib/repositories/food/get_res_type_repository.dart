import 'package:dailyfairdeal/interfaces/food/i_res_type_repository.dart';
import 'package:dailyfairdeal/models/food/res_type_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';


class RestaurantTypeRepository implements IRestaurantTypeRepository {
  
  /// Fetch restaurant types specifically
  @override
  Future<List<RestaurantType>> fetchRestaurantTypes() async {
    return await ApiHelper.fetchList<RestaurantType>(
      endpoint: AppUrl.getResTypes,
      fromJson: (data) => RestaurantType.fromJson(data),
    );
  }
}
