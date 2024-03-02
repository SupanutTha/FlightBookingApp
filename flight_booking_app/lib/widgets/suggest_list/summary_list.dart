import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/utilities/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flight_booking_app/widgets/popup/flightDetailPopUpSummary.dart';
import '../xen_popup_card.dart';

class SummaryFlightList extends StatelessWidget {
  final Flight selectedFlights;

  SummaryFlightList({required this.selectedFlights});

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
    final flight = selectedFlights;
    List<dynamic> segments = flight.itineraries[0]['segments'];
    int connectingFlight = segments.length;
    String carrierCode = segments[0]['carrierCode'];
    String flightNumber = segments[0]['number'];
    String duration = flight.itineraries[0]['duration'];
    String departureIataCode = segments[0]['departure']['iataCode'];
    String arrivalIataCode = segments[connectingFlight - 1]['arrival']['iataCode'];
    String departureTime = segments[0]['departure']['at'];
    String arrivalTime = segments[connectingFlight - 1]['arrival']['at'];

    return Container(
      width: 414,
      height: 218,
      decoration: BoxDecoration( 
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
         boxShadow : [
          BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.254),
          offset: Offset(0,2),
          blurRadius: 2
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
                Expanded(
                  flex: 3,
                  child: FutureBuilder<String>(
                    future: dbHelper.findLogo(carrierCode),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == 'Unknown') {
                        // Handle the case where there's an error or the logo is unknown.
                        return Text("Unknown airline");
                      } else {
                        return Row(
                          children: [
                            Image.network(
                              snapshot.data!,
                              height: 40,
                            ),
                            Text(
                              ' $carrierCode $flightNumber',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Expanded(flex: 1, child: Text(
                  //calculateDuration(departureTime, arrivalTime)
                  dbHelper.formatDuration(duration)
                  )),
              ],
            ),
            Row(
              children: [
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(departureTime.substring(11))),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(DateTime.parse(departureTime.substring(0, 10))),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(width: 20),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(arrivalTime.substring(11))),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(DateTime.parse(arrivalTime.substring(0, 10))),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (builder) => XenPopupCard(
                    body: FlightDetailPopUpSummary(
                      flight: flight,
                      returnFlight: flight
                      ),
                      ),
                    );
                   
                },
                child: Text('View detail',style: TextStyle(color:Color(0xFFEC441E) ),)),
            )
          ],
        ),
      ),
    );
  }
}
