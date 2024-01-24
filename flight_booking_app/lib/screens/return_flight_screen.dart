// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_suggest_list.dart';
import 'package:lottie/lottie.dart';
import 'package:flight_booking_app/models/selected_flights.dart';

class ReturnFlight extends StatefulWidget{
  final returnFlight; // retrieve data form flight_search_data

  ReturnFlight({required this.returnFlight});

  @override
  _ReturnFlightState createState() => _ReturnFlightState();
  
}

class _ReturnFlightState extends State<ReturnFlight>{
  // List<Flight> _searchResults = [];
  List<Flight> _searchResultsReturn = [];
  bool _isLoading = false; // to check that can access token
  String _sortingOption = 'Cheapest'; // Default sorting option
  List<Flight> _originalSearchResults = [];
  
  @override
  void initState()   {
    _searchResultsReturn = widget.returnFlight;
     _originalSearchResults = List.from(_searchResultsReturn);
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
    return  WillPopScope(
      onWillPop: () async {
        SelectedFlights.removeSelectedFlight(SelectedFlights.selectedFlights[SelectedFlights.selectedFlights.length-1]); // Clear selected flights when user clicks back button
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
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
        ),
    );
  }


}