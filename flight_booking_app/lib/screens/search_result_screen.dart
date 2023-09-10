// ignore_for_file: prefer_const_constructors

import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flight_booking_app/widgets/chip_select.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/flight_suggest.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget{
  final FlightSearchData searchData; // retrive data form flight_search_data

  ResultPage({required this.searchData});

  @override
  _ResultPageState createState() => _ResultPageState();
  
}

class _ResultPageState extends State<ResultPage>{
  List<Flight> _searchResults = [];
  List<Flight> _searchResultsReturn = [];
  bool _isLoading = true; // to check that can access token
  String _sortingOption = 'Default'; // Default sorting option

  
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
      _searchResults = searchTuple.$1;
      _searchResultsReturn = searchTuple.$2;
      print('1 $_searchResults');
      print('2 $_searchResultsReturn');
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    print(_searchResults);
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
                      index: index,
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