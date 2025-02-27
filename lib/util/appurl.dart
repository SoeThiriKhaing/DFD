class AppUrl {
  static var baseUrl = "http://api.dailyfairdeal.com/api";
  static var loginEndpoint = '$baseUrl/login';
  static var registerEndpoint = '$baseUrl/signup';

  //Food Api
  static var getAllRestaurant = '$baseUrl/restaurant';
  static var getFavCuisines = '$baseUrl/favourite-cuisine';
  static var getFeatRestaurant = '$baseUrl/feature-restaurants';
  static var getOrderAgain = '$baseUrl/order-it-again';
  static var getPopularFood = '$baseUrl/popular-foods';
  static var getResTypes = '$baseUrl/restaurant_types';

  //Location Api

  static String getCountry = "$baseUrl/country";
  static String getDivisionById()=>'$baseUrl/state';
  static String getCitiesById() => '$baseUrl/city';
  static String getTownshipById() => '$baseUrl/township';
  static String getWardById() => '$baseUrl/ward';
  static String getStreetById() => '$baseUrl/street';
}
