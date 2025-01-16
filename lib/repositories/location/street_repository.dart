import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_street_repository.dart';
import 'package:dailyfairdeal/models/location/street_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class StreetRepository implements IStreetRepository {
  final apiService = ApiService();
  @override
  Future<List<Street>> getStreetById(int wardId) async{
    try{
    final String url = '${AppUrl.getStreetById}/$wardId';
    final response = await apiService.get(
      url as String Function(String wardId), // Endpoint
      method: "GET", // HTTP method
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>Street.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load Street: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
