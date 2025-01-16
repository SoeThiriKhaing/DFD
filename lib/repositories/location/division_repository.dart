import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_division_repository.dart';
import 'package:dailyfairdeal/models/location/division_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class DivisionRepository implements IDivisionRepository {
  final apiService = ApiService();
  @override
  Future<List<Division>> getDivisionById(int countryId) async{
    try{
    final String url = '${AppUrl.getDivisionById}/$countryId';
    // Make GET request using ApiService
    final response = await apiService.request(url, method: "GET");
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>Division.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load division: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
