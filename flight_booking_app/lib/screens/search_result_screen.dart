// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/suggest_list/flight_suggest_list.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget{
  final FlightSearchData searchData; // retrieve data form flight_search_data

  ResultPage({required this.searchData});

  @override
  _ResultPageState createState() => _ResultPageState();
  
}

class _ResultPageState extends State<ResultPage>{
  List<Flight> _searchResults = [];
  List<Flight> _searchResultsReturn = [];
  bool _isLoading = true; // to check that can access token
  String _sortingOption = 'Cheapest'; // Default sorting option
  List<Flight> _originalSearchResults = [];
  
  @override
  void initState()   {
    super.initState();
      _fetchFlightResults();
  }
  void _sortResults(String option, List<Flight> sortedResults) {
    setState(() {
      _sortingOption = option;
      _searchResults = sortedResults;
    });
  }
  Future<void> _fetchFlightResults() async {
    try {
      var searchTuple = await ApiService.searchFlights(widget.searchData);
      _searchResults = searchTuple[0];
      _searchResultsReturn = searchTuple[1];
      _originalSearchResults = List.from(_searchResults);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  title: Text("Search Result",style: TextStyle(color: Colors.black),),
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  bottom: AppBar(
                      elevation: 0.0, 
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  title: Container(
                    child : ActionChoiceExample(
                      onSortOptionSelected: _sortResults, 
                      searchResults: _searchResults, 
                      originalSearchResults: _originalSearchResults,
                      selectedOption: _sortingOption,
                      )
                  ),
                ),
              ),
              
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                      return FlightSuggestList(
                      flightSuggestions: _searchResults,
                      flightReturn: _searchResultsReturn,
                      index: index, 
                      isReturnScreen: false,
                      );
                  },
                  childCount: _searchResults.length,
                ),
              ),
              ],
            ),
            if (_isLoading)
              Center(
                child: Lottie.asset('assets/json/lottie/animation_flight.json')
              ),
            if (_searchResults.isEmpty && !_isLoading) // Show only if not loading
              Center(
                child: Text("Flight not found"),
              ),
           ],
        ),
      );
  }


}