import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_city_repository.dart';
import 'package:dailyfairdeal/models/location/city_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class CityRepository implements ICityRepository {
  final apiService = ApiService();
  @override
  Future<List<City>> getCityById(int divisionId) async{
    try{
    final String url = '${AppUrl.getCitiesById}/$divisionId';
    final response = await apiService.request(url, method: "GET");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>City.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load city: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
