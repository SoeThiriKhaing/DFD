// import 'package:dailyfairdeal/controllers/food/res_type_controller.dart';
// import 'package:dailyfairdeal/controllers/location/city_controller.dart';
// import 'package:dailyfairdeal/controllers/location/country_controller.dart';
// import 'package:dailyfairdeal/controllers/location/division_controller.dart';
// import 'package:dailyfairdeal/controllers/location/street_controller.dart';
// import 'package:dailyfairdeal/controllers/location/township_controller.dart';
// import 'package:dailyfairdeal/controllers/location/ward_controller.dart';
// import 'package:dailyfairdeal/repositories/food/get_res_type_repository.dart';
// import 'package:dailyfairdeal/repositories/location/city_repository.dart';
// import 'package:dailyfairdeal/repositories/location/country_repository.dart';
// import 'package:dailyfairdeal/repositories/location/division_repository.dart';
// import 'package:dailyfairdeal/repositories/location/street_repository.dart';
// import 'package:dailyfairdeal/repositories/location/township_repository.dart';
// import 'package:dailyfairdeal/repositories/location/ward_repository.dart';
// import 'package:dailyfairdeal/screens/auth/signup/merchant/selector_map.dart';
// import 'package:dailyfairdeal/screens/food/save_res.dart';
// import 'package:dailyfairdeal/widget/phone_text_field_widget.dart';
// import 'package:dailyfairdeal/services/food/res_type_service.dart';
// import 'package:dailyfairdeal/services/location/city_service.dart';
// import 'package:dailyfairdeal/services/location/country_service.dart';
// import 'package:dailyfairdeal/services/location/division_service.dart';
// import 'package:dailyfairdeal/services/location/street_service.dart';
// import 'package:dailyfairdeal/services/location/township_service.dart';
// import 'package:dailyfairdeal/services/location/ward_service.dart';
// import 'package:dailyfairdeal/widget/reusabel_button.dart';
// import 'package:dailyfairdeal/util/snackbar_helper.dart';
// import 'package:dailyfairdeal/widget/text_form_field_widget.dart';
// import 'package:flutter/material.dart';

// class MerchantSignUp extends StatefulWidget {
//   const MerchantSignUp({super.key});

//   @override
//   State<MerchantSignUp> createState() => _MerchantSignUpState();
// }

// class _MerchantSignUpState extends State<MerchantSignUp> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String? restaurantType, country, division, city, township, ward, street;
//   final TextEditingController shopNameController = TextEditingController();
//   final TextEditingController ownerNameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController floorController = TextEditingController();
//   final TextEditingController blockController = TextEditingController();
//   final TextEditingController openTimeController = TextEditingController();
//   final TextEditingController closeTimeController = TextEditingController();

//   List<Map<String, String>> countryList = [];
//   List<Map<String, String>> divisionList = [];
//   List<Map<String, String>> cityList = [];
//   List<Map<String, String>> townshipList = [];
//   List<Map<String, String>> wardList = [];
//   List<Map<String, String>> streetList = [];
//   List<Map<String, String>> restaurantTypeList = [];

//   int? selectedRestaurantTypeId,
//       selectedCountryId,
//       selectedDivisionId,
//       selectedCityId,
//       selectedTownshipId,
//       selectedWardId,
//       selectedStreetId;

//   final List<Map<String, String>> businessTypeList = [
//     {'id': '1', 'name': 'Restaurant'},
//     {'id': '2', 'name': 'Shop'},
//   ];

//   String? selectedBusinessType;

//   late RestaurantTypeController resTypeController;
//   late CountryController countryController;
//   late DivisionController divisionController;
//   late CityController cityController;
//   late TownshipController townshipController;
//   late WardController wardController;
//   late StreetController streetController;

//   @override
//   void initState() {
//     super.initState();
//     resTypeController = RestaurantTypeController(
//         service: RestaurantTypeService(repository: RestaurantTypeRepository()));
//     countryController = CountryController(
//         service: CountryService(repository: CountryRepository()));
//     divisionController = DivisionController(
//         service: DivisionService(repository: DivisionRepository()));
//     cityController = CityController(
//         service: CityService(repository: CityRepository()));
//     townshipController = TownshipController(
//         service: TownshipService(repository: TownshipRepository()));
//     wardController = WardController(
//         service: WardService(repository: WardRepository()));
//     streetController = StreetController(
//         service: StreetService(repository: StreetRepository()));
//   }

//   Future<void> selectTime(
//       BuildContext context, TextEditingController controller) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         controller.text = picked.format(context);
//       });
//     }
//   }

//   void clear() {
//     shopNameController.clear();
//     selectedRestaurantTypeId = null;
//     ownerNameController.clear();
//     phoneController.clear();
//     openTimeController.clear();
//     closeTimeController.clear();
//     country = division = city = township = ward = street = null;
//     blockController.clear();
//     floorController.clear();
//     descriptionController.clear();
//   }

//   Future<void> saveData() async {
//     final data = {
//       "restaurant_type_id": selectedRestaurantTypeId,
//       "name": shopNameController.text.trim(),
//       "open_time": openTimeController.text,
//       "close_time": closeTimeController.text,
//       "phone_number": phoneController.text.trim(),
//       "addressData": {
//         "street_id": selectedStreetId,
//         "block_no": blockController.text,
//         "floor": floorController.text,
//         "latitude": 40.7128,
//         "longitude": -74.0060,
//       },
//     };
//     try {
//       saveRestaurantData(data);
//       clear();
//     } catch (e) {
//       SnackbarHelper.showSnackbar(
//         title: "Error",
//         message: "Failed to save restaurant data. Please try again.",
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Ready to expand your business?',
//           style: TextStyle(
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Center(
//                   child: Text(
//                     'Fill out the form below',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 buildTextFormField('Restaurant/Shop Name', shopNameController,
//                     keyboardType: TextInputType.text),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Choose Business Type",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 ...businessTypeList.map((business) {
//                   return Row(
//                     children: [
//                       Radio<String>(
//                         value: business['name']!,
//                         groupValue: selectedBusinessType,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedBusinessType = value;
//                           });
//                         },
//                       ),
//                       Text(
//                         business['name']!,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   );
//                 }),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Address",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 SelectorMap(
//                   label: 'Country',
//                   selectedValue: selectedCountryId?.toString(),
//                   loadItems: countryController.loadCountryList,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCountryId = int.tryParse(value ?? '');
//                       selectedDivisionId = selectedCityId = selectedTownshipId =
//                           selectedWardId = selectedStreetId = null;
//                       debugPrint("Selected Country ID: $selectedCountryId");
//                     });
//                   },
//                 ),  
//                 if (selectedCountryId != null) ...[
//                   const SizedBox(height: 10),
//                   SelectorMap(
//                     label: 'Division/State',
//                     selectedValue: selectedDivisionId?.toString(),
//                     loadItems: () => divisionController.loadDivisionList(selectedCountryId!),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedDivisionId = int.tryParse(value ?? '');
//                         selectedCityId = selectedTownshipId = selectedWardId = selectedStreetId = null;
//                         debugPrint("Selected Division ID: $selectedDivisionId");
//                       });
//                     },
//                   ),
//                 ],
//                 if (selectedDivisionId != null) ...[
//                   const SizedBox(height: 10),
//                   SelectorMap(
//                     label: 'City',
//                     selectedValue: selectedCityId?.toString(),
//                     loadItems: () => cityController.loadCityList(selectedDivisionId!),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCityId = int.tryParse(value ?? '');
//                         selectedTownshipId = selectedWardId = selectedStreetId = null;
//                         debugPrint("Selected City ID: $selectedCityId");
//                       });
//                     },
//                   ),
//                 ],
//                 if (selectedCityId != null) ...[
//                   const SizedBox(height: 10),
//                   SelectorMap(
//                     label: 'Township',
//                     selectedValue: selectedTownshipId?.toString(),
//                     loadItems: () => townshipController.loadTownshipList(selectedCityId!),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedTownshipId = int.tryParse(value ?? '');
//                         selectedWardId = selectedStreetId = null;
//                         debugPrint("Selected Township ID: $selectedTownshipId");
//                       });
//                     },
//                   ),
//                 ],
//                 if (selectedTownshipId != null) ...[
//                   const SizedBox(height: 10),
//                   SelectorMap(
//                     label: 'Ward',
//                     selectedValue: selectedWardId?.toString(),
//                     loadItems: () => wardController.loadWardList(selectedTownshipId!),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWardId = int.tryParse(value ?? '');
//                         selectedStreetId = null;
//                         debugPrint("Selected Ward ID: $selectedWardId");
//                       });
//                     },
//                   ),
//                 ],
//                 if (selectedWardId != null) ...[
//                   const SizedBox(height: 10),
//                   SelectorMap(
//                     label: 'Street',
//                     selectedValue: selectedStreetId?.toString(),
//                     loadItems: () => streetController.loadStreetList(selectedWardId!),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedStreetId = int.tryParse(value ?? '');
//                       });
//                     },
//                   ),
//                 ],
//                 const SizedBox(height: 10),
//                 buildTextFormField('Owner Name', ownerNameController,
//                     keyboardType: TextInputType.text),
//                 const SizedBox(height: 10),
//                 buildPhoneField(phoneController),
//                 const SizedBox(height: 20),
//                 buildSubmitButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSubmitButton() {
//     return ReusableButton(
//       text: "Submit",
//       onPressed: () {
//         if (formKey.currentState!.validate()) {
//           saveData();
//         }
//       },
//     );
//   }
// }