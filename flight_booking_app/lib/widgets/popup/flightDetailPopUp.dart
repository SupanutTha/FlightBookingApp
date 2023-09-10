// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';

class FlightDetailPopUp extends StatefulWidget {
  final flight;
  // final TextEditingController controller;
  // final Function callback;
  const FlightDetailPopUp({
    super.key, this.flight,
    // required this.controller,
    // required this.callback
  });

  @override
  _FlightDetailPopUpState createState() => _FlightDetailPopUpState();
}

class _FlightDetailPopUpState extends State<FlightDetailPopUp> {

  void initState(){
    super.initState();
    //selectedClass = widget.controller.text;
  }
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    List<dynamic> segments = widget.flight.itineraries[0]['segments'];
              int connectingFlight = segments.length;
                String carrierCode = segments[0]['carrierCode'];
                String flightNumber = segments[0]['number'];
                String duration = widget.flight.itineraries[0]['duration'];
                String departureIataCode = segments[0]['departure']['iataCode'];
                String arrivalIataCode = segments[connectingFlight-1]['arrival']['iataCode'];
                String departureTime = segments[0]['departure']['at'];
                String arrivalTime = segments[connectingFlight-1]['arrival']['at'];
              List<String> result = [carrierCode,flightNumber,duration,departureIataCode,arrivalIataCode,departureTime,arrivalTime];
  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Flight Detail',
        style: TextStyle(color: Colors.black),),
         iconTheme: IconThemeData(
                  color: Colors.black,
                ),
      ),
      body: Column(
        children: [
           Row( // iata city country
              children: [
                SizedBox(height:50),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(departureIataCode ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                      FutureBuilder<String>(
                      future: dbHelper.findCityAndCountry(departureIataCode),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Display a loading indicator while waiting.
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}', // Combine the city and country.
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                          );
                        }
                        },
                      ) 
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image(image: AssetImage('assets/images/arrow_airplane.png'))
                  
                  ),
                Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(arrivalIataCode ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    FutureBuilder<String>(
                      future: dbHelper.findCityAndCountry(arrivalIataCode),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Display a loading indicator while waiting.
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}', // Combine the city and country.
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                          );
                        }
                        },
                      ) 
                  ],
                ),
              ),
              
              ],
            ),
            
        ],
      ),
    );
  }
}
