import 'package:dailyfairdeal/interfaces/food/i_order_again.dart';
import 'package:dailyfairdeal/models/food/order_again_model.dart';
import 'package:dailyfairdeal/repositories/repo_api_call_services/api_helper.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class GetOrderAgainRepository implements IOrderAgain {
  @override
  Future<List<OrderAgain>> getOrderAgain() async {
    return await ApiHelper.fetchList<OrderAgain>(
        endpoint: AppUrl.getOrderAgain,
        fromJson: (data) {
          print("Raw data from API:$data");
         return OrderAgain.fromJson(data);
        });

    // Log the response
  }
}
