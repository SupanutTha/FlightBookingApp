// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/models/save_flight.dart';
import 'package:flight_booking_app/models/selected_flights.dart';
import 'package:flight_booking_app/screens/trip_screen.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_detail_list.dart';
import 'package:flight_booking_app/widgets/suggest_list/summary_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_suggest_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SummaryFlight2 extends StatefulWidget{

  @override
  _SummaryFlight2State createState() => _SummaryFlight2State();
  
}

class _SummaryFlight2State extends State<SummaryFlight2>{
  bool isTripSaved = false;
  @override
  void initState()   {
    super.initState();
    isTripSaved = SaveFlights.isTripSaved(SelectedFlights.selectedFlights);
  }
  
  final dbHelper = DatabaseHelper.instance;
    int connectingFlight =SelectedFlights.selectedFlights[0].itineraries[0]['segments'].length;String formatDate(String inputDate) {
    final dateTime = DateTime.parse(inputDate);
    final formatter = DateFormat('E, d MMM');
    return formatter.format(dateTime);
  }
  String flightTypeText(int numberOfSelectedFlights) {
  if (numberOfSelectedFlights == 1) {
    return 'one way';
  } else if (numberOfSelectedFlights > 1) {
    return 'return';
  } else {
    return ''; // Handle other cases as needed
  }
}
  double price = 0;
  RegExp regExp = RegExp(r'(\d+\.\d+)');
  @override
  Widget build(BuildContext context) {
    print(SelectedFlights.selectedFlights);
    // Match match = regExp.firstMatch(SelectedFlights.selectedFlights[0].price.toString());
    // if (match != null) {
    //   // Extracted numeric value from the match
    //   String numericValue = match.group(0);
    //   price = double.parse(numericValue);
    // } else {
    //   // Handle the case where no numeric value was found
    //   price = 0.0; // Or any other default value you prefer
    // }

    if (SelectedFlights.selectedFlights.length == 2){
      price = double.parse(SelectedFlights.selectedFlights[0].price['total'].toString()) + double.parse(SelectedFlights.selectedFlights[1].price['total'].toString());
    }
    else{
      price = double.parse(SelectedFlights.selectedFlights[0].price['total'].toString());
    }
    print(price);
    print(SelectedFlights.selectedFlights[0].itineraries[0]['segments'].length);
    print(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode'] );
    int connectionFlight = SelectedFlights.selectedFlights[0].itineraries[0]['segments'].length;
    return  WillPopScope(
      onWillPop: () async {
        SelectedFlights.removeSelectedFlight(SelectedFlights.selectedFlights[SelectedFlights.selectedFlights.length-1]); // Clear selected flights when user clicks back button
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0, 
          backgroundColor: Colors.white,
          title: Text("Trip Summary",style: TextStyle(color: Colors.black),),
                    iconTheme: IconThemeData(
                      color: Colors.black
                    ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black26
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    Row( // desination
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              FutureBuilder<String>(
                                future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Column(
                                      children: [
                                        Text(
                                          '${snapshot.data}',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color:Color(0xFFEC441E)),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon (Icons.arrow_forward_rounded, size: 40,),
                        ),
                        Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    FutureBuilder<String>(
                                      future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][connectingFlight-1]['arrival']['iataCode'] ),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        } else {
                                          return Text(
                                            '${snapshot.data}',
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Color(0xFFEC441E)),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(formatDate(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['at'])),
                        Text(" - "),
                        Text(formatDate(
                          SelectedFlights.selectedFlights.length == 1
                              ? SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['at']
                              : SelectedFlights.selectedFlights[1].itineraries[0]['segments'][0]['arrival']['at']),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${SelectedFlights.selectedFlights[0].numberOfBookableSeats.toString()} traveller'),
                        Text(' · '),
                        Text( flightTypeText(SelectedFlights.selectedFlights.length)),
                        Text(' · '),
                        Text('${SelectedFlights.selectedFlights[0].travelerPricings[0]['fareDetailsBySegment'][0]['cabin'].toString().toLowerCase()} class'),
                      ],
                    ),
                  // You can add other widgets above your list if needed
                 ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                itemCount: SelectedFlights.selectedFlights.length,
                itemBuilder: (BuildContext context, int index) {
                  final flight = SelectedFlights.selectedFlights[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SummaryFlightList(selectedFlights: flight),
                    ),
                  );
                },
              ),
              ),
              Container(
                width: 500,
                color: Color(0xFFEC441E), // Customize the background color
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Add your bottom section content here
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Total",
                          style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '€ ${price.toString()}',
                          style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white,),
                  Padding( // search button
                    padding: const EdgeInsets.only(
                      bottom: 20, left: 35, top: 20, right: 35),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isTripSaved ? Icons.favorite : Icons.favorite_border,
                              color: Color(0xFFEC441E),
                            ),
                            SizedBox(width: 10, height: 50,),
                            Text(
                              isTripSaved ? 'Unsave This Trip' : 'Save This Trip',
                              style: TextStyle(
                                color: Color(0xFFEC441E),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          if (isTripSaved) {
                            // Remove the trip from SaveFlights
                            SaveFlights.saveFlights.removeWhere((savedTrip) => listEquals(savedTrip, SelectedFlights.selectedFlights));


                            //print(SaveFlights.se)
                            Navigator.push(
                                      context,
                                       MaterialPageRoute(
                                        builder: (context) => TripScreen()
                                        ),
                                      );
                            // Trip is now unsaved
                            isTripSaved = false;
                          } else {
                            // Create a new list to store the selected flights
                            List<Flight> selectedFlightsToSave = List.from(SelectedFlights.selectedFlights);

                            // Add the selected flights to SaveFlights
                            SaveFlights.addSaveFlight(selectedFlightsToSave);

                            // Trip is now saved
                            isTripSaved = true;
                            Navigator.push(
                                      context,
                                       MaterialPageRoute(
                                        builder: (context) => TripScreen()
                                        ),
                                      );
                          }

                          // Clear the selected flights list
                          SelectedFlights.selectedFlights.clear();

                          // Verify that the lists are not connected
                          print("Selected Flights after clearing: ${SelectedFlights.selectedFlights}");
                          print("Saved Flights: ${SaveFlights.saveFlights}");

                          // Update the UI
                          //setState(() {});
                        },
                      ),
                    ),
                  ] 
                ),
              ),
               ],
              ),
        )
      )
    );
          
    
  }
}

// }
//                   Padding( // search button
//                                   padding: const EdgeInsets.only(
//                                      bottom: 20, left: 35, top: 20, right: 35),
//                                   child: OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                       primary: Colors.black,
//                                       backgroundColor:
//                                           Color.fromARGB(255, 255, 255, 255),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(Icons.favorite_border , color: Color(0xFFEC441E)),
//                                         SizedBox(width: 10,height: 50,), 
//                                         Text('Save This Trip',
//                                         style: TextStyle(
//                                           color: Color(0xFFEC441E),
//                                         ),),
//                                       ],
//                                     ),
//                                      onPressed: () {
//                                       // Create a new list to store the selected flights
//                                       List<Flight> selectedFlightsToSave = List.from(SelectedFlights.selectedFlights);

//                                       // Add the selected flights to SaveFlights
//                                       SaveFlights.addSaveFlight(selectedFlightsToSave);

//                                       // Clear the selected flights list
//                                       SelectedFlights.selectedFlights.clear();

//                                       // Verify that the lists are not connected
//                                       print("Selected Flights after clearing: ${SelectedFlights.selectedFlights}");
//                                       print("Saved Flights: ${SaveFlights.saveFlights}");

//                                       // Navigate to the TripScreen
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => TripScreen(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                   // Add more widgets as needed
//                 ],
//               ),
//             ),
//             ],
//           ),
//         )
//         ),
//     );
            
//   }


// }