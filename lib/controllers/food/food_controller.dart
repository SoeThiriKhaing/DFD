// import 'package:dailyfairdeal/controllers/food/all_res_controller.dart';
// import 'package:dailyfairdeal/controllers/food/feature_res_controller.dart';
// import 'package:dailyfairdeal/controllers/food/order_again_controller.dart';
// import 'package:dailyfairdeal/repositories/food/get_all_res_repository.dart';
// import 'package:dailyfairdeal/repositories/food/get_feat_res_repository.dart';
// import 'package:dailyfairdeal/repositories/food/get_order_again_repository.dart';
// import 'package:dailyfairdeal/services/food/all_res_service.dart';
// import 'package:dailyfairdeal/services/food/feat_res_service.dart';
// import 'package:dailyfairdeal/services/food/order_again_service.dart';
// import 'package:get/get.dart';

// class FoodController extends GetxController {
//   var selectedCategory = ''.obs;
//   var featuredRestaurants = [].obs;
//   var popularRestaurant = [].obs;
//   var orderAgain = [].obs;
//   var allRestaurants = [].obs;
  
//   late final AllResController allResController;
//   late final FeatureResController featResController;
//   late final OrderAgainController orderAgainController;

//   @override
//   void onInit() {
//     super.onInit();
    
//     // Initialize with default category or state
//     selectedCategory.value = "Restaurants";
    
//     // Initialize the controllers with their respective services
//     allResController = AllResController(
//         service: AllResService(repository: GetAllResRepository()));
//     featResController = FeatureResController(
//         service: FeatResService(repository: GetFeatResRepository()));
//     orderAgainController = OrderAgainController(
//         service: OrderAgainService(repository: GetOrderAgainRepository()));
    
//     // Fetch all data when controller is initialized
//     fetchAllRestaurants();
//     getFeatureRestaurants();
//     fetchOrderAgain();
//   }

//   // Fetch all restaurants from AllResController
//   void fetchAllRestaurants() async {
//     try {
//       final result = await allResController.loadAllRestaurant();
//       allRestaurants.value = result; // Update the observable list
//     } catch (e) {
//       print("Error fetching all restaurants: $e");
//     }
//   }

//   // Fetch featured restaurants from FeatureResController
//   void getFeatureRestaurants() async {
//     try {
//       final result = await featResController.loadFeatRestaurant();
//       featuredRestaurants.value = result; // Update the observable list
//     } catch (e) {
//       print("Error fetching featured restaurants: $e");
//     }
//   }

//   // Fetch order again data from OrderAgainController
//   void fetchOrderAgain() async {
//     try {
//       final result = await orderAgainController.loadOrderAgain();
//       orderAgain.value = result; // Update the observable list
//     } catch (e) {
//       print("Error fetching order again: $e");
//     }
//   }

//   // Determine the data to display based on the selected category
//   List<dynamic> getDatatoDisplay() {
//     if (selectedCategory.value == "Featured Restaurants") {
//       return featuredRestaurants;
//     } else if (selectedCategory.value == "Popular Restaurants") {
//       return allRestaurants;
//     } else if (selectedCategory.value == "Order Again") {
//       return orderAgain;
//     } else {
//       return [];
//     }
//   }
// }
