import 'package:flutter/material.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:intl/intl.dart';

class FlightDetailList extends StatelessWidget {
  final segment;


  FlightDetailList({
    required this.segment,
  });


  final dbHelper = DatabaseHelper.instance;
 

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0), // Add margin to the elements within the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
          children: [
            Row(
              children: [
                FutureBuilder<String?>( // Airline logo
                  future: dbHelper.findLogo(segment['carrierCode']),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Airline Name Not Found', textAlign: TextAlign.left);
                    } else {
                      return 
                          Image.network(snapshot.data!,height: 40,);
                    }
                  },
                ),
                SizedBox(width: 10,),
                Column( // Airline name and code
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String?>(
                  future: dbHelper.getAirlineNameByCode(segment['carrierCode']),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Airline Name Not Found');
                    } else {
                      return 
                          Text(snapshot.data!,style: TextStyle(fontWeight: FontWeight.bold),);
                    }
                  },
                ),
                 Text('${segment['carrierCode']}${segment['number']}',style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.left,),
                  ],
                )
              ],
            ),
            Divider(color: Colors.black26,),
            StepperWidget(flight: segment,),
          ],
        ),
      ), // Add some margin for spacing
    );
  }
}

class StepperWidget extends StatelessWidget {
  final flight;

  StepperWidget({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;
      
      String calculateDuration(String departureTime, String arrivalTime) {
  DateTime departureDateTime = DateTime.parse(departureTime);
  DateTime arrivalDateTime = DateTime.parse(arrivalTime);
  
  Duration duration = arrivalDateTime.difference(departureDateTime);
  
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  
  return '$hours hr $minutes min';
}

      //String duration =  convertDuration( flight.itineraries['duration']);

    return FutureBuilder<String>(
      future: dbHelper.findAirportNameByIATA(flight['departure']['iataCode']),
      builder: (BuildContext context, AsyncSnapshot<String> departureSnapshot) {
        return FutureBuilder<String>(
          future: dbHelper.findAirportNameByIATA(flight['arrival']['iataCode']),
          builder: (BuildContext context, AsyncSnapshot<String> arrivalSnapshot) {
            List<StepperData> stepperData = [
              StepperData(
                title: StepperText(
                  DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(flight['departure']['at'].substring(11))) +
                      ', ' + DateFormat('MMM dd, yy').format(DateTime.parse(flight['departure']['at'].substring(0, 10))),
                ),
                subtitle: StepperText(
                  departureSnapshot.connectionState == ConnectionState.waiting
                      ? 'Loading...' // Display a loading message if data is not yet available
                      : departureSnapshot.hasError
                          ? 'Error: ${departureSnapshot.error}' // Display an error message if there's an error
                          : (departureSnapshot.data ?? 'Unknown Airport'),
                    
                ),
                iconWidget: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEC441E),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Icon(Icons.flight_takeoff, color: Colors.white, size: 20,),
                ),
              ),
              StepperData(
                title: StepperText(
                calculateDuration( flight['departure']['at'],flight['arrival']['at']),
                  textStyle: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
                //subtitle: StepperText("Your order has been placed"),
                iconWidget: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Icon(Icons.access_time_filled, color: Color(0xFFEC441E), size: 20,),
                ),
              ),
              StepperData(
                title: StepperText(
                  DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(flight['arrival']['at'].substring(11))) +
                      ', ' + DateFormat('MMM dd, yy').format(DateTime.parse(flight['arrival']['at'].substring(0, 10))),
                ),
                subtitle: StepperText(
                  arrivalSnapshot.connectionState == ConnectionState.waiting
                      ? 'Loading...' // Display a loading message if data is not yet available
                      : arrivalSnapshot.hasError
                          ? 'Error: ${arrivalSnapshot.error}' // Display an error message if there's an error
                          : (arrivalSnapshot.data ?? 'Unknown Airport'),
                  
                ),
                iconWidget: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEC441E),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Icon(Icons.flight_land, color: Colors.white, size: 20,),
                ),
              ),
              // Add more StepperData items as needed
            ];

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 1, left: 1),
                  child: AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.vertical,
                    iconWidth: 30,
                    iconHeight: 30,
                    activeBarColor: Color(0xFFEC441E),
                    //inActiveBarColor: Colors.grey,
                    inverted: false,
                    verticalGap: 20,
                    activeIndex: 2,
                    barThickness: 3,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
