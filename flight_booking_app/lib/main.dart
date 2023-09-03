import 'package:flight_booking_app/screens/home_screen.dart';
import 'package:flight_booking_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';

main() async {
  // final createDb = CreateDb();
  // await createDb.createAirplaneAirlineDb();
  
  return runApp(
    FlightApp()
  );
} //ef

class FlightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading App',
      initialRoute: '/loading', // Set the initial route to the LoadingScreen
      routes: {
        '/loading': (context) => LoadingScreen(), // Route for the loading screen
        '/main': (context) => HomePage(), // Route for the main page
      },
    );
  }
}