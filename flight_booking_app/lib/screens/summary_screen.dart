// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/models/selected_flights.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_detail_list.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_suggest_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SummaryFlight extends StatefulWidget{

  @override
  _SummaryFlightState createState() => _SummaryFlightState();
  
}

class _SummaryFlightState extends State<SummaryFlight>{

  @override
  void initState()   {
    super.initState();
  }
  
  final dbHelper = DatabaseHelper.instance;
  int connectingFlight =SelectedFlights.selectedFlights[0].itineraries[0]['segments'].length;
  @override
  Widget build(BuildContext context) {
    
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
          elevation: 0.5, 
          backgroundColor: Colors.white,
          title: Text("Trip Summary",style: TextStyle(color: Colors.black),),
                    iconTheme: IconThemeData(
                      color: Colors.black
                    ),
        ),
        body: Column(
                 children :[
                  SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(height: 50),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']
                                    ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,),
                                  FutureBuilder<String>(
                                    future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image(image: AssetImage('assets/images/arrow_airplane.png')),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    SelectedFlights.selectedFlights[0].itineraries[0]['segments'][connectingFlight-1]['arrival']['iataCode'] ,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
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
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                                  Expanded(
               child: ListView.builder(
              itemCount: connectingFlight,
              itemBuilder: (BuildContext context, int index) {
                var segment =  SelectedFlights.selectedFlights[0].itineraries[0]['segments'][index];
                //print('${index} ${segment}');
                String departureTime = segment['departure']['at']; //
                String arrivalTime = segment['arrival']['at']; //2023-09-19T05:55:00
                
                 String? waitingTime;
                  if (index < connectingFlight - 1) {
                    DateTime currentFlightArrival = DateTime.parse(arrivalTime);
                    DateTime nextFlightDeparture = DateTime.parse( SelectedFlights.selectedFlights[0].itineraries[0]['segments'][index + 1]['departure']['at']);
                    Duration difference = nextFlightDeparture.difference(currentFlightArrival);
                    waitingTime = '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
                  }
    
                  return Column(
                    children: [
                      FlightDetailList(
                        segment: segment,
                      ),
                      if (waitingTime != null) // Display waiting time
                        Padding(
                          padding: const EdgeInsets.only(top: 8,left:40,bottom: 8 ),
                          child: Row(
                            children: [
                              Icon(Icons.hourglass_bottom),
                              Text(
                                'Connection Time: $waitingTime',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ]
                  );
                // return FlightDetailList(
                //   segment: segment,
                // );
              },
              ),
    
            ),
            SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(height: 50),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    SelectedFlights.selectedFlights[1].itineraries[0]['segments'][0]['departure']['iataCode']
                                    ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,),
                                  FutureBuilder<String>(
                                    future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image(image: AssetImage('assets/images/arrow_airplane.png')),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    SelectedFlights.selectedFlights[1].itineraries[0]['segments'][connectingFlight-1]['arrival']['iataCode'] ,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                  FutureBuilder<String>(
                                    future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[1].itineraries[0]['segments'][connectingFlight-1]['arrival']['iataCode'] ),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                                  Expanded(
               child: ListView.builder(
              itemCount: connectingFlight,
              itemBuilder: (BuildContext context, int index) {
                var segment =  SelectedFlights.selectedFlights[1].itineraries[0]['segments'][index];
                //print('${index} ${segment}');
                String departureTime = segment['departure']['at']; //
                String arrivalTime = segment['arrival']['at']; //2023-09-19T05:55:00
                
                 String? waitingTime;
                  if (index < connectingFlight - 1) {
                    DateTime currentFlightArrival = DateTime.parse(arrivalTime);
                    DateTime nextFlightDeparture = DateTime.parse( SelectedFlights.selectedFlights[0].itineraries[0]['segments'][index + 1]['departure']['at']);
                    Duration difference = nextFlightDeparture.difference(currentFlightArrival);
                    waitingTime = '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
                  }
    
                  return Column(
                    children: [
                      FlightDetailList(
                        segment: segment,
                      ),
                      if (waitingTime != null) // Display waiting time
                        Padding(
                          padding: const EdgeInsets.only(top: 8,left:40,bottom: 8 ),
                          child: Row(
                            children: [
                              Icon(Icons.hourglass_bottom),
                              Text(
                                'Connection Time: $waitingTime',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ]
                  );
                // return FlightDetailList(
                //   segment: segment,
                // );
              },
              ),
    
            ),
    
                      ]
                    ),
                  ),
    );
            
    // return  Scaffold(
    //   backgroundColor: Colors.white,
    //     body: Stack(
    //       children: [
    //         CustomScrollView(
    //           slivers: [
    //             SliverAppBar(
    //               expandedHeight: 100, // Adjust the height as needed
    //               floating: false,
    //               pinned: true,
    //               backgroundColor: Colors.white,
    //               title: Text("Trip Summary",style: TextStyle(color: Colors.black),),
    //               iconTheme: IconThemeData(
    //                 color: Colors.black
    //               ),
    //               bottom: AppBar(
    //                   elevation: 0.0, 
    //               automaticallyImplyLeading: false,
    //               backgroundColor: Color.fromARGB(255, 255, 255, 255),
    //               title: Column(
    //                 children :[
    //                   Row(
    //                     children: [
    //                       SizedBox(height: 50),
    //                       Expanded(
    //                         flex: 1,
    //                         child: Column(
    //                           children: [
    //                             Text(
    //                               SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']
    //                               ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,),
    //                             FutureBuilder<String>(
    //                               future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode']),
    //                               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //                                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                                   return CircularProgressIndicator();
    //                                 } else if (snapshot.hasError) {
    //                                   return Text('Error: ${snapshot.error}');
    //                                 } else {
    //                                   return Text(
    //                                     '${snapshot.data}',
    //                                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
    //                                   );
    //                                 }
    //                               },
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 1,
    //                         child: Image(image: AssetImage('assets/images/arrow_airplane.png')),
    //                       ),
    //                       Expanded(
    //                         flex: 1,
    //                         child: Column(
    //                           children: [
    //                             Text(
    //                               SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['iataCode'] ,
    //                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
    //                               textAlign: TextAlign.left,
    //                             ),
    //                             FutureBuilder<String>(
    //                               future: dbHelper.findCityAndCountry(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['iataCode'] ),
    //                               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //                                 if (snapshot.connectionState == ConnectionState.waiting) {
    //                                   return CircularProgressIndicator();
    //                                 } else if (snapshot.hasError) {
    //                                   return Text('Error: ${snapshot.error}');
    //                                 } else {
    //                                   return Text(
    //                                     '${snapshot.data}',
    //                                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100,color: Colors.black),
    //                                   );
    //                                 }
    //                               },
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
                      
    //                 ]
    //               ),
    //             ),
    //           ),
              
    //           // SliverList(
    //           //   delegate: SliverChildBuilderDelegate(
    //           //     (BuildContext context, int index) {
    //           //         return FlightSuggestList(
    //           //         isReturnScreen: true,
    //           //         flightSuggestions: _searchResultsReturn,
    //           //         flightReturn: _searchResultsReturn,
    //           //         index: index,
    //           //         );
    //           //     },
    //           //     childCount: _searchResultsReturn.length,
    //           //   ),
    //           // ),
    //           ],
    //         ),
    //        ],
    //     ),
    //   );
  
  }


}