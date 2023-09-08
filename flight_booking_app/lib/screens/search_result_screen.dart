import 'package:flight_booking_app/models/flight.dart';
import 'package:flight_booking_app/models/flight_search_data.dart';
import 'package:flight_booking_app/utilities/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking_app/widgets/flight_suggest.dart';

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
  bool _sortAscending = true; // Default sorting order

  
  @override
  void initState() {
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
    print(widget.searchData.departure);
    print(widget.searchData.arrival);
    print(widget.searchData.departureDate);
    print(widget.searchData.returnDate);
    print(widget.searchData.adultCount);
    print(widget.searchData.cabinClass);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Search result', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Center
      (child: flightSuggestions())
      //(child :Text("test1"))





    );
  }


}