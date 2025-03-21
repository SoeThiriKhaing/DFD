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

  //Country Api
  static String getCountry = "$baseUrl/country";
  static String addCountry = "$baseUrl/country";
  static String updateCountry = "$baseUrl/country";
  static String deleteCountry = "$baseUrl/country";

  //Division Api
  static String getDivisionById = "$baseUrl/state";
  static String getDivisions = "$baseUrl/state";
  static String addDivision = "$baseUrl/state";
  static String updateDivision = "$baseUrl/state";
  static String deleteDivision = "$baseUrl/state";

  //City Api
  static String getCitiesById = "$baseUrl/city";
  static String getCities = "$baseUrl/city";
  static String addCity = "$baseUrl/city";
  static String updateCity = "$baseUrl/city";
  static String deleteCity = "$baseUrl/city";

  //Township Api  
  static String getTownships = "$baseUrl/township";
  static String getTownshipById = "$baseUrl/township";
  static String addTownship = "$baseUrl/township";
  static String updateTownship = "$baseUrl/township"; 
  static String deleteTownship = "$baseUrl/township";

  //Ward Api
  static String getWards = "$baseUrl/ward";
  static String getWardById = "$baseUrl/ward";
  static String addWard = "$baseUrl/ward";
  static String updateWard = "$baseUrl/ward";
  static String deleteWard = "$baseUrl/ward";

  //Street Api
  static String getStreetById = "$baseUrl/street";
  static String getStreets = "$baseUrl/street";
  static String addStreet = "$baseUrl/street";
  static String updateStreet = "$baseUrl/street";
  static String deleteStreet = "$baseUrl/street";
  
 //taxi driver Api
  static String getDriverById = "$baseUrl/taxi-drivers/{id}";
  static String getDriver = "$baseUrl/taxi-drivers";
  static String createDriver = "$baseUrl/taxi-drivers";
  static String updateDriver = "$baseUrl/taxi-drivers";
  static String deleteDriver = "$baseUrl/taxi-drivers";
  //static String getDriverByUserId = "$baseUrl/taxi-drivers/$userId";

  //Nearby Taxi Driver
  static String getNearbyTaxiDriver = "$baseUrl/biddings";

  //Submit Bid Price by Taxi Driver
  static String submitBidPrice = "$baseUrl/biddings";

  //Get the number of taxi driver
  static String getNumberOfTaxiDriver = "$baseUrl/taxi-driver/user";

  //travel Api
  static String createTravel = "$baseUrl/travels";
  static String updateTravle = "$baseUrl/travels";
  static String deleteTravel = "$baseUrl/travels";
  static String getTravel = "$baseUrl/travels";

  //Driver Notification

  static String getNoti = "$baseUrl/driver";
}
