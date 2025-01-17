import 'dart:convert';
import 'package:dailyfairdeal/interfaces/food/i_res_type_repository.dart';
import 'package:dailyfairdeal/models/food/res_type_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/services/secure_storage.dart';
import 'package:dailyfairdeal/util/appurl.dart';


class RestaurantTypeRepository implements IRestaurantTypeRepository {
  final apiService = ApiService();
  @override
  Future<List<RestaurantType>> getRestaurantType() async{
    try{
      final token = await getToken();
      if (token == null) {
        throw Exception("Unauthorized: Token not found");
      }
     final response = await apiService.request(
      AppUrl.getResTypes, // Endpoint
      method: "GET", // HTTP method
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>RestaurantType.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load restaurant types: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
