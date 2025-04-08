import 'package:dailyfairdeal/main.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_appbar.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_body.dart';
import 'package:dailyfairdeal/screens/taxi/taxi_home/taxi_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxiHomeUserScreen extends StatefulWidget {
  const TaxiHomeUserScreen({super.key});

  @override
  State<TaxiHomeUserScreen> createState() => _TaxiHomeUserScreenState();
}

class _TaxiHomeUserScreenState extends State<TaxiHomeUserScreen> with RouteAware {
  TaxiHomeController controller = TaxiHomeController();
  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
    controller.getCurrentLocation();
    Get.put(this); // Inject this instance
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic>) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPop() {
    controller.deleteTrip(); // Call delete function when back button is pressed
    super.didPop();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    controller.stopSearchingForDrivers();
    controller.locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TaxiHomeAppBar(),
      body: TaxiHomeBody(),
    );
  }
}
