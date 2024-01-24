import 'package:flight_booking_app/models/selected_flights.dart';
import 'package:flight_booking_app/screens/return_flight_screen.dart';
import 'package:flight_booking_app/screens/trip_summary2.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_detail_list.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';

class FlightDetailPopUp extends StatefulWidget {
  final dynamic flight;
  final bool isReturn;
  final dynamic returnFlight;

  const FlightDetailPopUp({
    Key? key,
    required this.flight, this.returnFlight, required this.isReturn,
  }) : super(key: key);

  @override
  _FlightDetailPopUpState createState() => _FlightDetailPopUpState();
}

class _FlightDetailPopUpState extends State<FlightDetailPopUp> {
  final dbHelper = DatabaseHelper.instance;


  @override
  Widget build(BuildContext context) {
    List<dynamic> segments = widget.flight.itineraries[0]['segments'];
    int connectingFlight = segments.length;
    String departureIataCode = segments[0]['departure']['iataCode'];
    String arrivalIataCode = segments[connectingFlight - 1]['arrival']['iataCode'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Flight Detail',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 50),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      departureIataCode,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    FutureBuilder<String>(
                      future: dbHelper.findCityAndCountry(departureIataCode),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
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
                      arrivalIataCode,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    FutureBuilder<String>(
                      future: dbHelper.findCityAndCountry(arrivalIataCode),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
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
          Expanded(
             child: ListView.builder(
            itemCount: connectingFlight,
            itemBuilder: (BuildContext context, int index) {
              var segment = segments[index];
              //print('${index} ${segment}');
              String departureTime = segment['departure']['at']; //
              String arrivalTime = segment['arrival']['at']; //2023-09-19T05:55:00
              
               String? waitingTime;
                if (index < connectingFlight - 1) {
                  DateTime currentFlightArrival = DateTime.parse(arrivalTime);
                  DateTime nextFlightDeparture = DateTime.parse(segments[index + 1]['departure']['at']);
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
                  Icon(Icons.airplane_ticket , color: Colors.white,),
                  SizedBox(height: 55,), 
                  Text(' Select Flight',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),),
                ],
              ),
              onPressed: (){
                Navigator.of(context).pop();
                                    SelectedFlights.addSelectedFlight(widget.flight);
                                    if(widget.returnFlight.length != 0 && widget.isReturn == false){
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReturnFlight(
                                           returnFlight: widget.returnFlight,)
                                        ),
                                    );
                                    }
                                    else if (
                                      widget.isReturn || widget.returnFlight.length == 0
                                    ){
                                        Navigator.push(
                                      context,
                                       MaterialPageRoute(
                                        builder: (context) => SummaryFlight2()
                                        ),
                                      );
                                    }
              }
            ),
        ],
      ),
    );
  }
}
