import 'package:dailyfairdeal/controllers/food/all_res_controller.dart';
import 'package:dailyfairdeal/repositories/food/get_all_res_repository.dart';
import 'package:dailyfairdeal/services/food/all_res_service.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  var selectedCategory = ''.obs;
  var featuredRestaurants = [].obs;
  var popularRestaurant = [].obs;
  var orderAgain = [].obs;
  var allRestaurants = [].obs;
  late final AllResController allResController;

  @override
  void onInit() {
    super.onInit();
    // Initialize with default category or state
    selectedCategory.value = "Restaurants";
    allResController = AllResController(
        service: AllResService(repository: GetAllResRepository()));

    // Fetch all restaurants when the controller is initialized
  }

  void fetchAllRestaurants() async {
    try {
      final result = await allResController.loadAllRestaurant();
      allRestaurants.value = result; // Update the observable list
    } catch (e) {
      print("Error fetching restaurants: $e");
    }
  }

  void getFeatureRestaurants() {}

  void fetchPopularRestaurants() {
    fetchPopularRestaurants();
  }

  void fetchOrderAgain() {
    fetchOrderAgain();
  }

  List<dynamic> getDatatoDisplay() {
    if (selectedCategory.value == "Featured Restaurants") {
      return featuredRestaurants;
    } else if (selectedCategory.value == "Popular Restaurants") {
      return orderAgain;
    } else if (selectedCategory.value == "Popular Foods") {
      return popularRestaurant;
    } else {
      return [];
    }
  }
}
