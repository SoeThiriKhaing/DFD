import 'package:dailyfairdeal/controllers/location/city_controller.dart';
import 'package:dailyfairdeal/controllers/location/country_controller.dart';
import 'package:dailyfairdeal/controllers/location/division_controller.dart';
import 'package:dailyfairdeal/controllers/location/street_controller.dart';
import 'package:dailyfairdeal/controllers/location/township_controller.dart';
import 'package:dailyfairdeal/controllers/location/ward_controller.dart';
import 'package:dailyfairdeal/controllers/restaurant_type_controller.dart';
import 'package:dailyfairdeal/service/food_api/set_res.dart';
import 'package:dailyfairdeal/screens/widgets/dropdown_field_widget.dart';
import 'package:dailyfairdeal/screens/widgets/phone_text_field_widget.dart';
import 'package:dailyfairdeal/widget/reusabel_button.dart';
import 'package:dailyfairdeal/util/snackbar_helper.dart';
import 'package:dailyfairdeal/screens/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class MerchantSignUp extends StatefulWidget {
  const MerchantSignUp({super.key});

  @override
  State<MerchantSignUp> createState() => _MerchantSignUpState();
}

class _MerchantSignUpState extends State<MerchantSignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? restaurantType, country, division, city, township, ward, street;
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController openTimeController = TextEditingController();
  final TextEditingController closeTimeController = TextEditingController();

  List<Map<String, String>> countryList = [];
  List<Map<String, String>> divisionList = [];
  List<Map<String, String>> cityList = [];
  List<Map<String, String>> townshipList = [];
  List<Map<String, String>> wardList = [];
  List<Map<String, String>> streetList = [];
  List<Map<String, String>> restaurantTypeList = [];

  int? selectedRestaurantTypeId, selectedCountryId, selectedDivisionId, selectedCityId, selectedTownshipId, selectedWardId, selectedStreetId;

  final List<Map<String, String>> businessTypeList = [
    {'id': '1', 'name': 'Restaurant'},
    {'id': '2', 'name': 'Shop'},
  ];

  String? selectedBusinessType;

  late RestaurantTypeController resTypeController;
  late CountryController countryController;
  late DivisionController divisionController;
  late CityController cityController;
  late TownshipController townshipController;
  late WardController wardController;
  late StreetController streetController;
  
  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  // Fetch the countries and update the state
  Future<void> fetchAddress() async {
    try {
      List<Map<String, String>> countries = await countryController.loadCountryList();
      List<Map<String, String>> restaurantTypes = await resTypeController.loadRestaurantTypes();
      setState(() {
        countryList = countries;
        restaurantTypeList = restaurantTypes;
        selectedBusinessType = businessTypeList.first['name'];
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching country: $e");
      
    }
  }

  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  void clear(){
    shopNameController.clear();
    selectedRestaurantTypeId=null;
    ownerNameController.clear();
    phoneController.clear();
    openTimeController.clear();
    closeTimeController.clear();
    country = division = city = township = ward = street = null;
    blockController.clear();
    floorController.clear();
    descriptionController.clear();
  }

  Future <void> saveData() async{
    final data = {
      "restaurant_type_id": selectedRestaurantTypeId,
      "name": shopNameController.text.trim(),
      "open_time": openTimeController.text,
      "close_time": closeTimeController.text,
      "phone_number": phoneController.text.trim(),
      "addressData": {
        "street_id": selectedStreetId,
        "block_no": blockController.text,
        "floor": floorController.text,
        "latitude": 40.7128,
        "longitude": -74.0060,
      },
    };
    try {
      saveRestaurantData(data);
      clear();
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: "Failed to save restaurant data. Please try again.",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ready to expand your business?',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Fill out the form below',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextFormField('Restaurant/Shop Name', shopNameController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                const Text("Choose Business Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...businessTypeList.map((business) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: business['name']!,
                        groupValue: selectedBusinessType,
                        onChanged: (value) {
                          setState(() {
                            selectedBusinessType = value;
                          });
                        },
                      ),
                      Text(
                        business['name']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),

                if(selectedBusinessType =='Restaurant')
                  buildDropdownField(
                    'Select Restaurant Type',
                    restaurantType,
                    restaurantTypeList, 
                    (value) async{
                      setState(() { 
                        restaurantType = value; 
                        selectedRestaurantTypeId = int.tryParse(restaurantTypeList.firstWhere(
                        (item) => item['name'] == value)['id']!) ?? 0;
                      });
                  }),
                  const SizedBox(height: 10),
                
                buildTextFormField('Owner Name', ownerNameController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildPhoneField(phoneController),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectTime(context, openTimeController),
                        child: AbsorbPointer(
                          child: buildTextFormField('Open Time', openTimeController),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => selectTime(context, closeTimeController),
                        child: AbsorbPointer(
                          child: buildTextFormField('Close Time', closeTimeController),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Restaurant/Shop Address", style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildAddressFields(),
                const SizedBox(height: 10),
                 buildTextFormField('Block', blockController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                 buildTextFormField('Floor', floorController, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                buildTextFormField('Description', descriptionController, keyboardType: TextInputType.text, maxLines: 3),
                const SizedBox(height: 20),
                buildSubmitButton(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddressFields() {
    return Column(
      children: [
        // First row: Country and Division
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Country',
                country,
                countryList,
                (value) async {
                  setState(() {
                    country = value;
                    division = city = township = ward = street = null;
                    selectedCountryId = int.tryParse(countryList.firstWhere(
                      (item) => item['name'] == value)['id']!) ?? 0;
                  });
                  if (selectedCountryId != null && selectedCountryId != 0) {
                    divisionList = await divisionController.loadDivisionById(selectedCountryId!);
                    setState(() {}); // Refresh dropdown
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Division',
                division,
                divisionList,
                (value) async {
                  setState(() {
                    division = value;
                    city = township = ward = street = null;
                    selectedDivisionId = int.tryParse(
                        divisionList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedDivisionId != null) {
                    cityList = await cityController.loadCityById(selectedDivisionId!);
                    setState(() {});
                  }
                } 
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
    
        // Second row: City and Township
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'City',
                city,
                cityList,
                (value) async {
                  setState(() {
                    city = value;
                    township = ward = street = null;
                    selectedCityId = int.tryParse(
                        cityList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedCityId != null) {
                    townshipList = await townshipController.loadTownshipById(selectedCityId!);
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Township',
                township,
                townshipList,
                (value) async {
                  setState(() {
                    township = value;
                    ward = street = null;
                    selectedTownshipId = int.tryParse(
                        townshipList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedTownshipId != null) {
                    wardList = await wardController.loadWardById(selectedTownshipId!);
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
    
        // Third row: Ward and Street
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Ward',
                ward,
                wardList,
                (value) async {
                  setState(() {
                    ward = value;
                    street = null;
                    selectedWardId = int.tryParse(
                        wardList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                  if (selectedWardId != null) {
                    streetList = await streetController.loadStreetById(selectedWardId!);
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: buildDropdownField(
                'Street',
                street,
                streetList,
                (value) async{
                  setState(() {
                    street = value;
                    selectedStreetId = int.tryParse(
                        streetList.firstWhere((item) => item['name'] == value)['id']!);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return ReusableButton(
      text: "Submit",
      onPressed: () {
        if (formKey.currentState!.validate()) {
          saveData();
        }
      },
    );
  }

  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
