// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_suggest_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flight_booking_app/models/selected_flights.dart';

import '../widgets/popup/flightDetailPopUp.dart';
import '../widgets/xen_popup_card.dart';

class ReturnFlight extends StatefulWidget{
  final returnFlight; // retrive data form flight_search_data

  ReturnFlight({required this.returnFlight});

  @override
  _ReturnFlightState createState() => _ReturnFlightState();
  
}

class _ReturnFlightState extends State<ReturnFlight>{
  // List<Flight> _searchResults = [];
  List<Flight> _searchResultsReturn = [];
  bool _isLoading = false; // to check that can access token
  String _sortingOption = 'Default'; // Default sorting option
  List<Flight> _originalSearchResults = [];
  
  @override
  void initState()   {
    _searchResultsReturn = widget.returnFlight;
    super.initState();
  }
  void _sortResults(String option, List<Flight> sortedResults) {
    setState(() {
      _sortingOption = option;
      _searchResultsReturn = sortedResults;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    print(_searchResultsReturn);
    return  Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 100, // Adjust the height as needed
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: Text("Select Return Flight",style: TextStyle(color: Colors.black),),
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  bottom: AppBar(
                      elevation: 0.0, 
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  title: Container(
                    child : Column(
                      children: [
                        ActionChoiceExample(
                          onSortOptionSelected: _sortResults, 
                          searchResults: _searchResultsReturn, 
                          selectedOption: _sortingOption, 
                          originalSearchResults: _originalSearchResults,
                          ),
                        ],
                    )
                  ),
                ),
              ),
        //      do it later in future
        //          SliverToBoxAdapter(
        //         child: Container(
        //           width: 50,
        //           height: 120,
        //           decoration: BoxDecoration(
        //             border:Border.all()
        //           ),
        //           padding: EdgeInsets.all(8.0),
        //           child: Column(
        //             children: [
        //               Row( // iata city country
        //                 children: [
        //                   SizedBox(height:50),
        //                   Expanded(
        //                     flex: 1,
        //                     child: Column(
        //                       children: [
        //                         Text(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['iataCode'] ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        //                       ],
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 1,
        //                     child: Image(image: AssetImage('assets/images/arrow_airplane.png'))
                            
        //                     ),
        //                   Expanded(
        //                   flex: 1,
        //                   child: Column(
        //                     children: [
        //                     Text(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['iataCode'] ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        //                     ],
        //                   ),
        //                 ),
        //                 ],
        //               ),
        //               Row( // date time
        //                 children: [
        //                   Expanded(
        //                     flex: 1,
        //                     child: Column(
        //                       children: [
        //                         Text( DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['departure']['at'].substring(11))) ,style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),textAlign: TextAlign.left,),
        //                         Text(DateFormat('MMM dd, yyyy').format(DateTime.parse( SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['at'].substring(0,10)))  ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100),textAlign: TextAlign.left,)
        //                       ],
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 1,
        //                     child: SizedBox(width: 20,)
        //                     ),
        //                   Expanded(
        //                   flex: 1,
        //                   child: Column(
        //                     children: [
        //                         Text( DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['at'].substring(11))) ,style: TextStyle(fontSize: 15, fontWeight:FontWeight.bold),textAlign: TextAlign.left,),
        //                         Text(DateFormat('MMM dd, yyyy').format(DateTime.parse( SelectedFlights.selectedFlights[0].itineraries[0]['segments'][0]['arrival']['at'].substring(0,10)))  ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100),textAlign: TextAlign.left,)
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //     ),
        //   ],
        // )
        //         ),
        //       ),             
             
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                      return FlightSuggestList(
                      isReturnScreen: true,
                      flightSuggestions: _searchResultsReturn,
                      flightReturn: _searchResultsReturn,
                      index: index,
                      );
                  },
                  childCount: _searchResultsReturn.length,
                ),
              ),
              
              ],
            ),
            if (_isLoading)
              Center(
                child: Lottie.asset('assets/json/lottie/animation_flight.json')
              ),
            if (_searchResultsReturn.isEmpty && !_isLoading) // Show only if not loading
              Center(
                child: Text("Flight not found"),
              ),
           ],
        ),
      );
  }


}