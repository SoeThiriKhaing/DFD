import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_township_repository.dart';
import 'package:dailyfairdeal/models/location/township_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class TownshipRepository implements ITownshipRepository {
  final apiService = ApiService();
  @override
  Future<List<Township>> getTownshipById(int cityId) async{
    try{
    final String url = '${AppUrl.getTownshipById}/$cityId';
    final response = await apiService.get(
      url as String Function(String cityId), // Endpoint
      method: "GET", // HTTP method
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>Township.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load township: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
