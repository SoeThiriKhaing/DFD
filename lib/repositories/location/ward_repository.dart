import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_ward_repository.dart';
import 'package:dailyfairdeal/models/location/ward_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class WardRepository implements IWardRepository {
  final apiService = ApiService();
  @override
  Future<List<Ward>> getWardById(int townshipId) async{
    try{
    final String url = '${AppUrl.getWardById}/$townshipId';
    final response = await apiService.get(
      url as String Function(String townshipId), // Endpoint
      method: "GET", // HTTP method
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>Ward.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load ward: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
