import 'dart:convert';
import 'package:dailyfairdeal/interfaces/location/i_country_repository.dart';
import 'package:dailyfairdeal/models/location/country_model.dart';
import 'package:dailyfairdeal/services/api_service.dart';
import 'package:dailyfairdeal/util/appurl.dart';

class CountryRepository implements ICountryRepository {
  final apiService = ApiService();
  @override
  Future<List<Country>> getCountries() async{
    try{
     final response = await apiService.request(
      AppUrl.getCountry, // Endpoint
      method: "GET", // HTTP method
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json)=>Country.fromJson(json)).toList();
    }else{
      throw Exception("Fail to load country list: ${response.statusCode}");
    }
    }catch(e){
      throw Exception("An unexpected error occurred: $e");
    }
  }
  
}
