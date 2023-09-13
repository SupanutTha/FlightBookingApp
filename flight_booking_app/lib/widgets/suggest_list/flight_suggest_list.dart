// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_booking_app/models/airline_db.dart';
import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:flight_booking_app/widgets/dynamic_text_button.dart';
import 'package:flight_booking_app/widgets/popup/flightDetailPopUp.dart';
import 'package:flight_booking_app/widgets/xen_popup/xen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../xen_popup/xen_card.dart';

class FlightSuggestList extends StatelessWidget {
  final List<Flight> flightSuggestions;
  final List<Flight> flightReturn;
  final bool isReturnScreen;
  final int index;

  FlightSuggestList({required this.flightSuggestions, required this.index, required this.flightReturn, required this.isReturnScreen});


  String calculateDuration(String departureTime, String arrivalTime) {
  DateTime departureDateTime = DateTime.parse(departureTime);
  DateTime arrivalDateTime = DateTime.parse(arrivalTime);
  
  Duration duration = arrivalDateTime.difference(departureDateTime);
  
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  
  return '$hours hr $minutes min';
}


  final dbHelper = DatabaseHelper.instance;
 
  @override
  Widget build(BuildContext context) {
    final flight = flightSuggestions[index];
    List<dynamic> segments = flight.itineraries[0]['segments'];
              int connectingFlight = segments.length;
                String carrierCode = segments[0]['carrierCode'];
                String flightNumber = segments[0]['number'];
                String duration = flight.itineraries[0]['duration'];
                String departureIataCode = segments[0]['departure']['iataCode'];
                String arrivalIataCode = segments[connectingFlight-1]['arrival']['iataCode'];
                String departureTime = segments[0]['departure']['at'];
                String arrivalTime = segments[connectingFlight-1]['arrival']['at'];
              List<String> result = [carrierCode,flightNumber,duration,departureIataCode,arrivalIataCode,departureTime,arrivalTime];
    return Container(
    padding: EdgeInsets.only(top: 15),
    alignment: Alignment.topCenter,
    child: Container(
      width: 400,
      height: 280,
      decoration: BoxDecoration( 
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
         boxShadow : [
          BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
          offset: Offset(0,2),
          blurRadius: 4
        )],
        color : Color.fromRGBO(255, 255, 255, 1),
        border : Border.all(
          color: Color.fromRGBO(0, 0, 0, 1),
          width: 1,
          style: BorderStyle.none
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(height: 50),
                Expanded(
                    flex: 3,
                    child: FutureBuilder<String>(
                      future: dbHelper.findLogo(result[0]),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError || snapshot.data == 'Unknown') {
                          // Handle the case where there's an error or logo is unknown.
                          return Text("Unknow airline");
                        } else {
                          return Row(
                            children: [
                              Image.network(snapshot.data!,height: 40,),
                              Text(
                                ' ${result[0]} ${flightNumber}',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                Expanded(flex :1 ,child: Text(calculateDuration(departureTime, arrivalTime)
))
              ],
            ),
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
            Row( // date time
              children: [
                SizedBox(height:35),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text( DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(departureTime.substring(11))) ,style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),textAlign: TextAlign.left,),
                      Text(DateFormat('MMM dd, yyyy').format(DateTime.parse( departureTime.substring(0,10)))  ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100),textAlign: TextAlign.left,)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(width: 20,)
                  ),
                Expanded(
                flex: 1,
                child: Column(
                  children: [
                      Text( DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(arrivalTime.substring(11))) ,style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),textAlign: TextAlign.left,),
                      Text(DateFormat('MMM dd, yyyy').format(DateTime.parse( arrivalTime.substring(0,10)))  ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100),textAlign: TextAlign.left,)
                  ],
                ),
              ),
              
              ],
            ),
            
            Divider(),
            Row(
              children: [
                SizedBox(height: 40),
                Expanded(flex: 5, child: Text('${(flight.travelerPricings[0]['fareDetailsBySegment'][0]['cabin'][0]).toUpperCase()+(flight.travelerPricings[0]['fareDetailsBySegment'][0]['cabin']).substring(1).toLowerCase()} class')),
                Expanded(flex :2 ,child: Row(
                  children: [
                    Text("Price"),
                    Text(' \$${double.parse(flight.price['grandTotal']).toInt()}' ,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),)
                  ],
                ))
              ],
            ),
            //DynamicTextButton(textController: '', buttonText: "Check Flight", icon: Icons.check, buttonAction: FlightDetailPopUp())
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor:
                    const Color(0xFFEC441E),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(Icons.search , color: Colors.white,),
                  SizedBox(height: 55,), 
                  Text('Check Flight',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),),
                ],
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (builder) => XenPopupCard(
                  body: FlightDetailPopUp(
                    flight: flight,
                    returnFlight: flightReturn,
                    isReturn: isReturnScreen,
                    ),
                    ),
                  );
                 
              },
            ),
          ],
        ),
      ),
  )
  );
}
}